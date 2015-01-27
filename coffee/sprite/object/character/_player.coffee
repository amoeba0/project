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