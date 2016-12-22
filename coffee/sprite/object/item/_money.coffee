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



###
1円
@param boolean isHoming trueならコインがホーミングする
###
class OneMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 1
        @frame = 0
        @frame_init = 0

###
10円
@param boolean isHoming trueならコインがホーミングする
###
class TenMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 10
        @frame = 0
        @frame_init = 0

###
100円
@param boolean isHoming trueならコインがホーミングする
###
class HundredMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 100
        @frame = 4
        @frame_init = 4

###
1000円
@param boolean isHoming trueならコインがホーミングする
###
class ThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 1000
        @frame = 4
        @frame_init = 4

###
一万円
@param boolean isHoming trueならコインがホーミングする
###
class TenThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 10000
        @frame = 8
        @frame_init = 8

###
10万円
@param boolean isHoming trueならコインがホーミングする
###
class HundredThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 100000
        @frame = 8
        @frame_init = 8

###
100万円
@param boolean isHoming trueならコインがホーミングする
###
class OneMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 1000000
        @frame = 0
        @frame_init = 0

###
1000万円
@param boolean isHoming trueならコインがホーミングする
###
class TenMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 10000000
        @frame = 0
        @frame_init = 0

###
1億円
@param boolean isHoming trueならコインがホーミングする
###
class OneHundredMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 100000000
        @frame = 4
        @frame_init = 4

###
10億円
@param boolean isHoming trueならコインがホーミングする
###
class BillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 1000000000
        @frame = 4
        @frame_init = 4

###
100億円
@param boolean isHoming trueならコインがホーミングする
###
class TenBillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 10000000000
        @frame = 8
        @frame_init = 8

###
1000億円
@param boolean isHoming trueならコインがホーミングする
###
class OneHundredBillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 100000000000
        @frame = 8
        @frame_init = 8

###
1兆円
@param boolean isHoming trueならコインがホーミングする
###
class OneTrillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 1000000000000
        @frame = 8
        @frame_init = 8

###
10兆円
@param boolean isHoming trueならコインがホーミングする
###
class TenTrillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 10000000000000
        @frame = 8
        @frame_init = 8

###
100兆円
@param boolean isHoming trueならコインがホーミングする
###
class OneHundredTrillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 100000000000000
        @frame = 8
        @frame_init = 8

###
1000兆円
@param boolean isHoming trueならコインがホーミングする
###
class AThousandTrillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 1000000000000000
        @frame = 8
        @frame_init = 8