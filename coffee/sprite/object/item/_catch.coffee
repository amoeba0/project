###
キャッチする用のアイテム
###
class Catch extends Item
    constructor: (w, h) ->
        super w, h
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
            game.main_scene.gp_slot.slotStop()
    ###
    座標と落下速度の設定
    ###
    setPosition:(gravity)->
        @y = @h * -1
        @x = @_setPositoinX()
        @gravity = gravity

    ###
    X座標の位置の設定
    ###
    _setPositoinX:()->
        ret_x = 0
        if game.debug.item_flg
            ret_x = @parentNode.player.x
        else
            ret_x = Math.floor((game.width - @w) * Math.random())
        return ret_x

###
マカロン
###
class MacaroonCatch extends Catch
    constructor: (w, h) ->
        super 48, 48
        @image = game.imageload("icon1")
        @frame = 1