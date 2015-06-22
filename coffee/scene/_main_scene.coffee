class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = 'rgb(153,204,255)';
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_slot = new gpSlot()
        @addChild(@gp_slot)
        @gp_stage = new gpStage()
        @addChild(@gp_stage)
        @gp_slot.x = 150
        @gp_slot.y = 200