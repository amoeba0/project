class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = '#93F0FF'
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_panorama = new gpPanorama()
        @addChild(@gp_panorama)
        @gp_stage_back = new stageBack()
        @addChild(@gp_stage_back)
        @gp_slot = new gpSlot()
        @addChild(@gp_slot)
        @gp_effect = new gpEffect()
        @addChild(@gp_effect)
        @gp_stage_front = new stageFront()
        @addChild(@gp_stage_front)
        @gp_system = new gpSystem()
        @addChild(@gp_system)
        @gp_slot.x = 150
        @gp_slot.y = 200