class Button extends System
    constructor: (w, h) ->
        super w, h
class pauseButton extends Button
    constructor: () ->
        super 40, 40
        @image = @drawRect('#F9DFD5')
        @x = 580
        @y = 120
    ontouchend: (e)->
        game.pushScene(game.pause_scene)