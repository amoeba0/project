class Button extends System
    constructor: (w, h) ->
        super w, h
    touchendEvent:() ->

###
ポーズボタン
###
class pauseButton extends Button
    constructor: () ->
        super 30, 30
        @image = @drawRect('#F9DFD5')
        @x = 435
        @y = 90
    ontouchend: (e)->
        game.pushScene(game.pause_scene)