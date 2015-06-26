###
降ってくるお金
@param boolean isHoming trueならコインがホーミングする
###
class Money extends Item
    constructor: (isHoming) ->
        super 48, 48
        @scaleX = 0.5
        @scaleY = 0.5
        @vx = 0
        @vy = 0
        @price = 1 #単価
        @gravity = 0.5
        @image = game.imageload("icon1")
        @isHoming = isHoming
        @_setGravity()

    onenterframe: (e) ->
        @homing()
        @vy += @gravity
        @y += @vy
        @x += @vx
        @hitPlayer()
        @removeOnFloor()

    _setGravity:()->
        if @isHoming is true
            @gravity = 2
    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
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

###
1円
@param boolean isHoming trueならコインがホーミングする
###
class OneMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 1
        @frame = 7

###
10円
@param boolean isHoming trueならコインがホーミングする
###
class TenMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10
        @frame = 7

###
100円
@param boolean isHoming trueならコインがホーミングする
###
class HundredMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 100
        @frame = 5

###
1000円
@param boolean isHoming trueならコインがホーミングする
###
class ThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 1000
        @frame = 5

###
一万円
@param boolean isHoming trueならコインがホーミングする
###
class TenThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10000
        @frame = 4

###
10万円
@param boolean isHoming trueならコインがホーミングする
###
class HundredThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 100000
        @frame = 4