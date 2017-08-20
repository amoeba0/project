class titleScene extends appScene
    constructor: () ->
        super
        @backgroundColor = '#FFF'
        @title_main_layer = new titleMainLayer()
        @addChild(@title_main_layer)