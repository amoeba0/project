class gpSlot extends appGroup
    constructor: () ->
        super
        @debugSlot()
        @underFrame = new UnderFrame()
        @addChild(@underFrame)
        @isStopping = false #スロット停止中
        @stopIntervalFrame = 9 #スロットが連続で止まる間隔（フレーム）
        @slotIntervalFrameRandom = 0
        @stopStartAge = 0 #スロットの停止が開始したフレーム
        @leftSlotEye = 0 #左のスロットが当たった目
        @slotSet()
    onenterframe: (e) ->
        @slotStopping()

    ###
    スロットが一定の時間差で連続で停止する
    ###
    slotStopping: ()->
        if @isStopping is true
            if @age is @stopStartAge
                @left_lille.isRotation = false
                @saveLeftSlotEye()
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame + @slotIntervalFrameRandom
                @middle_lille.isRotation = false
                @forceHit(@middle_lille)
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame * 2 + @slotIntervalFrameRandom
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
            prize_money = @_calcPrizeMoney()
            game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            game.tensionSetValueSlotHit(prize_money)
        else
            if game.slot_setting.isAddMuse() is true
                member = game.slot_setting.now_muse_num
                num = game.slot_setting.setMuseNum()
                @slotAddMuse(member, num)

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
    ###
    _slotLilleChangeUnit:(target, change, isMuseDel)->
        arr = []
        if isMuseDel is false
            for key, val of target.lilleArray
                if val > 10
                    arr.push(key)
            if arr.length > 0
                for key, val of arr
                    change[key] = target.lilleArray[key]
        return change


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
            game.slot_setting.lille_array = game.debug.lille_array