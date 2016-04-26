class loadScene extends appScene
    constructor: () ->
        super
        @gp_load = new gpLoad()
        @addChild(@gp_load)
        @wait = game.fps * 1.5
    onenterframe: (e) ->
        if @wait < @age
            game.popLoadScene()