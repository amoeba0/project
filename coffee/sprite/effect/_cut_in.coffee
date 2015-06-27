###
カットインの画像サイズ、頭の位置で760px
###
class cutIn extends effect
    constructor: () ->
        @_callCutIn()
        super @cut_in['width'], @cut_in['height']
        @_setInit()

    onenterframe: (e) ->
        if @age - @set_age is @fast
            @vx = @_setVxSlow()
        if @age - @set_age is @slow
            @vx = @_setVxFast()
        @x += @vx
        if (@cut_in['direction'] is 'left' && @x < -@w) || (@cut_in['direction'] is 'left' is 'right' && @x > game.width)
            game.main_scene.gp_effect.removeChild(@)
    
    _callCutIn:()->
        setting = game.slot_setting
        muse_num = setting.now_muse_num
        cut_in_list = setting.muse_material_list[muse_num]['cut_in']
        cut_in_random = Math.floor(Math.random() * cut_in_list.length)
        @cut_in = cut_in_list[cut_in_random]

    _setInit:()->
        @image = game.imageload('cut_in/'+@cut_in['name'])
        if @cut_in['direction'] is 'left'
            @x = game.width
        else 
            @x = -@w
        @y = game.height - @h
        @vx = @_setVxFast()
        game.main_scene.gp_stage_front.setItemFallFrm(7)
        @set_age = @age
        @fast = 0.5 * game.fps
        @slow = 2 * game.fps + @fast

    _setVxFast:()->
        val = Math.round(((game.width + @w) / 2) / (0.5 * game.fps))
        if @cut_in['direction'] is 'left'
            val *= -1
        return val

    _setVxSlow:()->
        val = Math.round((game.width / 4) / (2 * game.fps))
        if @cut_in['direction'] is 'left'
            val *= -1
        return val