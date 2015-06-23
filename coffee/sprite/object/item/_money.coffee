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
安い
###
class CheapMoney extends Money
    constructor: (w, h) ->
        super w, h
        @price = 10
        @frame = 3

###
普通
###
class NormalMoney extends Money
    constructor: (w, h) ->
        super w, h
        @price = 100
        @frame = 4

###
高い
###
class ExpensiveMoney extends Money
    constructor: (w, h) ->
        super w, h
        @price = 1000
        @frame = 5