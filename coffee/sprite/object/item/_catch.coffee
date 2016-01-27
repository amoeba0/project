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
            game.main_scene.gp_effect.setItemChatchEffect(@x, @y)
            game.main_scene.gp_stage_front.removeChild(@)
            game.combo += 1
            if game.combo > game.max_combo
                game.max_combo = game.combo
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
            if game.isItemSet(6) is false
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
        if game.isItemSet(9)
            ret_x = Math.floor(game.main_scene.gp_stage_front.player.x + (game.width * 0.5 * Math.random()) - (game.width * 0.25))
            if ret_x < 0
                ret_x = 0
            if ret_x > (game.width - @w)
                ret_x = game.width - @w
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
            game.main_scene.gp_stage_front.setExplosionEffect(@x, @y)
            game.sePlay(@miss_se)
            game.main_scene.gp_stage_front.removeChild(@)
            game.tensionSetValueMissItemCatch()
            game.main_scene.gp_stage_front.player.vx = 0
            game.main_scene.gp_stage_front.player.vy = 0
    removeOnFloor:()->
        if @y > game.height + @h
            game.main_scene.gp_stage_front.removeChild(@)
    setPosition:()->
        @y = @h * -1
        @x = @setPositoinX()
        @gravity = game.slot_setting.setGravity()