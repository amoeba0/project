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

###
ポーズメニューのボタン
###
class pauseMainMenuButton extends Button
    constructor: () ->
        super 300, 45
        @image = @drawRect('#ffffff')
        @x = 90
        @y = 0
    ontouchend: (e) ->
        @touchendEvent()

###
ゲームへ戻る
###
class returnGameButton extends pauseMainMenuButton
    constructor: () ->
        super
        @y = 150
    touchendEvent:() ->
        game.popScene(game.pause_scene)

###
ゲームを保存する
###
class saveGameButton extends pauseMainMenuButton
    constructor: () ->
        super
        @y = 300
    touchendEvent:() ->
        game.pause_scene.setSaveMenu()

class baseOkButton extends Button
    constructor:()->
        super 150, 45
        @image = @drawStrokeRect('#cccccc', '#FF5495', 3)
    ontouchend: (e) ->
        @touchendEvent()

class saveOkButton extends baseOkButton
    constructor:()->
        super
        @x = 157
        @y = 412
    touchendEvent:() ->
        game.pause_scene.removeSaveMenu()