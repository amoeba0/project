###
キャッチする用のアイテム
###
class Catch extends Item
    constructor: (w, h) ->
        super w, h
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
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
            console.log('hit!')
    ###
    座標と落下速度の設定
    ###
    setPosition:(gravity)->
        @y = @h * -1
        @x = Math.floor((game.width - @w) * Math.random())
        @gravity = gravity
    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            @parentNode.removeChild(@)

###
マカロン
###
class MacaroonCatch extends Catch
    constructor: (w, h) ->
        super 16, 16
        @image = game.imageload("icon1")