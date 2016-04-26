class Param extends System
    constructor: (w, h) ->
        super w, h

class TensionGaugeBack extends Param
    constructor: (w, h) ->
        super 387, 19
        @image = @drawRect('#FFFFFF')
        @x = 81
        @y = 46

class TensionGauge extends Param
    constructor: (w, h) ->
        super 380, 11
        @image = @drawRect('#6EB7DB')
        @initX = 85
        @x = @initX
        @y = 50
        @setValue()

    setValue:()->
        tension = 0
        if game.tension != 0
            tension = game.tension / game.slot_setting.tension_max
        @scaleX = tension
        @x = @initX - ((@w - tension * @w) / 2)
        if tension < 0.25
            @image = @drawRect('#6EB7DB')
        else if tension < 0.5
            @image = @drawRect('#B2CF3E')
        else if tension < 0.75
            @image = @drawRect('#F3C759')
        else if tension < 1
            @image = @drawRect('#EDA184')
        else
            @image = @drawRect('#F4D2DE')

class ItemSlot extends Param
    constructor:()->
        super 55, 55
        @image = game.imageload("items")
        @frame = 0
        @x = 5
        @y = 70
    setPositoin:(num)->
        @x = (num - 1) * 55 + 5

class ItemGaugeBack extends Param
    constructor:()->
        super 50, 8
        @image = @drawRect('#333')
        @x = 8
        @y = 112
    setWidth:()->
        @width = 50 * game.max_set_item_num

class ItemGauge extends Param
    constructor:()->
        super 51, 8
        @image = @drawRect('#A6E39D')
        @initX = 7
        @x = @initX
        @y = 112
    setWidth:()->
        @width = 51 * game.max_set_item_num

class ItemGaugeShine extends Param
    constructor:()->
        super 51, 8
        @image = @drawRect('#FFF')
        @x = 0
        @y = 112
        @opacity = 0
    onenterframe:(e)->
        if 0 < @opacity
            @opacity -= 0.1
            if @opacity <= 0
                @opacity = 0

class loadArc extends Param
    constructor:()->
        super 80, 80
        @angle = 0
        @wait = game.fps * 1.5
        @angle_frame = 360 / @wait
        @image = @drawArc('#FFF', 10, @angle)
        itemX = game.main_scene.gp_stage_front.getCatchItemsXposition()
        if itemX != 0
            @x = itemX - 15
        else
            @x = game.width / 2 - @width / 2
        @y = game.height / 2 - @height / 2
    onenterframe:(e)->
        if @angle < 360
            @angle += @angle_frame
            @image = @drawArc('#FFF', 10, @angle)