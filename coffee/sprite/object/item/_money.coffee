###
降ってくるお金
###
class Money extends Item
    constructor: (w, h) ->
        super 48, 48
        @scaleX = 0.5
        @scaleY = 0.5
        @price = 1 #単価
        @gravity = 2
        @image = game.imageload("icon1")

    onenterframe: (e) ->
        @vy += @gravity
        @y += @vy
        @x += @vx
        @hitPlayer()
        @removeOnFloor()

    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            @parentNode.removeChild(@)
            game.money += @price
            game.main_scene.gp_system.money_text.setValue()

    setPosition:()->
        @y = @h * -1
        @x = Math.floor((game.width - @w) * Math.random())

###
ホーミングする
###
class HomingMoney extends Money
    constructor: (w, h) ->
        super w, h
        @addEventListener('enterframe', ()->
            @vx = Math.round( (game.main_scene.gp_stage_front.player.x - @x) / ((game.main_scene.gp_stage_front.player.y - @y) / @vy) )
        )
###
1円
###
class OneHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 1
        @frame = 2

###
10円
###
class TenHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 10
        @frame = 7

###
100円
###
class HundredHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 100
        @frame = 5

###
1000円
###
class ThousandHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 1000
        @frame = 4