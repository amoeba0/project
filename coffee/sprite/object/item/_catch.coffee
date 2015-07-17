###
キャッチする用のアイテム
###
class Catch extends Item
    constructor: (w, h) ->
        super w, h
        @miss_se = game.soundload('cancel')
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
            game.sePlay(@miss_se)
            game.main_scene.gp_stage_front.removeChild(@)
            game.combo = 0
            game.main_scene.gp_system.combo_text.setValue()
            game.tensionSetValueItemFall()

    ###
    座標と落下速度の設定
    ###
    setPosition:()->
        @y = @h * -1
        @x = @setPositoinX()
        @frame = game.slot_setting.getCatchItemFrame()
        @gravity = game.slot_setting.setGravity()

    ###
    X座標の位置の設定
    ###
    setPositoinX:()->
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
        super 37, 37
        @image = game.imageload("sweets")
        @frame = 1
        @scaleX = 1.5
        @scaleY = 1.5

class OnionCatch extends Catch
    constructor: (w, h) ->
        super 37, 37
        @image = game.imageload("sweets")
        @frame = 5
        @scaleX = 1.5
        @scaleY = 1.5
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            game.sePlay(@miss_se)
            game.main_scene.gp_stage_front.removeChild(@)
            game.tensionSetValueMissItemCatch()
    removeOnFloor:()->
        if @y > game.height + @h
            game.main_scene.gp_stage_front.removeChild(@)
    setPosition:()->
        @y = @h * -1
        @x = @setPositoinX()
        @gravity = game.slot_setting.setGravity()