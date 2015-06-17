class appObject extends appSprite
    ###
    制約
    ・objectは必ずstageに対して追加する
    ###
    constructor: (w, h) ->
        super w, h
        @gravity = 1.6 #物体に働く重力
        @friction = 2.3 #物体に働く摩擦