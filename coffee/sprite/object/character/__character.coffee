class Character extends appObject
    constructor: (w, h) ->
        super w, h
        # キャラクターの動作を操作するフラグ
        @moveFlg = {'left':false, 'right':false, 'jump':false}
        @jump_se = game.soundload('jump')
        @isAir = true; #空中判定
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
        @ax = 3 #x軸加速度
        @mx = 7 #x軸速度最大値
        @my = 19 #y軸初速度
        @ax_init = 3
        @ax_up = 5
        @ax_up2 = 7
        @ax_up3 = 9
        @mx_init = 7
        @mx_up = 11
        @mx_up2 = 15
        @mx_up3 = 19
        @my_init = 19
        @my_up = 22
        @my_up2 = 25
        @my_up3 = 28
        @friction_init = 1.7
        @friction_up = 3
        @friction_up2 = 4.5
        @friction_up3 = 6
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
            @jumpSound()
            vy -= @my
            @isAir = true
        return vy

    jumpSound:()->

    ###
    地面にいるときの横向きの速度を決める
    @vx num x軸速度
    @return num
    ###
    _speedWidthFloor:(vx)->
        if @moveFlg.right is true && @stopAtRight() is true
            if vx < 0
                vx = 0
            else if vx < @mx
                vx += @ax
        else if @moveFlg.left is true && @stopAtLeft() is true
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
        vx = @stopAtEnd(vx)
        return vx

    ###
    空中にいるときの横向きの速度を決める
    @vy num y軸速度
    @return num
    ###
    _speedWidthAir:(vx)->
        air = 0.5
        if @moveFlg.right is true && @stopAtRight() is true
            if vx < 0
                vx = 0
            else if vx < Math.floor(@mx * 10 * air) / 10
                vx += Math.floor(@ax * 10 * air) / 10
        else if @moveFlg.left is true && @stopAtLeft() is true
            if vx > 0
                vx = 0
            else if vx > Math.floor(@mx * -10 * air) / 10
                vx -= Math.floor(@ax * 10 * air) / 10
        vx = @stopAtEnd(vx)
        return vx

    ###
    画面端では横向きの速度を0にする
    @param num vx ｘ軸速度
    ###
    stopAtEnd:(vx)->
        return vx

    ###
    画面右端で右に移動するのを許可しない
    ###
    stopAtRight:()->
        return true

    ###
    画面左端で左に移動するのを許可しない
    ###
    stopAtLeft:()->
        return true

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
        if @vy > 0 && @y + @h > game.main_scene.gp_stage_front.floor
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
            @y = game.main_scene.gp_stage_front.floor - @h
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
        else
            @frame = 3

    setMxUp:()->
        if game.now_speed is 3
            @mx = @mx_up3
            @ax = @ax_up3
            @friction = @friction_up3
        else if game.now_speed is 2
            @mx = @mx_up2
            @ax = @ax_up2
            @friction = @friction_up2
        else
            @mx = @mx_up
            @ax = @ax_up
            @friction = @friction_up

    resetMxUp:()->
        if game.now_speed is 3
            @mx = @mx_up2
            @ax = @ax_up2
            @friction = @friction_up2
        else if game.now_speed is 2
            @mx = @mx_up
            @ax = @ax_up
            @friction = @friction_up
        else
            @mx = @mx_init
            @ax = @ax_init
            @friction = @friction_init

    setMyUp:()->
        if game.now_speed is 3
            @my = @my_up3
        else if game.now_speed is 2
            @my = @my_up2
        else
            @my = @my_up

    resetMyUp:()->
        if game.now_speed is 3
            @my = @my_up2
        else if game.now_speed is 2
            @my = @my_up
        else
            @my = @my_init
