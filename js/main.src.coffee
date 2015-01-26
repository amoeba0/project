enchant()
window.onload = ->
    game = new Game(320, 320)
    game.fps = 24
    game.preload('images/chara1.png')

    game.onload = ->
        bear = new Bear(32, 32, "images/chara1.png")
        game.rootScene.addChild(bear)

    game.start()




class appSprite extends Sprite
    constructor: (w, h, image) ->
        super w, h


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


