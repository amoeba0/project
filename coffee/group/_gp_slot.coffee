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
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame + @slotIntervalFrameRandom
                @middle_lille.isRotation = false
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame * 2 + @slotIntervalFrameRandom
                @right_lille.isRotation = false
                @isStopping = false
                @slotHitTest()

    ###
    スロットの当選判定
    ###
    slotHitTest: () ->
        if @left_lille.lilleArray[@left_lille.nowEye] is @middle_lille.lilleArray[@middle_lille.nowEye] is @right_lille.lilleArray[@right_lille.nowEye]
            prize_money = @_calcPrizeMoney()
            game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            game.tensionSetValueSlotHit(prize_money)

    ###
    スロットの当選金額を計算
    ###
    _calcPrizeMoney: () ->
        ret_money = 0
        eye = @middle_lille.lilleArray[@middle_lille.nowEye]
        ret_money = game.bet * game.slot_setting.bairitu[eye]
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