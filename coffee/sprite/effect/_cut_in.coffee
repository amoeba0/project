###
カットインの画像サイズ、頭の位置で760px
###
class cutIn extends effect
    constructor: () ->
        @_callCutIn()
        super @cut_in['width'], @cut_in['height']
        @_setInit()

    onenterframe: (e) ->
        @x += @vx
        if @x < -@w
            game.main_scene.gp_effect.removeChild(@)
    
    _callCutIn:()->
        setting = game.slot_setting
        muse_num = setting.now_muse_num
        cut_in_list = setting.muse_material_list[muse_num]['cut_in']
        cut_in_random = Math.floor(Math.random() * cut_in_list.length)
        @cut_in = cut_in_list[cut_in_random]

    _setInit:()->
        @image = game.imageload('cut_in/'+@cut_in['name'])
        @x = game.width
        @y = game.height - @h
        @vx = Math.round((game.width + @w) / (3 * game.fps)) * -1
        game.main_scene.gp_stage_front.setItemFallFrm(7)