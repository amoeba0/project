class gpLoad extends appGroup
    constructor: () ->
        super
        @modal = new blackBack()
        @modal.opacity = 0.2
        @addChild(@modal)
        @arc = new loadArc()
        @addChild(@arc)

class gpLoadStory extends appGroup
    constructor: () ->
        super
        @modal = new blackBack()
        @modal.opacity = 0.2
        @addChild(@modal)
        @arc = new storyLoadArc()
        @addChild(@arc)

class gpKaisetu extends appGroup
    constructor:()->
        super
        @modal = new blackBack()
        @modal.opacity = 0.5
        @addChild(@modal)
        @kaisetu = new gamenKaisetu()
        @addChild(@kaisetu)
        @okBtn = new kaisetuOkButton()
        @addChild(@okBtn)
        @xBtn = new kaisetuXButton()
        @addChild(@xBtn)

class gpStoryPause extends appGroup
    constructor:()->
        super
        @modal = new blackBack()
        @modal.opacity = 0.5
        @addChild(@modal)