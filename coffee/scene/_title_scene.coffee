class titleScene extends appScene
    constructor: () ->
        super
        @title_main_layer = new titleMainLayer()
        @addChild(@title_main_layer)