class gpEffect extends appGroup
    constructor: () ->
        super
        @chance_effect = new chanceEffect()
        @fever_effect = new feverEffect()
        @fever_overlay = new feverOverlay()

    cutInSet:()->
        setting = game.slot_setting
        if setting.muse_material_list[setting.now_muse_num] != undefined
            @cut_in = new cutIn()
            @addChild(@cut_in)
            game.main_scene.gp_stage_front.missItemFallSycleNow = 0
    chanceEffectSet:()->
        @addChild(@chance_effect)
        @chance_effect.setInit()

    feverEffectSet:()->
        @addChild(@fever_effect)
        @addChild(@fever_overlay)
        @fever_overlay.setInit()

    feverEffectEnd:()->
        @removeChild(@fever_effect)
        @removeChild(@fever_overlay)