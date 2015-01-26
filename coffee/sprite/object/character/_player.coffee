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