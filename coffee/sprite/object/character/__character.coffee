class Character extends appObject
    constructor: (w, h) ->
        super w, h
        @moveFlg = {'left':false, 'right':false, 'jump':false}
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
        @ax = 1.5 #x軸加速度
        @mx = 8 #x軸速度最大値
        @my = 22 #y軸初速度
    onenterframe: (e) ->
        @charMove()
    ###キャラクターの動き###
    charMove:()->
        @_speedWidthFloor()
        @_moveExe()

    ###地面にいるときの横向きの速度を決める###
    _speedWidthFloor:()->
        if @moveFlg.right is true
            if @vx < 0
                @vx = 0
            else if @vx < @mx
                @vx += @ax
        else if @moveFlg.left is true
            if @vx > 0
                @vx = 0
            else if @vx > @mx * -1
                @vx -= @ax
        else
            if @vx > 0
                @vx -= @friction
                if @vx < 0
                    @vx = 0
            if @vx < 0
                @vx += @friction
                if @vx > 0
                    @vx = 0
    ###動きの実行###
    _moveExe:()->
        velocityX = 0
        if @vx > 0
            velocityX = Math.floor(@vx)
        else
            velocityX = Math.ceil(@vx)
        @x += velocityX
