class gpMainMenu extends appGroup
    constructor: () ->
        super
        @pause_back = new pauseBack()
        @addChild(@pause_back)

        @return_game_button = new returnGameButton()
        @addChild(@return_game_button)
        @return_game_text = new returnGameText()
        @addChild(@return_game_text)

        @save_game_button = new saveGameButton()
        @addChild(@save_game_button)
        @save_game_text = new saveGameText()
        @addChild(@save_game_text)