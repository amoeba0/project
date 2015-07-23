class pauseMainLayer extends appDomLayer
    constructor: () ->
        super
        @return_game_button = new returnGameButtonHtml()
        @addChild(@return_game_button)
        @save_game_button = new saveGameButtonHtml()
        @addChild(@save_game_button)
