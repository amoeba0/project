class gpEffect extends appGroup
    constructor: () ->
        super
        @chance_effect = new chanceEffect()
        @fever_effect = new feverEffect()
        @fever_overlay = new feverOverlay()
        @kirakira_effect = []
        @kirakira_num = 40
        @item_catch_effect = []

    cutInSet:(num = 0)->
        setting = game.slot_setting
        if setting.muse_material_list[setting.now_muse_num] != undefined
            @cut_in = new cutIn(num)
            @addChild(@cut_in)
            game.main_scene.gp_stage_front.missItemFallSycleNow = 0
    chanceEffectSet:()->
        @addChild(@chance_effect)
        @chance_effect.setInit()

    feverEffectSet:()->
        @addChild(@fever_effect)
        @addChild(@fever_overlay)
        @fever_overlay.setInit()
        @_setKirakiraEffect()

    feverEffectEnd:()->
        @removeChild(@fever_effect)
        @removeChild(@fever_overlay)
        @_endKirakiraEffect()

    _setKirakiraEffect:()->
        for i in [1..@kirakira_num]
            @kirakira_effect.push(new kirakiraEffect())
            @addChild(@kirakira_effect[i-1])

    _endKirakiraEffect:()->
        for i in [1..@kirakira_num]
            @removeChild(@kirakira_effect[i-1])

    setItemChatchEffect:(x, y)->
        @item_catch_effect = []
        for i in [1..4]
            @item_catch_effect.push(new itemCatchEffect(i, x, y))
            @addChild(@item_catch_effect[i-1])