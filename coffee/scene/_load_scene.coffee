class loadScene extends appScene
    constructor: () ->
        super
        @gp_load = new gpLoad()
        @addChild(@gp_load)
        @wait = game.fps * 1.5
    onenterframe: (e) ->
        if @wait < @age
            game.popLoadScene()

class kaisetuScene extends appScene
    constructor:()->
        super
        @gp_kaisetu = new gpKaisetu()
        @addChild(@gp_kaisetu)

class storyPauseScene extends appScene
    constructor:()->
        super
        @gp_story_pause = new gpStoryPause()
        @msg = new storyPauseMsgTxt()
        @restart = new storyPauseEndTxt()
        @addChild(@gp_story_pause)
        @addChild(@msg)
        @addChild(@restart)