class gpSlot extends appGroup
    constructor: () ->
        super
        @underFrame = new UnderFrame()
        @addChild(@underFrame)
        @isStopping = false #スロット停止中
        @stopIntervalFrameInit = 9
        @stopIntervalFrame = 0 #スロットが連続で止まる間隔（フレーム）
        @stopStartAge = 0 #スロットの停止が開始したフレーム
        @slotSet()
        #@slotStart()
    onenterframe: (e) ->
        @slotStopping()

    ###
    スロットが一定の時間差で連続で停止する
    ###
    slotStopping: ()->
        if @isStopping is true
            if @age is @stopStartAge
                @left_lille.isRotation = false
            if @age is @stopStartAge + @stopIntervalFrame
                @middle_lille.isRotation = false
            if @age is @stopStartAge + @stopIntervalFrame * 2
                @right_lille.isRotation = false
                @isStopping = false

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
        @stopIntervalFrame = @stopIntervalFrameInit + @age % 3
        @stopStartAge = @age
        @isStopping = true
        @slotStopping()