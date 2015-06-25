class gpSystem extends appGroup
    constructor: () ->
        super
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
        @keyList = {'up':false, 'down':false}
    onenterframe: (e) ->
        @_betSetting()
    ###
    キーの上下を押して掛け金を設定する
    ###
    _betSetting: ()->
        if game.keyList['up'] is true
            if @keyList['up'] is false
                console.log('up')
                @_getBetSettingValue(true)
                @keyList['up'] = true
        else
            if @keyList['up'] is true
                @keyList['up'] = false
        if game.keyList['down'] is true
            if @keyList['down'] is false
                console.log('down')
                @_getBetSettingValue(false)
                @keyList['down'] = true
        else
            if @keyList['down'] is true
                @keyList['down'] = false

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
            else
                val = 100000
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
            else
                val = -100000
        game.bet += val
        if game.bet < 1
            game.bet = 1
        else if game.bet > game.money
            game.bet = game.money
        @bet_text.setValue()
