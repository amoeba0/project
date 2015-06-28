class gpEffect extends appGroup
    constructor: () ->
        super
    cutInSet:()->
        setting = game.slot_setting
        if setting.muse_material_list[setting.now_muse_num] != undefined
            @cut_in = new cutIn()
            @addChild(@cut_in)
            game.main_scene.gp_stage_front.missItemFallSycleNow = 0