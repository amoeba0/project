class Item extends appObject
    constructor: (w, h) ->
        super w, h
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度