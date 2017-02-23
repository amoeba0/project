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

class preloadScene extends appScene
    constructor:(gw, gh, toubai)->
        super
        @setSize(gw, gh, toubai)
        @backgroundColor = '#FFF'
        @gp_preload = new gpPreload(gw, gh)
        @addChild(@gp_preload)
        @addEventListener('progress', (e)->
            angle = Math.floor(360 * e.loaded / e.total)
            @gp_preload.arc.setImage(angle)
        )
        @addEventListener('load', (e)->
            game.removeScene(@)
            game.dispatchEvent(e)
        )
    setSize:(gw, gh, toubai)->
        browserAspect = window.innerHeight / window.innerWidth
        gameAspect = gh / gw
        if toubai
            @width = gw
            @height = gh
        else
            if browserAspect < gameAspect
                @width = Math.floor(window.innerHeight * gw/ gh)
                @height = window.innerHeight
            else
                @width = window.innerWidth
                @height = Math.floor(window.innerWidth * gh/ gw)