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
        @addChild(@return_game_button)
        @addChild(@save_game_button)
        @addChild(@title_button)
        @addChild(@buy_item_button)
        @addChild(@use_item_button)
        @addChild(@set_member_button)
        @addChild(@record_button)
        @addChild(@bet_dialog)
        @money_text = new moneyText()
        @addChild(@money_text)
        @bet_text = new betText()
        @addChild(@bet_text)
        @heigh_bet_button = new heighBetButtonPause()
        @addChild(@heigh_bet_button)
        @low_bet_button = new lowBetButtonPause()
        @addChild(@low_bet_button)
        @y = -20
    statusDsp:()->
        @money_text.setValue()
        @money_text.setPositionPause()
        @bet_text.setValue()
        @bet_text.setPositionPause()
        @low_bet_button.setXposition()
        if game.fever is true
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