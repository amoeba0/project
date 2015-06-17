class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = 'rgb(153,204,255)';
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_stage = new gpStage()
        @addChild(@gp_stage)