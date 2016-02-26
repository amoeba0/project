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

class largePauseButton extends Button
    constructor:()->
        super 100, 150
        @x = 380
        @y = 40
    ontouchend: (e)->
        game.setPauseScene()

###
コントローラボタン
###
class controllerButton extends Button
    constructor: () ->
        super 60, 60
        @color = "#888"
        @pushColor = "#333"
        @opacity = 0.4
        @x = 0
        @y = 650
    changePushColor: () ->
        @image = @drawLeftTriangle(@pushColor)
    changePullColor: () ->
        @image = @drawLeftTriangle(@color)

###
左ボタン
###
class leftButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @x = 30
    ontouchstart: () ->
        game.main_scene.buttonList.left = true
    ontouchend: () ->
        game.main_scene.buttonList.left = false

class largeLeftButton extends Button
    constructor: () ->
        super 150 ,150
        @x = 0
        @y = game.height - @height
    ontouchstart: () ->
        game.main_scene.buttonList.left = true
    ontouchend: () ->
        game.main_scene.buttonList.left = false

###
右ボタン
###
class rightButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @scaleX = -1
        @x = game.width - @w - 40
    ontouchstart: () ->
        game.main_scene.buttonList.right = true
    ontouchend: () ->
        game.main_scene.buttonList.right = false

class largeRightButton extends Button
    constructor: () ->
        super 150 ,150
        @x = game.width - @width
        @y = game.height - @height
    ontouchstart: () ->
        game.main_scene.buttonList.right = true
    ontouchend: () ->
        game.main_scene.buttonList.right = false

###
ジャンプボタン
###
class jumpButton extends controllerButton
    constructor: () ->
        super
        @image = @drawCircle(@color)
        @x = (game.width - @w) / 2
    ontouchstart: () ->
        game.main_scene.buttonList.jump = true
    ontouchend: () ->
        game.main_scene.buttonList.jump = false
    changePushColor: () ->
        @image = @drawCircle(@pushColor)
    changePullColor: () ->
        @image = @drawCircle(@color)

class largeJumpButton extends Button
    constructor: () ->
        super game.width, 400
        @x = 0
        @y = 230
    ontouchstart: () ->
        game.main_scene.buttonList.jump = true
    ontouchend: () ->
        game.main_scene.buttonList.jump = false

###
掛け金変更ボタン
###
class betButton extends Button
    constructor: (width, height) ->
        super width, height
        @color = "black"
        @pushColor = "white"
        @y = 7
    changePushColor: () ->
        @image = @drawUpTriangle(@pushColor)
    changePullColor: () ->
        @image = @drawUpTriangle(@color)

###
掛け金を増やすボタン
###
class heighBetButton extends betButton
    constructor: () ->
        super 22, 22
        @image = @drawUpTriangle(@color)
        @x = 7
    ontouchstart: () ->
        game.main_scene.buttonList.up = true
    ontouchend: () ->
        game.main_scene.buttonList.up = false

class largeHeighBetButton extends Button
    constructor:()->
        super 80, 160
    ontouchstart: () ->
        game.main_scene.buttonList.up = true
    ontouchend: () ->
        game.main_scene.buttonList.up = false

class heighBetButtonPause extends buttonHtml
    constructor: () ->
        super 33, 33
        @class.push('triangle-top')
        @x = 90
        @y = 270
        @setHtml()
    ontouchend: () ->
        game.pause_scene.pause_main_layer.betSetting(true)

###
掛け金を減らすボタン
###
class lowBetButton extends betButton
    constructor: () ->
        super 22, 22
        @image = @drawUpTriangle(@color)
        @scaleY = -1
        @x = 121
    setXposition: ()->
        @x = game.main_scene.gp_system.bet_text._boundWidth + @w + 20
    ontouchstart: () ->
        game.main_scene.buttonList.down = true
    ontouchend: () ->
        game.main_scene.buttonList.down = false

class largeLowBetButton extends Button
    constructor:()->
        super 80, 160
        @x = 110
    ontouchstart: () ->
        game.main_scene.buttonList.down = true
    ontouchend: () ->
        game.main_scene.buttonList.down = false

class lowBetButtonPause extends buttonHtml
    constructor: () ->
        super 33, 33
        @class.push('triangle-bottom')
        @x = 90
        @y = 270
        @setHtml()
    ontouchend: () ->
        game.pause_scene.pause_main_layer.betSetting(false)
    setXposition:()->
        @x = 160 + game.pause_scene.pause_main_layer.bet_text._boundWidth
