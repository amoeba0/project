class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 900 #床の位置

###
ステージ前面
プレイヤーや落下アイテムがある
###
class stageFront extends gpStage
    constructor: () ->
        super
        @itemFallSec = 5 #アイテムを降らせる周期（秒）
        @catchItems = [] #キャッチアイテムのインスタンスを格納
        @nowCatchItemsNum = 0
        @initial()
    initial:()->
        @setPlayer()
    onenterframe: () ->
        @_stageCycle()
    setPlayer:()->
        @player = new Bear()
        @player.y = @floor
        @addChild(@player)
    ###
    一定周期でステージに発生するイベント
    ###
    _stageCycle:()->
        if game.debug.item_fall_early_flg is true
            @itemFallSec = 3
        if @age % (game.fps * @itemFallSec) is 0
            @_catchFall()
    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        if (game.money >= game.bet)
            @catchItems.push(new MacaroonCatch())
            @addChild(@catchItems[@nowCatchItemsNum])
            @catchItems[@nowCatchItemsNum].setPosition(1)
            @nowCatchItemsNum += 1
            game.money -= game.bet
            game.main_scene.gp_system.money_text.setValue()
            game.main_scene.gp_slot.slotStart()

###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsInstance = [] #スロット当選金のインスタンスを格納
        @prizeMoneyItemsNum = {1:0,10:0,100:0,1000:0} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 4 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
    onenterframe: () ->
        @_moneyFall()
    ###
    スロットの当選金を降らせる
    @param value number 金額
    ###
    fallPrizeMoneyStart:(value) ->
        @_calcPrizeMoneyItemsNum(value)
        @_setPrizeMoneyItemsInstance()
        @prizeMoneyFallPeriodSec = Math.ceil(@prizeMoneyItemsInstance.length * @prizeMoneyFallIntervalFrm)
        console.log(@prizeMoneyFallPeriodSec)
        @isFallPrizeMoney = true

    ###
    スロットの当選金を降らせる
    ###
    _moneyFall:()->
        if @isFallPrizeMoney is true && @age % @prizeMoneyFallIntervalFrm is 0
            @addChild(@prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum])
            @prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum].setPosition()
            @nowPrizeMoneyItemsNum += 1
            if @nowPrizeMoneyItemsNum is @prizeMoneyItemsInstance.length
                @nowPrizeMoneyItemsNum = 0
                @isFallPrizeMoney = false
    ###
    当選金の内訳のコイン枚数を計算する
    @param value number 金額
    ###
    _calcPrizeMoneyItemsNum:(value)->
        if value <= 20 #全部1円
            @prizeMoneyItemsNum[1] = value
            @prizeMoneyItemsNum[10] = 0
            @prizeMoneyItemsNum[100] = 0
            @prizeMoneyItemsNum[1000] = 0
        else if value < 100 #1円と10円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1) + 10
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2) - 1
            @prizeMoneyItemsNum[100] = 0
            @prizeMoneyItemsNum[1000] = 0
        else if value < 1000 #10円と100円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1)
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2) + 10
            @prizeMoneyItemsNum[100] = game.getDigitNum(value, 3) - 1
            @prizeMoneyItemsNum[1000] = 0
        else if value < 10000 #1000円と100円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1)
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2)
            @prizeMoneyItemsNum[100] = game.getDigitNum(value, 3) + 10
            @prizeMoneyItemsNum[1000] = game.getDigitNum(value, 4) - 1
        else #全部1000円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1)
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2)
            @prizeMoneyItemsNum[100] = game.getDigitNum(value, 3)
            @prizeMoneyItemsNum[1000] = Math.floor(value/1000)

    ###
    当選金コインのインスタンスを設置
    ###
    _setPrizeMoneyItemsInstance:()->
        @prizeMoneyItemsInstance = []
        if @prizeMoneyItemsNum[1] > 0
            for i in [1..@prizeMoneyItemsNum[1]]
                @prizeMoneyItemsInstance.push(new OneHomingMoney)
        if @prizeMoneyItemsNum[10] > 0
            for i in [1..@prizeMoneyItemsNum[10]]
                @prizeMoneyItemsInstance.push(new TenHomingMoney)
        if @prizeMoneyItemsNum[100] > 0
            for i in [1..@prizeMoneyItemsNum[100]]
                @prizeMoneyItemsInstance.push(new HundredHomingMoney)
        if @prizeMoneyItemsNum[1000] > 0
            for i in [1..@prizeMoneyItemsNum[1000]]
                @prizeMoneyItemsInstance.push(new ThousandHomingMoney)