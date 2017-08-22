class pauseMainLayer extends appDomLayer
    constructor: () ->
        super
        @return_game_button = new returnGameButtonHtml()
        @save_game_button = new saveGameButtonHtml()
        @title_button = new returnTitleButtonHtml()
        @buy_item_button = new buyItemButtonHtml()
        @use_item_button = new useItemButtonHtml()
        @set_member_button = new setMemberButtonHtml()
        @record_button = new recordButtonHtml()
        @bet_dialog = new betDialogHtml()
        @menu_discription = new menuDiscription()
        @batu_button = new batuButtonHtml()
        if game.isSumaho() is false
            @tweet_button = new tweetButtonHtml()
        @addChild(@return_game_button)
        @addChild(@save_game_button)
        @addChild(@title_button)
        @addChild(@buy_item_button)
        @addChild(@use_item_button)
        @addChild(@set_member_button)
        @addChild(@record_button)
        @addChild(@bet_dialog)
        @addChild(@menu_discription)
        @addChild(@batu_button)
        if game.isSumaho() is false
            @addChild(@tweet_button)
        @money_text = new moneyText()
        @addChild(@money_text)
        @bet_text = new betText()
        @addChild(@bet_text)
        @heigh_bet_button = new heighBetButtonPause()
        @addChild(@heigh_bet_button)
        @low_bet_button = new lowBetButtonPause()
        @addChild(@low_bet_button)
        @bet_checkbox = new betCheckboxHtml()
        @addChild(@bet_checkbox)
        @y = -20
        @keyList = {'up':false, 'down':false}
        @keyUpTime = 0
        @keyDownTime = 0
    statusDsp:()->
        @money_text.setValue()
        @money_text.setPositionPause()
        @bet_text.setValue()
        @bet_text.setPositionPause()
        @low_bet_button.setXposition()
        if game.fever is true || game.main_scene.gp_system.paermit_bet_change_flg is false
            @heigh_bet_button.opacity = 0
            @low_bet_button.opacity = 0
        else
            @heigh_bet_button.opacity = 1
            @low_bet_button.opacity = 1
    betSetting:(up)->
        if game.fever is false
            game.slot_setting.betChange(up)
            @bet_text.setValue()
            @bet_text.setPositionPause()
            @low_bet_button.setXposition()
    onenterframe: (e) ->
        @_betSetting()
    _betSetting: ()->
        if game.main_scene.gp_system.paermit_bet_change_flg is true
            if game.main_scene.keyList['up'] is true
                @keyUpTime += 1
                if @keyList['up'] is false
                    @betSetting(true)
                    @keyList['up'] = true
                else
                    if (game.fps < @keyUpTime && @keyUpTime % 2 is 0) || (game.fps * 3 < @keyUpTime)
                        @betSetting(true)
            else
                if @keyList['up'] is true
                    @keyList['up'] = false
                @keyUpTime = 0
            if game.main_scene.keyList['down'] is true
                @keyDownTime += 1
                if @keyList['down'] is false
                    @betSetting(false)
                    @keyList['down'] = true
                else
                    if (game.fps < @keyDownTime && @keyDownTime % 2 is 0) || (game.fps * 3 < @keyDownTime)
                        @betSetting(false)
            else
                if @keyList['down'] is true
                    @keyList['down'] = false
                @keyDownTime = 0