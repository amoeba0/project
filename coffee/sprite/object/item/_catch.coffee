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
        if game.main_scene.gp_stage_front.player.intersect(@)
            game.main_scene.gp_stage_front.removeChild(@)
            game.combo += 1
            game.main_scene.gp_system.combo_text.setValue()
            game.main_scene.gp_slot.slotStop()
            game.tensionSetValueItemCatch()

    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            game.main_scene.gp_stage_front.removeChild(@)
            game.combo = 0
            game.main_scene.gp_system.combo_text.setValue()
            game.tensionSetValueItemFall()

    ###
    座標と落下速度の設定
    ###
    setPosition:()->
        @y = @h * -1
        @x = @_setPositoinX()
        @frame = game.slot_setting.getCatchItemFrame()
        @gravity = 1

    ###
    X座標の位置の設定
    ###
    _setPositoinX:()->
        ret_x = 0
        if game.debug.item_flg
            ret_x = game.main_scene.gp_stage_front.player.x
        else
            ret_x = Math.floor((game.width - @w) * Math.random())
        return ret_x

###
マカロン
###
class MacaroonCatch extends Catch
    constructor: (w, h) ->
        super 50, 50
        @image = game.imageload("sweets")
        @frame = 1
        @scaleX = 1.5
        @scaleY = 1.5