class pauseMainLayer extends appDomLayer
    constructor: () ->
        super
        @return_game_button = new returnGameButtonHtml()
        @save_game_button = new saveGameButtonHtml()
        @buy_item_button = new buyItemButtonHtml()
        @use_item_button = new useItemButtonHtml()
        @set_member_button = new setMemberButtonHtml()
        @record_button = new recordButtonHtml()
        @addChild(@return_game_button)
        @addChild(@save_game_button)
        @addChild(@buy_item_button)
        @addChild(@use_item_button)
        @addChild(@set_member_button)
        @addChild(@record_button)
        @y = -20