class gpLoad extends appGroup
    constructor: () ->
        super
        @modal = new blackBack()
        @modal.opacity = 0.2
        @addChild(@modal)
        @arc = new loadArc()
        @addChild(@arc)