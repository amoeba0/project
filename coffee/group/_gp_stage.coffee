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
        @missItemFallSycle = 0 #ハズレアイテムを取る周期
        @missItemFallSycleNow = 0
        @catchMissItems = []
        @nowCatchMissItemsNum = 0
        @isCatchItemExist = false
        @notItemFallFlg = false
        @item_fall_se = game.soundload('select')
        @miss_fall_se = game.soundload('cancel')
        @dicision_se = @item_fall_se
        @cancel_se = @miss_fall_se
        @explotion_effect = new explosionEffect()
        @initial()
    initial:()->
        @setPlayer()
        @setItemFallSecInit()
    onenterframe: () ->
        @_stageCycle()
    setPlayer:()->
        @player = new Bear()
        @player.y = @floor - @player.height
        @player.x = game.width / 2 - (@player.width / 2)
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
        if @notItemFallFlg is false && @age % @itemFallFrm is 0
            @_catchFall()
            @missItemFallSycleNow += 1
            game.main_scene.gp_stage_back.returnMoneyFallStart()
            game.main_scene.gp_back_panorama.setBackEffect()
            if @itemFallSec != @itemFallSecInit
                @setItemFallFrm(@itemFallSecInit)
        if 1 <= @missItemFallSycle && @missItemFallSycleNow >= @missItemFallSycle && @age % @itemFallFrm is @itemFallFrm / 2
            if game.debug.not_miss_item_flg is false && game.isItemSet(2) is false && game.fever is false
                @_missCatchFall()
            @missItemFallSycleNow = 0
        if 0 < @missItemFallSycle && @missItemFallSycle < 1 && game.debug.not_miss_item_flg is false && game.fever is false
            dilay = game.fps
            if @missItemFallSycle is 0.5 then dilay = game.fps * 1.5
            if @missItemFallSycle is 0.2 then dilay = 20
            if @missItemFallSycle is 0.1 then dilay = 10
            if ((@age % @itemFallFrm) % Math.floor(@itemFallFrm * @missItemFallSycle) is dilay)
                @_missCatchFall()
    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        if game.bet > game.money
            game.auto_bet = 0
            game.bet = game.slot_setting.betDown()
            game.main_scene.gp_system.bet_text.setValue()
        if 0 < game.money && (game.retry is false || game.retry is 0)
            game.money -= game.bet
        if game.retry is true
            game.retry = false
            game.main_scene.gp_system.changeBetChangeFlg(true)
        @catchItems.push(new MacaroonCatch())
        @addChild(@catchItems[@nowCatchItemsNum])
        game.sePlay(@item_fall_se)
        @catchItems[@nowCatchItemsNum].setPosition()
        @nowCatchItemsNum += 1
        @isCatchItemExist = true
        game.main_scene.gp_system.money_text.setValue()
        game.main_scene.gp_slot.slotStart()
        if game.slot_setting.getIsForceSlotHit() is true
            game.main_scene.gp_slot.startForceSlotHit()
        else
            game.main_scene.gp_slot.endForceSlotHit()

    _missCatchFall:()->
        if game.money >= game.bet
            @catchMissItems.push(new OnionCatch())
            @addChild(@catchMissItems[@nowCatchMissItemsNum])
            game.sePlay(@miss_fall_se)
            @catchMissItems[@nowCatchMissItemsNum].setPosition()
            @nowCatchMissItemsNum += 1

    setExplosionEffect:(x, y)->
        @addChild(@explotion_effect)
        @explotion_effect.setInit(x, y)

    getCatchItemsXposition:()->
        x = 0
        if @isCatchItemExist
            x = @catchItems[@nowCatchItemsNum-1].x
        return x


###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsInstance = [] #スロット当選金のインスタンスを格納
        @prizeMoneyItemsNum = {} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 4 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
        @oneSetMoney = 1 #1フレームに設置するコインの数

        @returnMoneyItemsInstance = [] #掛け金の戻り分のインスタンスを格納
        @returnMoneyItemsNum = {} #掛け金の戻り分を降らせる各コイン数の内訳
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
        @prizeMoneyFallIntervalFrm = 4
        @prizeMoneyItemsNum = @_calcMoneyItemsNum(value, true)
        @prizeMoneyItemsInstance = @_setMoneyItemsInstance(@prizeMoneyItemsNum, true)
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
        ret_data = {}
        if value <= 20 #全部1円
            ret_data[0] = value
        else if value < 100 #1円と10円と端数
            ret_data[0] = game.getDigitNum(value, 1) + 10
            ret_data[1] = game.getDigitNum(value, 2) - 1
        else if value < 1000 #10円と100円と端数
            ret_data[0] = game.getDigitNum(value, 1)
            ret_data[1] = game.getDigitNum(value, 2) + 10
            ret_data[2] = game.getDigitNum(value, 3) - 1
        else
            lng = game.numDigit(value)
            ret_data[lng - 4] = game.getDigitNum(value, lng - 3)
            ret_data[lng - 3] = game.getDigitNum(value, lng - 2)
            ret_data[lng - 2] = game.getDigitNum(value, lng - 1) + 10
            ret_data[lng - 1] = game.getDigitNum(value, lng) - 1
        return ret_data

    ###
    当選金コインのインスタンスを設置
    @param number  itemsNum コイン数の内訳
    @param boolean isHoming trueならコインがホーミングする
    @return array
    ###
    _setMoneyItemsInstance:(itemsNum, isHoming)->
        ret_data = []
        for i in [0..70]
            if itemsNum[i] != undefined && itemsNum[i] > 0
                num = itemsNum[i]
                for j in [1..num]
                    ret_data.push(new valiableMoney(isHoming, i))
        return ret_data

    ###
    掛け金の戻り分を降らせる、開始
    ###
    returnMoneyFallStart:()->
        val = game.slot_setting.getReturnMoneyFallValue()
        lng = game.numDigit(val)
        if 10 <= val
            val = Math.floor(val / Math.pow(10, lng - 1)) * Math.pow(10, lng - 1)
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