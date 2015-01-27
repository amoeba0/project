enchant()
window.onload = ->
    game = new MyGame()
    game.start()
class appGroup extends Group
class appLabel extends Label
class appNode extends Node
class appScene extends Scene
class appSprite extends Sprite
    constructor: (w, h, image) ->
        super w, h
class MyGame extends Game
    constructor:(w, h)->
        super @width, @height
        @width = 320
        @height = 320
        @fps = 24
        @preload('images/chara1.png')

    onload:() ->
        bear = new Bear(32, 32, "images/chara1.png")
        @rootScene.addChild(bear)
class text extends appLabel
class gameCycle extends appNode
class objectCtrl extends appNode
class slotCtrl extends appNode
class mainScene extends appScene
class titleScene extends appScene
class backGround extends appSprite
    constructor: (w, h, image) ->
        super w, h, image
class Floor extends backGround
    constructor: (w, h, image) ->
        super w, h, image
class Panorama extends backGround
    constructor: (w, h, image) ->
        super w, h, image
class appObject extends appSprite
    constructor: (w, h, image) ->
        super w, h, image
class Character extends appObject
    constructor: (w, h, image) ->
        super w, h, image
class Guest extends Character
    constructor: (w, h, image) ->
        super w, h, image
class Player extends Character
    constructor: (w, h, image) ->
        super w, h, image

class Bear extends Player
    constructor: (w, h, image) ->
        super 32, 32, image
        @image = Game.instance.assets[image]
        @x = 0
        @y = 0

    onenterframe: (e) ->
        @x = @x + 1
class Item extends appObject
    constructor: (w, h, image) ->
        super w, h, image
class Catch extends Item
    constructor: (w, h, image) ->
        super w, h, image
class Money extends Item
    constructor: (w, h, image) ->
        super w, h, image
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