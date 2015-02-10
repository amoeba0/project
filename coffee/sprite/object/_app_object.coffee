class appObject extends appSprite
    constructor: (w, h) ->
        super w, h
        @gravity = 1.4 #物体に働く重力
        @friction = 0.9 #物体に働く摩擦