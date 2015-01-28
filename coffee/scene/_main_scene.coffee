class mainScene extends appScene
    constructor:()->
        super
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_stage = new gpStage()
        @addChild(@gp_stage)