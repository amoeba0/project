class gpSystem extends appGroup
    constructor: () ->
        super
        @paermit_bet_change_flg = true
        @money_text = new moneyText()
        @addChild(@money_text)
        @bet_text = new betText()
        @addChild(@bet_text)
        @combo_unit_text = new comboUnitText()
        @addChild(@combo_unit_text)
        @combo_text = new comboText()
        @addChild(@combo_text)
        @tension_gauge_back = new TensionGaugeBack()
        @addChild(@tension_gauge_back)
        @tension_gauge = new TensionGauge()
        @addChild(@tension_gauge)
        @pause_button = new pauseButton()
        @addChild(@pause_button)
        @item_slot = {}
        for i in [1..game.limit_set_item_num]
            @item_slot[i] = new ItemSlot(i)
            @addChild(@item_slot[i])
            @item_slot[i].setPositoin(i)
        @item_gauge_back = new ItemGaugeBack()
        @addChild(@item_gauge_back)
        @item_gauge = new ItemGauge()
        @addChild(@item_gauge)
        @left_button = new leftButton()
        @addChild(@left_button)
        @right_button = new rightButton()
        @addChild(@right_button)
        @jump_button = new jumpButton()
        @addChild(@jump_button)
        @heigh_bet_button = new heighBetButton()
        @addChild(@heigh_bet_button)
        @low_bet_button = new lowBetButton()
        @addChild(@low_bet_button)
        @keyList = {'up':false, 'down':false}
        @prevItem = []
    onenterframe: (e) ->
        @_betSetting()
        @_setItemPoint()
    ###
    キーの上下を押して掛け金を設定する
    ###
    _betSetting: ()->
        if @paermit_bet_change_flg is true
            if game.main_scene.keyList['up'] is true
                if @keyList['up'] is false
                    @_getBetSettingValue(true)
                    @keyList['up'] = true
            else
                if @keyList['up'] is true
                    @keyList['up'] = false
            if game.main_scene.keyList['down'] is true
                if @keyList['down'] is false
                    @_getBetSettingValue(false)
                    @keyList['down'] = true
            else
                if @keyList['down'] is true
                    @keyList['down'] = false

    ###
    掛け金の変更
    ###
    _getBetSettingValue:(up)->
        val = 1
        bet = game.bet
        if up is true
            if bet < 10
                val = 1
            else if bet < 100
                val = 10
            else if bet < 1000
                val = 100
            else if bet < 10000
                val = 1000
            else if bet < 100000
                val = 10000
            else if bet < 1000000
                val = 100000
            else if bet < 10000000
                val = 1000000
            else if bet < 100000000
                val = 10000000
            else if bet < 1000000000
                val = 100000000
            else if bet < 10000000000
                val = 1000000000
            else if bet < 10000000000
                val = 1000000000
            else if bet < 10000000000
                val = 1000000000
            else
                val = 10000000000
        else
            if bet <= 10
                val = -1
            else if bet <= 100
                val = -10
            else if bet <= 1000
                val = -100
            else if bet <= 10000
                val = -1000
            else if bet <= 100000
                val = -10000
            else if bet <= 1000000
                val = -100000
            else if bet <= 10000000
                val = -1000000
            else if bet <= 100000000
                val = -10000000
            else if bet <= 1000000000
                val = -100000000
            else if bet <= 10000000000
                val = -1000000000
            else if bet <= 100000000000
                val = -10000000000
            else if bet <= 1000000000000
                val = -100000000000
            else
                val = -1000000000000
        game.bet += val
        if game.bet < 1
            game.bet = 1
        else if game.bet > game.money
            game.bet -= val
        else if game.bet > 100000000000
            game.bet = 100000000000
        @bet_text.setValue()
    ###
    掛け金の変更が可能かを変更する
    @param boolean flg true:変更可能、false:変更不可能
    ###
    changeBetChangeFlg:(flg)->
        if flg is true
            @heigh_bet_button.opacity = 1
            @low_bet_button.opacity = 1
            @paermit_bet_change_flg = true
        else
            @heigh_bet_button.opacity = 0
            @low_bet_button.opacity = 0
            @paermit_bet_change_flg = false
    ###
    セットしているアイテムを表示する
    ###
    itemDsp:()->
        for i in [1..game.limit_set_item_num]
            if i <= game.max_set_item_num
                if game.item_set_now[i - 1] != undefined
                    @item_slot[i].frame = game.item_set_now[i - 1]
                    @item_slot[i].opacity = 1
                    #game.now_item = game.item_set_now[i]
                else
                    @item_slot[i].frame = 0
                    @item_slot[i].opacity = 1
                    #game.now_item = 0
            else
                @item_slot[i].frame = 0
                @item_slot[i].opacity = 0
    ###
    リアルタイムでアイテムゲージの増減をします
    アイテムスロットが空なら一定時間で回復し、全回復したら前にセットしていたアイテムを自動的にセットします
    アイテムスロットにアイテムが入っていたら、入っているアイテムによって一定時間で減少し、全てなくなったら自動的にアイテムを解除します
    ###
    _setItemPoint:()->
        if game.item_set_now.length is 0
            if game.item_point < game.slot_setting.item_point_max
                game.item_point = Math.floor(1000 * (game.item_point + game.slot_setting.item_point_value[0])) /1000
                if game.slot_setting.item_point_max < game.item_point
                    game.item_point = game.slot_setting.item_point_max
                    if @prevItem.length != 0
                        game.item_set_now = @prevItem
                        @itemDsp()
                        game.pause_scene.pause_item_use_layer.dspSetItemList()
                        game.itemUseExe()
        else
            if 0 < game.item_point
                game.item_point = Math.floor(1000 * (game.item_point - game.slot_setting.item_decrease_point)) /1000
                if game.item_point < 0
                    game.item_point = 0
                    @_resetItem()
        @item_gauge.scaleX = Math.floor(100 * (game.item_point / game.slot_setting.item_point_max)) / 100
        @item_gauge.x = @item_gauge.initX - Math.floor(@item_gauge.width * (1 - @item_gauge.scaleX) / 2)
    _resetItem:()->
        @prevItem = game.item_set_now
        game.item_set_now = []
        @itemDsp()
        game.pause_scene.pause_item_use_layer.dspSetItemList()
        game.itemUseExe()