class Player extends Character
    constructor: (w, h) ->
        super w, h

class Bear extends Player
    constructor: () ->
        super 32, 32
        @image = game.imageload("chara1")
        @x = 0
        @y = 0

    onenterframe: (e) ->
        @x = @x + 1