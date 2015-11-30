###
降ってくるお金
@param boolean isHoming trueならコインがホーミングする
###
class Money extends Item
    constructor: (isHoming) ->
        super 26, 30
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
            game.main_scene.gp_system.money_text.setValue()

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



###
1円
@param boolean isHoming trueならコインがホーミングする
###
class OneMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 1
        @frame = 0
        @frame_init = 0

###
10円
@param boolean isHoming trueならコインがホーミングする
###
class TenMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10
        @frame = 0
        @frame_init = 0

###
100円
@param boolean isHoming trueならコインがホーミングする
###
class HundredMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 100
        @frame = 4
        @frame_init = 4

###
1000円
@param boolean isHoming trueならコインがホーミングする
###
class ThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 1000
        @frame = 4
        @frame_init = 4

###
一万円
@param boolean isHoming trueならコインがホーミングする
###
class TenThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10000
        @frame = 8
        @frame_init = 8

###
10万円
@param boolean isHoming trueならコインがホーミングする
###
class HundredThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 100000
        @frame = 8
        @frame_init = 8

###
100万円
@param boolean isHoming trueならコインがホーミングする
###
class OneMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 1000000
        @frame = 8
        @frame_init = 8

###
1000万円
@param boolean isHoming trueならコインがホーミングする
###
class TenMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10000000
        @frame = 8
        @frame_init = 8