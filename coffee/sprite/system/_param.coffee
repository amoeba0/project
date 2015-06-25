class Param extends System
    constructor: (w, h) ->
        super w, h
    drawRect: (color) ->
        surface = new Surface(@w, @h)
        surface.context.fillStyle = color
        surface.context.fillRect(0, 0, @w, @h, 10)
        surface.context.fill()
        return surface

class TensionGaugeBack extends Param
    constructor: (w, h) ->
        super 610, 25
        @image = @drawRect('#FFFFFF')
        @x = 15
        @y = 75

class TensionGauge extends Param
    constructor: (w, h) ->
        super 600, 15
        @image = @drawRect('#6EB7DB')
        @x = 20
        @y = 80
        @setValue()

    setValue:()->
        tension = 0
        if game.tension != 0
            tension = game.tension / game.slot_setting.tension_max
        @scaleX = tension
        @x = 20 - ((@w - tension * @w) / 2)
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