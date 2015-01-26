enchant()
window.onload = ->
    game = new MyGame()
    game.start()




class appSprite extends Sprite
    constructor: (w, h, image) ->
        super w, h
class MyGame extends Game
    constructor:(w, h)->
        super width, height
        @width = 320
        @height = 320
        @fps = 24
        @preload('images/chara1.png')

    onload:() ->
        bear = new Bear(32, 32, "images/chara1.png")
        @rootScene.addChild(bear)

class Character extends appSprite
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


