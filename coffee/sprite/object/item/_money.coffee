###
降ってくるお金
@param boolean isHoming trueならコインがホーミングする
###
class Money extends Item
    constructor: (isHoming, width, height) ->
        super width, height
        @vx = 0
        @vy = 0
        @frame_init = 0
        @price = 1 #単価
        @gravity = 0.37
        @image = game.imageload("coin")
        @catch_se = game.soundload("medal")
        @isHoming = isHoming
        @_setGravity()

    onenterframe: (e) ->
        @homing()
        @_animation()
        @vy += @gravity
        @y += @vy
        @x += @vx
        @hitPlayer()
        @removeOnFloor()

    _setGravity:()->
        if @isHoming is true
            @gravity = 1.5
    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            game.sePlay(@catch_se)
            game.main_scene.gp_stage_back.removeChild(@)
            game.money += @price
            if 9.99999999999 * Math.pow(10, 71) < game.money
                game.money　= 9.99999999999 * Math.pow(10, 71)
            if game.max_money < game.money
                game.max_money = game.money
            game.main_scene.gp_system.money_text.setValue()
            game.slot_setting.betUp()

    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            game.main_scene.gp_stage_back.removeChild(@)

    setPosition:()->
        @y = @h * -1
        @x = Math.floor((game.width - @w) * Math.random())

    ###
    ホーミングする
    ###
    homing:()->
        if @isHoming is true
            @vx = Math.round( (game.main_scene.gp_stage_front.player.x - @x) / ((game.main_scene.gp_stage_front.player.y - @y) / @vy) )

    _animation:()->
        tmp_frm = @age % 24
        switch tmp_frm
            when 0
                @scaleX *= -1
                @frame = @frame_init
            when 3
                @frame = @frame_init + 1
            when 6
                @frame = @frame_init + 2
            when 9
                @frame = @frame_init + 3
            when 12
                @scaleX *= -1
                @frame = @frame_init + 3
            when 15
                @frame = @frame_init + 2
            when 18
                @frame = @frame_init + 1
            when 21
                @frame = @frame_init


class valiableMoney extends Money
    constructor: (isHoming, pow) ->
        super isHoming, 26, 30
        if 9 <= pow
            @width = 30
            @image = game.imageload("coin_pla")
        @price = Math.pow(10, pow)
        if pow <= 2
            @frame = 0
            @frame_init = 0
        else if pow <= 5
            @frame = 4
            @frame_init = 4
        else if pow <= 8
            @frame = 8
            @frame_init = 8
        else if pow <= 11
            @frame = 0
            @frame_init = 0
        else if pow <= 14
            @frame = 4
            @frame_init = 4
        else
            @frame = 8
            @frame_init = 8