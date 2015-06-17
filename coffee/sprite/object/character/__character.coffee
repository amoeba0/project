class Character extends appObject
    constructor: (w, h) ->
        super w, h
        # キャラクターの動作を操作するフラグ
        @moveFlg = {'left':false, 'right':false, 'jump':false}
        @isAir = true; #空中判定
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
        @ax = 4 #x軸加速度
        @mx = 8 #x軸速度最大値
        @my = 25 #y軸初速度
    onenterframe: (e) ->
        @charMove()

    ###キャラクターの動き###
    charMove:()->
        vx = @vx
        vy = @vy
        if @isAir is true
            vy = @_speedHeight(vy)
            vx = @_speedWidthAir(vx)
        else
            vx = @_speedWidthFloor(vx)
            vy = @_separateFloor()
        @_moveExe(vx, vy)
        @_direction()
        @_animation()

    ###
    地面にいるキャラクターを地面から離す
    ジャンプボタンをおした時、足場から離れた時など
    ###
    _separateFloor:()->
        vy = 0
        if @moveFlg.jump is true
            vy -= @my
            @isAir = true
        return vy

    ###
    地面にいるときの横向きの速度を決める
    @vx num x軸速度
    @return num
    ###
    _speedWidthFloor:(vx)->
        if @moveFlg.right is true
            if vx < 0
                vx = 0
            else if vx < @mx
                vx += @ax
        else if @moveFlg.left is true
            if vx > 0
                vx = 0
            else if vx > @mx * -1
                vx -= @ax
        else
            if vx > 0
                vx -= @friction
                if vx < 0
                    vx = 0
            if vx < 0
                vx += @friction
                if vx > 0
                    vx = 0
        return vx

    ###
    空中にいるときの横向きの速度を決める
    @vy num y軸速度
    @return num
    ###
    _speedWidthAir:(vx)->
        return vx

    ###
    縦向きの速度を決める
    @vy num y軸速度
    @return num
    ###
    _speedHeight:(vy) ->
        vy += @gravity
        #上昇
        if vy < 0
            if @moveFlg.jump is false
                vy = 0
        #下降
        else
            if @_crossFloor() is true
                vy = 0
        return vy

    ###地面にめり込んでる時trueを返す###
    _crossFloor:()->
        flg = false
        if @vy > 0 && @y + @h > @parentNode.floor
            flg = true
        return flg

    ###
    動きの実行
    @ｖx num x軸速度
    @vy num y軸速度
    ###
    _moveExe:(vx, vy)->
        velocityX = 0
        velocityY = 0
        if vx > 0
            velocityX = Math.floor(vx)
        else
            velocityX = Math.ceil(vx)
        if vy > 0
            velocityY = Math.floor(vy)
        else
            velocityY = Math.ceil(vy)
        @vx = vx
        @vy = vy
        @x += velocityX
        @y += velocityY
        if @isAir is true && @_crossFloor() is true
            @vy = 0
            @y = @parentNode.floor - @h
            @isAir = false

    ###
    ボタンを押している方向を向く
    ###
    _direction:()->
        if @moveFlg.right is true && @scaleX < 0
            @scaleX *= -1
        else if @moveFlg.left is true && @scaleX > 0
            @scaleX *= -1

    ###
    アニメーションする
    ###
    _animation:()->
        if @isAir is false
            if @vx is 0
                @frame = 0
            else
                tmpAge = @age % 10
                if tmpAge <= 5
                    @frame = 1
                else
                    @frame = 2
