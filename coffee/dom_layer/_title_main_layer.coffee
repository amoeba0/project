class titleMainLayer extends appDomLayer
    constructor: () ->
        super
        @start_game_button = new startGameButtonHtml()
        @addChild(@start_game_button)
        @new_game_button = new newGameButtonHtml()
        @addChild(@new_game_button)
