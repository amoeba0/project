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
        @hit_role = 0 #スロットが揃った目の役
        @isForceSlotHit = false
        @slotSet()
        @debugSlot()
        @upperFrame = new UpperFrame()
        @addChild(@upperFrame)
    onenterframe: (e) ->
        @slotStopping()

    ###
    スロットが一定の時間差で連続で停止する
    ###
    slotStopping: ()->
        if @isStopping is true
            if @age is @stopStartAge
                @forceHitStart()
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
                @forceHitEnd()
                @isStopping = false
                @slotHitTest()

    ###
    左のスロットが当たった目を記憶する
    ###
    saveLeftSlotEye:()->
        @leftSlotEye = @left_lille.lilleArray[@left_lille.nowEye]

    forceHitStart:()->
        if game.slot_setting.isForceSlotHit is true
            @isForceSlotHit = true

    forceHitEnd:()->
        @isForceSlotHit = false

    ###
    確率でスロットを強制的に当たりにする
    ###
    forceHit:(target)->
        if @isForceSlotHit is true
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
    スロットの当選判定をして当たった時の処理を流す
    ###
    slotHitTest: () ->
        if @_isSlotHit() is true
            game.sePlay(@slot_hit_se)
            @hit_role = @left_lille.lilleArray[@left_lille.nowEye]
            prize_money = game.slot_setting.calcPrizeMoney(@middle_lille.lilleArray[@middle_lille.nowEye])
            game.tensionSetValueSlotHit(prize_money, @hit_role)
            @_feverStart(@hit_role)
            if @hit_role is 1
                member = game.slot_setting.now_muse_num
                @slotAddMuse(member)
            else
                game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            if game.slot_setting.isForceSlotHit is true
                @endForceSlotHit()

    ###
    スロットの当選判定をする
    true:３つとも全て同じ目、または、３つとも全てμ’s
    ###
    _isSlotHit:()->
        left = @left_lille.lilleArray[@left_lille.nowEye]
        middle = @middle_lille.lilleArray[@middle_lille.nowEye]
        right = @right_lille.lilleArray[@right_lille.nowEye]
        hit_flg = false
        if left is middle is right
            hit_flg = true
            @hit_role = left
        else if left > 10 && middle > 10 && right > 10
            hit_flg = true
            @hit_role = game.slot_setting.getHitRole(left, middle, right)
        if @hit_role > 10
            game.prev_fever_muse.push(@hit_role)
            game.slot_setting.setMemberItemPrice()
        return hit_flg

    ###
    フィーバーを開始する
    ###
    _feverStart:(hit_eye)->
        if hit_eye > 10 && game.fever is false
            game.fever = true
            game.past_fever_num += 1
            game.slot_setting.setMuseMember()
            game.musePreLoad()
            game.fever_hit_eye = hit_eye
            game.main_scene.gp_system.changeBetChangeFlg(false)
            game.main_scene.gp_effect.feverEffectSet()
            @slotAddMuseAll(hit_eye)
            @_feverBgmStart(hit_eye)

    ###
    フィーバー中のBGMを開始する
    ###
    _feverBgmStart:(hit_eye)->
        bgm = @_getFeverBgm(hit_eye)
        @feverSec = bgm['time']
        @fever_bgm = game.soundload('bgm/'+bgm['name'])
        game.fever_down_tension = Math.round(game.slot_setting.tension_max * 100 / (@feverSec * game.fps)) / 100
        game.fever_down_tension *= -1
        game.bgmPlay(@fever_bgm, false)

    ###
    揃った目の役からフィーバーのBGMを返す
    ###
    _getFeverBgm:(hit_role)->
        if hit_role <= 19
            material = game.slot_setting.muse_material_list
        else
            material = game.slot_setting.unit_material_list
        if material[hit_role] is undefined
            hit_role = 20
        bgms = material[hit_role]['bgm']
        random = Math.floor(Math.random() * bgms.length)
        return bgms[random]

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
    リールの音ノ木坂学院校章のどこかにμ’sの誰かを挿入
    スロットが音ノ木坂学院校章で止まったときに実行
    @param number num メンバーの指定
    ###
    slotAddMuse:(num)->
        @left_lille.lilleArray = @_slotAddMuseUnit(num, @left_lille)
        @middle_lille.lilleArray = @_slotAddMuseUnit(num, @middle_lille)
        @right_lille.lilleArray = @_slotAddMuseUnit(num, @right_lille)
        game.main_scene.gp_effect.cutInSet()

    ###
    リールにμ’sの誰かを挿入(単体)
    @param number num   メンバーの指定
    @param array  lille リール
    ###
    _slotAddMuseUnit:(num, lille)->
        arr = []
        for key, val of lille.lilleArray
            if val is 1
                arr.push(key)
        if arr.length > 0
            random_key = Math.floor(arr.length * Math.random())
            add_num = arr[random_key]
            lille.lilleArray[add_num] = num
        return lille.lilleArray

    ###
    リールの音ノ木坂学院校章の全てにμ’sの誰かを挿入
    フィーバー開始時に実行
    @param number num メンバーの指定
    ###
    slotAddMuseAll:(num)->
        @left_lille.lilleArray = @_slotAddMuseAllUnit(num, @left_lille)
        @middle_lille.lilleArray = @_slotAddMuseAllUnit(num, @middle_lille)
        @right_lille.lilleArray = @_slotAddMuseAllUnit(num, @right_lille)

    _slotAddMuseAllUnit:(num, lille)->
        for key, val of lille.lilleArray
            if val is 1
                lille.lilleArray[key] = num
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

    ###
    スロットの強制当たりを開始する
    ###
    startForceSlotHit:()->
        @upperFrame.frame = 1
        game.main_scene.gp_system.changeBetChangeFlg(false)
        if game.fever is false
            game.main_scene.gp_effect.chanceEffectSet()

    ###
    スロットの強制当たりを終了する
    ###
    endForceSlotHit:()->
        if game.fever is false && game.slot_setting.isForceSlotHit is true
            @upperFrame.frame = 0
            game.main_scene.gp_system.changeBetChangeFlg(true)
            game.slot_setting.isForceSlotHit = false