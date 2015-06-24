###
降ってくるお金
###
class Money extends Item
    constructor: (w, h) ->
        super w, h
        @price = 1 #単価
        super 48, 48
        @image = game.imageload("icon1")

    onenterframe: (e) ->
        @vy += @gravity
        @y += @vy
        @hitPlayer()
        @removeOnFloor()

    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if @parentNode.player.intersect(@)
            @parentNode.removeChild(@)
            game.money += @price
            game.main_scene.gp_system.money_text.setValue()

###
ホーミングする
###
class HomingMoney extends Money
    constructor: (w, h) ->
        super w, h

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