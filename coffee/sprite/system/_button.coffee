class Button extends System
    constructor: (w, h) ->
        super w, h
    touchendEvent:() ->

###
ポーズボタン
###
class pauseButton extends Button
    constructor: () ->
        super 36, 36
        @image = game.imageload("pause")
        @x = 430
        @y = 76
    ontouchend: (e)->
        game.setPauseScene()

###
コントローラボタン
###
class controllerButton extends Button
    constructor: () ->
        super 50, 50
        @color = "#aaa"
        @opacity = 0.4
        @x = 0
        @y = 660

###
左ボタン
###
class leftButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @x = 30

###
右ボタン
###
class rightButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @scaleX = -1
        @x = game.width - @w - 30

###
ジャンプボタン
###
class jumpButton extends controllerButton
    constructor: () ->
        super
        @image = @drawCircle(@color)
        @x = (game.width - @w) / 2

###
掛け金変更ボタン
###
class betButton extends Button
    constructor: () ->
        super 22, 22
        @color = "black"
        @y = 7

###
掛け金を増やすボタン
###
class heighBetButton extends betButton
    constructor: () ->
        super
        @image = @drawUpTriangle(@color)
        @x = 7

###
掛け金を減らすボタン
###
class lowBetButton extends betButton
    constructor: () ->
        super
        @image = @drawUpTriangle(@color)
        @scaleY = -1
        @x = 121
    setXposition: ()->
        @x = game.main_scene.gp_system.bet_text._boundWidth + @w + 20