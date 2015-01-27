enchant()
window.onload = ->
    game = new MyGame()
    game.start()
class appGroup extends Group
    constructor: () ->
        super
class appLabel extends Label
    constructor: () ->
        super
class appNode extends Node
    constructor: () ->
        super
class appScene extends Scene
    constructor: () ->
        super
class appSprite extends Sprite
    constructor: (w, h) ->
        super w, h
class MyGame extends Game
    constructor:(w, h)->
        super @width, @height
        @width = 320
        @height = 320
        @fps = 24
        @preload('images/chara1.png')

    onload:() ->
        @main_scene = new mainScene()
        @pushScene(@main_scene)
class text extends appLabel
    constructor: () ->
        super
class gameCycle extends appNode
    constructor: () ->
        super
class objectCtrl extends appNode
    constructor: () ->
        super
class slotCtrl extends appNode
    constructor: () ->
        super
class mainScene extends appScene
    constructor:()->
        super
        @initial()
    initial:()->
        @setPlayer()
    setPlayer:()->
        @bear = new Bear()
        @addChild(@bear)
class titleScene extends appScene
    constructor: () ->
        super
class backGround extends appSprite
    constructor: (w, h) ->
        super w, h
class Floor extends backGround
    constructor: (w, h) ->
        super w, h
class Panorama extends backGround
    constructor: (w, h) ->
        super w, h
class appObject extends appSprite
    constructor: (w, h) ->
        super w, h
class Character extends appObject
    constructor: (w, h) ->
        super w, h
class Guest extends Character
    constructor: (w, h) ->
        super w, h
class Player extends Character
    constructor: (w, h) ->
        super w, h

class Bear extends Player
    constructor: () ->
        super 32, 32
        @image = Game.instance.assets["images/chara1.png"]
        @x = 0
        @y = 0

    onenterframe: (e) ->
        @x = @x + 1
class Item extends appObject
    constructor: (w, h) ->
        super w, h
class Catch extends Item
    constructor: (w, h) ->
        super w, h
class Money extends Item
    constructor: (w, h) ->
        super w, h
class Slot extends appSprite
    constructor: (w, h, image) ->
        super w, h, image
class System extends appSprite
    constructor: (w, h, image) ->
        super w, h, image
class Button extends System
    constructor: (w, h, image) ->
        super w, h, image
class Param extends System
    constructor: (w, h, image) ->
        super w, h, image