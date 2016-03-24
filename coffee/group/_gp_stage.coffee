class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 640 #床の位置

###
ステージ前面
プレイヤーや落下アイテムがある
###
class stageFront extends gpStage
    constructor: () ->
        super
        @itemFallSec = 5 #アイテムを降らせる周期（秒）
        @itemFallSecInit = 5
        @itemFallFrm = 0 #アイテムを降らせる周期（フレーム）
        @catchItems = [] #キャッチアイテムのインスタンスを格納
        @nowCatchItemsNum = 0
        @missItemFallSycle = 4 #ハズレアイテムを取る周期
        @missItemFallSycleNow = 0
        @catchMissItems = []
        @nowCatchMissItemsNum = 0
        @item_fall_se = game.soundload('dicision')
        @miss_fall_se = game.soundload('cancel')
        @explotion_effect = new explosionEffect()
        @initial()
    initial:()->
        @setPlayer()
        @setItemFallSecInit()
    onenterframe: () ->
        @_stageCycle()
    setPlayer:()->
        @player = new Bear()
        @player.y = @floor
        @addChild(@player)
    ###
    アイテムを降らせる間隔を初期化
    ###
    setItemFallSecInit:()->
        if game.debug.item_fall_early_flg is true
            @itemFallSecInit = 3
        @setItemFallFrm(@itemFallSecInit)
    ###
    アイテムを降らせる間隔（フレーム）を設定、再設定
    ###
    setItemFallFrm:(sec)->
        @itemFallSec = sec
        @itemFallFrm = game.fps * sec
        @age = 0
    ###
    一定周期でステージに発生するイベント
    ###
    _stageCycle:()->
        if @age % @itemFallFrm is 0
            @_catchFall()
            @missItemFallSycleNow += 1
            game.main_scene.gp_stage_back.returnMoneyFallStart()
            game.main_scene.gp_back_panorama.setBackEffect()
            if @itemFallSec != @itemFallSecInit
                @setItemFallFrm(@itemFallSecInit)
        if @missItemFallSycleNow is @missItemFallSycle && @age % @itemFallFrm is @itemFallFrm / 2
            if game.isItemSet(2) is false && game.fever is false
                @_missCatchFall()
            @missItemFallSycleNow = 0

    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        if game.bet > game.money
            game.auto_bet = 0
            game.bet = game.slot_setting.betDown()
            game.main_scene.gp_system.bet_text.setValue()
        if 0 < game.money
            game.money -= game.bet
        @catchItems.push(new MacaroonCatch())
        @addChild(@catchItems[@nowCatchItemsNum])
        game.sePlay(@item_fall_se)
        @catchItems[@nowCatchItemsNum].setPosition()
        @nowCatchItemsNum += 1
        game.main_scene.gp_system.money_text.setValue()
        game.main_scene.gp_slot.slotStart()
        if game.slot_setting.getIsForceSlotHit() is true
            game.main_scene.gp_slot.startForceSlotHit()
        else
            game.main_scene.gp_slot.endForceSlotHit()

    _missCatchFall:()->
        if game.money >= game.bet && game.past_fever_num >= 2
            @catchMissItems.push(new OnionCatch())
            @addChild(@catchMissItems[@nowCatchMissItemsNum])
            game.sePlay(@miss_fall_se)
            @catchMissItems[@nowCatchMissItemsNum].setPosition()
            @nowCatchMissItemsNum += 1

    setExplosionEffect:(x, y)->
        @addChild(@explotion_effect)
        @explotion_effect.setInit(x, y)


###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsInstance = [] #スロット当選金のインスタンスを格納
        @prizeMoneyItemsNum = {1:0,10:0,100:0,1000:0,10000:0,100000:0,1000000:0,10000000:0,100000000:0,1000000000:0,10000000000:0,100000000000:0} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 4 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
        @oneSetMoney = 1 #1フレームに設置するコインの数

        @returnMoneyItemsInstance = [] #掛け金の戻り分のインスタンスを格納
        @returnMoneyItemsNum = {1:0,10:0,100:0,1000:0,10000:0,100000:0,1000000:0,10000000:0,100000000:0,1000000000:0,10000000000:0,100000000000:0} #掛け金の戻り分を降らせる各コイン数の内訳
        @nowReturnMoneyItemsNum = 0
        @returnMoneyFallIntervalFrm = 4 #掛け金の戻り分を降らせる間隔（フレーム）
    onenterframe: () ->
        @_moneyFall()
        @_returnMoneyFall()
    ###
    スロットの当選金を降らせる
    @param value number 金額
    ###
    fallPrizeMoneyStart:(value) ->
        stage = game.main_scene.gp_stage_front
        if value < 1000000000000
            @prizeMoneyFallIntervalFrm = 4
        else if value < 10000000000000
            @prizeMoneyFallIntervalFrm = 2
        else
            @prizeMoneyFallIntervalFrm = 1
        @prizeMoneyItemsNum = @_calcMoneyItemsNum(value, true)
        @prizeMoneyItemsInstance = @_setMoneyItemsInstance(@prizeMoneyItemsNum, true)
        if @prizeMoneyItemsNum[100000000000] > 1000
            @oneSetMoney = Math.floor(@prizeMoneyItemsNum[100000000000] / 1000)
        @prizeMoneyFallPeriodSec = Math.ceil((@prizeMoneyItemsInstance.length / @oneSetMoney) * @prizeMoneyFallIntervalFrm / game.fps) + stage.itemFallSecInit
        if @prizeMoneyFallPeriodSec > stage.itemFallSecInit
            stage.setItemFallFrm(@prizeMoneyFallPeriodSec)
        @isFallPrizeMoney = true

    ###
    スロットの当選金を降らせる
    ###
    _moneyFall:()->
        if @isFallPrizeMoney is true && @age % @prizeMoneyFallIntervalFrm is 0
            for i in [1..@oneSetMoney]
                # TODO バグあり
                if @prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum] != undefined
                    @addChild(@prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum])
                    @prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum].setPosition()
                    @nowPrizeMoneyItemsNum += 1
                    if @nowPrizeMoneyItemsNum is @prizeMoneyItemsInstance.length
                        @nowPrizeMoneyItemsNum = 0
                        @isFallPrizeMoney = false
    ###
    当選金の内訳のコイン枚数を計算する
    @param value   number 金額
    @prize boolean true:当選金額
    ###
    _calcMoneyItemsNum:(value, prize)->
        ret_data = {1:0,10:0,100:0,1000:0,10000:0,100000:0,1000000:0,10000000:0,100000000:0,1000000000:0,10000000000:0,100000000000:0}
        if value <= 20 #全部1円
            ret_data[1] = value
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100 #1円と10円と端数
            ret_data[1] = game.getDigitNum(value, 1) + 10
            ret_data[10] = game.getDigitNum(value, 2) - 1
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 1000 #10円と100円と端数
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2) + 10
            ret_data[100] = game.getDigitNum(value, 3) - 1
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 10000 #1000円と100円と端数
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3) + 10
            ret_data[1000] = game.getDigitNum(value, 4) - 1
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100000
            ret_data[1] = 0
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3)
            ret_data[1000] = game.getDigitNum(value, 4) + 10
            ret_data[10000] = game.getDigitNum(value, 5) - 1
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 1000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = game.getDigitNum(value, 3)
            ret_data[1000] = game.getDigitNum(value, 4)
            ret_data[10000] = game.getDigitNum(value, 5) + 10
            ret_data[100000] = game.getDigitNum(value, 6) - 1
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 10000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = game.getDigitNum(value, 4)
            ret_data[10000] = game.getDigitNum(value, 5)
            ret_data[100000] = game.getDigitNum(value, 6) + 10
            ret_data[1000000] = game.getDigitNum(value, 7) - 1
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = game.getDigitNum(value, 5)
            ret_data[100000] = game.getDigitNum(value, 6)
            ret_data[1000000] = game.getDigitNum(value, 7) + 10
            ret_data[10000000] = game.getDigitNum(value, 8) - 1
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 1000000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = game.getDigitNum(value, 6)
            ret_data[1000000] = game.getDigitNum(value, 7)
            ret_data[10000000] = game.getDigitNum(value, 8) + 10
            ret_data[100000000] = game.getDigitNum(value, 9) - 1
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 10000000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = game.getDigitNum(value, 7)
            ret_data[10000000] = game.getDigitNum(value, 8)
            ret_data[100000000] = game.getDigitNum(value, 9) + 10
            ret_data[1000000000] = game.getDigitNum(value, 10) - 1
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100000000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = game.getDigitNum(value, 8)
            ret_data[100000000] = game.getDigitNum(value, 9)
            ret_data[1000000000] = game.getDigitNum(value, 10) + 10
            ret_data[10000000000] = game.getDigitNum(value, 11) - 1
            ret_data[100000000000] = 0
        else
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = game.getDigitNum(value, 9)
            ret_data[1000000000] = game.getDigitNum(value, 10)
            ret_data[10000000000] = game.getDigitNum(value, 11) + 10
            ret_data[100000000000] = Math.floor(value/100000000000)
        return ret_data

    ###
    当選金コインのインスタンスを設置
    @param number  itemsNum コイン数の内訳
    @param boolean isHoming trueならコインがホーミングする
    @return array
    ###
    _setMoneyItemsInstance:(itemsNum, isHoming)->
        ret_data = []
        if itemsNum[1] > 0
            for i in [1..itemsNum[1]]
                ret_data.push(new OneMoney(isHoming))
        if itemsNum[10] > 0
            for i in [1..itemsNum[10]]
                ret_data.push(new TenMoney(isHoming))
        if itemsNum[100] > 0
            for i in [1..itemsNum[100]]
                ret_data.push(new HundredMoney(isHoming))
        if itemsNum[1000] > 0
            for i in [1..itemsNum[1000]]
                ret_data.push(new ThousandMoney(isHoming))
        if itemsNum[10000] > 0
            for i in [1..itemsNum[10000]]
                ret_data.push(new TenThousandMoney(isHoming))
        if itemsNum[100000] > 0
            for i in [1..itemsNum[100000]]
                ret_data.push(new HundredThousandMoney(isHoming))
        if itemsNum[1000000] > 0
            for i in [1..itemsNum[1000000]]
                ret_data.push(new OneMillionMoney(isHoming))
        if itemsNum[10000000] > 0
            for i in [1..itemsNum[10000000]]
                ret_data.push(new TenMillionMoney(isHoming))
        if itemsNum[100000000] > 0
            for i in [1..itemsNum[100000000]]
                ret_data.push(new OneHundredMillionMoney(isHoming))
        if itemsNum[1000000000] > 0
            for i in [1..itemsNum[1000000000]]
                ret_data.push(new BillionMoney(isHoming))
        if itemsNum[10000000000] > 0
            for i in [1..itemsNum[10000000000]]
                ret_data.push(new TenBillionMoney(isHoming))
        if itemsNum[100000000000] > 0
            for i in [1..itemsNum[100000000000]]
                ret_data.push(new OneHundredBillionMoney(isHoming))
        return ret_data

    ###
    掛け金の戻り分を降らせる、開始
    ###
    returnMoneyFallStart:()->
        val = game.slot_setting.getReturnMoneyFallValue()
        if val < 10
        else if val < 100
            val = Math.floor(val / 10) * 10
        else if val < 1000
            val = Math.floor(val / 100) * 100
        else if val < 10000
            val = Math.floor(val / 1000) * 1000
        else if val < 100000
            val = Math.floor(val / 10000) * 10000
        else if val < 1000000
            val = Math.floor(val / 100000) * 100000
        else if val < 10000000
            val = Math.floor(val / 1000000) * 1000000
        else if val < 100000000
            val = Math.floor(val / 10000000) * 10000000
        else if val < 1000000000
            val = Math.floor(val / 100000000) * 100000000
        else if val < 10000000000
            val = Math.floor(val / 1000000000) * 1000000000
        else if val < 100000000000
            val = Math.floor(val / 10000000000) * 10000000000
        else
            val = Math.floor(val / 100000000000) * 100000000000
        @returnMoneyItemsNum = @_calcMoneyItemsNum(val, false)
        @returnMoneyItemsInstance = @_setMoneyItemsInstance(@returnMoneyItemsNum, false)
        stage = game.main_scene.gp_stage_front
        @returnMoneyFallIntervalFrm = Math.round(stage.itemFallSecInit * game.fps / @returnMoneyItemsInstance.length)
        @nowReturnMoneyItemsNum = 0

    ###
    掛け金の戻り分を降らせる
    ###
    _returnMoneyFall:()->
        if @isFallPrizeMoney is false && @returnMoneyItemsInstance.length > 0 && @age % @returnMoneyFallIntervalFrm is 0
            if @nowReturnMoneyItemsNum is @returnMoneyItemsInstance.length
                @returnMoneyItemsInstance = []
                @nowReturnMoneyItemsNum = 0
            else
                @addChild(@returnMoneyItemsInstance[@nowReturnMoneyItemsNum])
                @returnMoneyItemsInstance[@nowReturnMoneyItemsNum].setPosition()
                @nowReturnMoneyItemsNum += 1