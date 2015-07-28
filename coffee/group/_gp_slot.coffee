class gpSlot extends appGroup
    constructor: () ->
        super
        @underFrame = new UnderFrame()
        @addChild(@underFrame)
        @lille_stop_se = game.soundload('dicision')
        @slot_hit_se = game.soundload('start')
        @fever_bgm = game.soundload('bgm/zenkai_no_lovelive')
        @isStopping = false #スロット停止中
        @stopIntervalFrame = 9 #スロットが連続で止まる間隔（フレーム）
        @slotIntervalFrameRandom = 0
        @stopStartAge = 0 #スロットの停止が開始したフレーム
        @leftSlotEye = 0 #左のスロットが当たった目
        @feverSec = 0 #フィーバーの時間
        @slotSet()
        @debugSlot()
    onenterframe: (e) ->
        @slotStopping()

    ###
    スロットが一定の時間差で連続で停止する
    ###
    slotStopping: ()->
        if @isStopping is true
            if @age is @stopStartAge
                game.sePlay(@lille_stop_se)
                @left_lille.isRotation = false
                @saveLeftSlotEye()
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame + @slotIntervalFrameRandom
                game.sePlay(@lille_stop_se)
                @middle_lille.isRotation = false
                @forceHit(@middle_lille)
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame * 2 + @slotIntervalFrameRandom
                game.sePlay(@lille_stop_se)
                @right_lille.isRotation = false
                @forceHit(@right_lille)
                @isStopping = false
                @slotHitTest()

    ###
    左のスロットが当たった目を記憶する
    ###
    saveLeftSlotEye:()->
        @leftSlotEye = @left_lille.lilleArray[@left_lille.nowEye]

    ###
    確率でスロットを強制的に当たりにする
    ###
    forceHit:(target)->
        if game.slot_setting.getIsForceSlotHit() is true
            tmp_eye = @_searchEye(target)
            if tmp_eye != 0
                target.nowEye = tmp_eye
                target.frameChange()

    _searchEye:(target)->
        result = 0
        for key, val of target.lilleArray
            if result is 0 && val is @leftSlotEye
                result = key
        return result


    ###
    スロットの当選判定
    ###
    slotHitTest: () ->
        if @left_lille.lilleArray[@left_lille.nowEye] is @middle_lille.lilleArray[@middle_lille.nowEye] is @right_lille.lilleArray[@right_lille.nowEye]
            game.sePlay(@slot_hit_se)
            hit_eye = @left_lille.lilleArray[@left_lille.nowEye]
            prize_money = @_calcPrizeMoney()
            game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            game.tensionSetValueSlotHit(prize_money, hit_eye)
            @_feverStart(hit_eye)
        else
            if game.slot_setting.isAddMuse() is true
                member = game.slot_setting.now_muse_num
                @slotAddMuse(member, 1)

    ###
    フィーバーを開始する
    ###
    _feverStart:(hit_eye)->
        if hit_eye > 10 && game.fever is false
            game.fever = true
            game.past_fever_num += 1
            game.slot_setting.setMuseMember()
            game.musePreLoad()
            @_feverBgmStart(hit_eye)

    ###
    フィーバー中のBGMを開始する
    ###
    _feverBgmStart:(hit_eye)->
        bgms = game.slot_setting.muse_material_list[hit_eye]['bgm']
        random = Math.floor(Math.random() * bgms.length)
        bgm = bgms[random]
        @feverSec = bgm['time']
        @fever_bgm = game.soundload('bgm/'+bgm['name'])
        game.fever_down_tension = Math.round(game.slot_setting.tension_max * 100 / (@feverSec * game.fps)) / 100
        game.fever_down_tension *= -1
        game.bgmPlay(@fever_bgm, false)

    ###
    スロットの当選金額を計算
    ###
    _calcPrizeMoney: () ->
        ret_money = 0
        eye = @middle_lille.lilleArray[@middle_lille.nowEye]
        ret_money = game.bet * game.slot_setting.bairitu[eye]
        if ret_money > 10000000000
            ret_money = 10000000000
        return ret_money

    ###
    スロットマシンを画面に設置する
    ###
    slotSet: () ->
        @left_lille = new LeftLille()
        @addChild(@left_lille)
        @middle_lille = new MiddleLille()
        @addChild(@middle_lille)
        @right_lille = new RightLille()
        @addChild(@right_lille)

    ###
    リールを指定のリールに変更する
    @param array   lille     リール
    @param boolean isMuseDel μ’sは削除する
    ###
    slotLilleChange:(lille, isMuseDel)->
        @left_lille.lilleArray = @_slotLilleChangeUnit(@left_lille, lille[0], isMuseDel)
        @middle_lille.lilleArray = @_slotLilleChangeUnit(@middle_lille, lille[1], isMuseDel)
        @right_lille.lilleArray = @_slotLilleChangeUnit(@right_lille, lille[2], isMuseDel)

    ###
    リールを指定のリールに変更する（単体）
    リールにμ’sの誰かがいればそのまま残す
    @param array target 変更対象
    @param array change 変更後
    @param boolean isMuseDel μ’sは削除する
    ###
    _slotLilleChangeUnit:(target, change, isMuseDel)->
        arr = []
        return_arr = []
        return_arr = game.arrayCopy(change)
        if isMuseDel is false
            for key, val of target.lilleArray
                if val > 10
                    arr.push(key)
            if arr.length > 0
                for arr_key, arr_val of arr
                    return_arr[arr_val] = target.lilleArray[arr_val]
        return return_arr


    ###
    リールにμ’sの誰かを挿入
    スロットが止まってハズレだったときに確率で実行
    @param number num メンバーの指定
    @param number cnt 人数の指定
    ###
    slotAddMuse:(num, cnt)->
        @left_lille.lilleArray = @_slotAddMuseUnit(num, cnt, @left_lille)
        @middle_lille.lilleArray = @_slotAddMuseUnit(num, cnt, @middle_lille)
        @right_lille.lilleArray = @_slotAddMuseUnit(num, cnt, @right_lille)
        game.main_scene.gp_effect.cutInSet()

    ###
    リールにμ’sの誰かを挿入(単体)
    @param number num   メンバーの指定
    @param number cnt   人数の指定
    @param array  lille リール
    ###
    _slotAddMuseUnit:(num, cnt, lille)->
        arr = []
        for i in [1..cnt]
            for key, val of lille.lilleArray
                if val < 10
                    arr.push(key)
            if arr.length > 0
                random_key = Math.floor(arr.length * Math.random())
                add_num = arr[random_key]
                lille.lilleArray[add_num] = num
        return lille.lilleArray

    ###
    スロットマシンの回転を始める
    ###
    slotStart: () ->
        @left_lille.isRotation = true
        @middle_lille.isRotation = true
        @right_lille.isRotation = true

    ###
    スロットマシンの回転を止める
    ###
    slotStop:() ->
        @stopStartAge = @age
        @isStopping = true
        @setIntervalFrame()
        @slotStopping()

    ###
    スロットマシン止まる間隔を決める
    ###
    setIntervalFrame:() ->
        @slotIntervalFrameRandom = Math.floor(Math.random() * 3)

    ###
    デバッグ用スロットにすりかえる
    ###
    debugSlot:() ->
        if game.debug.lille_flg is true
            @left_lille.lilleArray = game.arrayCopy(game.debug.lille_array[0])
            @middle_lille.lilleArray = game.arrayCopy(game.debug.lille_array[1])
            @right_lille.lilleArray = game.arrayCopy(game.debug.lille_array[2])