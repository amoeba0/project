class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = '#93F0FF'
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false, 'white':false}
        #ソフトキーのリスト
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        #ジャイロセンサのリスト
        @gyroList = {'left':false, 'right':false}
        @bgm = game.soundload("bgm/bgm1")
        @initial()
    initial:()->
        @setGroup()
        if game.isSumaho()
            @_gyroMove()
    setGroup:()->
        @gp_back_panorama = new gpBackPanorama()
        @addChild(@gp_back_panorama)
        @gp_front_panorama = new gpFrontPanorama()
        @addChild(@gp_front_panorama)
        @gp_stage_back = new stageBack()
        @addChild(@gp_stage_back)
        @gp_slot = new gpSlot()
        @addChild(@gp_slot)
        @gp_effect = new gpEffect()
        @addChild(@gp_effect)
        @gp_stage_front = new stageFront()
        @addChild(@gp_stage_front)
        @gp_system = new gpSystem()
        @addChild(@gp_system)
        @gp_slot.x = 55
        @gp_slot.y = 130
    onenterframe: (e) ->
        @buttonPush()
        @tensionSetValueFever()
    ###ボタン操作、物理キーとソフトキー両方に対応###
    buttonPush:()->
        # 左
        if game.input.left is true || @buttonList.left is true || (@buttonList.right is false && @gyroList.left is true)
            if @keyList.left is false
                @keyList.left = true
                @gp_system.left_button.changePushColor()
        else
            if @keyList.left is true
                @keyList.left = false
                @gp_system.left_button.changePullColor()
        # 右
        if game.input.right is true || @buttonList.right is true || (@buttonList.left is false && @gyroList.right is true)
            if @keyList.right is false
                @keyList.right = true
                @gp_system.right_button.changePushColor()
        else
            if @keyList.right is true
                @keyList.right = false
                @gp_system.right_button.changePullColor()
        # 上
        if game.input.up is true || @buttonList.up is true
            if @keyList.up is false
                @keyList.up = true
                @gp_system.heigh_bet_button.changePushColor()
        else
            if @keyList.up is true
                @keyList.up = false
                @gp_system.heigh_bet_button.changePullColor()
        # 下
        if game.input.down is true || @buttonList.down is true
            if @keyList.down is false
                @keyList.down = true
                @gp_system.low_bet_button.changePushColor()
        else
            if @keyList.down is true
                @keyList.down = false
                @gp_system.low_bet_button.changePullColor()
        # ジャンプ
        if game.input.z is true || @buttonList.jump is true
            if @keyList.jump is false
                @keyList.jump = true
                @gp_system.jump_button.changePushColor()
        else
            if @keyList.jump is true
                @keyList.jump = false
                @gp_system.jump_button.changePullColor()
        #ポーズ
        if game.input.x is true || @buttonList.pause is true
            if @keyList.pause is false
                game.setPauseScene()
                @keyList.pause = true
        else
            if @keyList.pause is true
                @keyList.pause = false
        #画面ホワイトアウト
        if game.input.c is true
            if @keyList.white is false
                @gp_system.whiteOut()
                @keyList.white = true
        else
            if @keyList.white is true
                @keyList.white = false

    ###
    フィーバー中に一定時間でテンションが下がる
    テンションが0になったらフィーバーを解く
    ###
    tensionSetValueFever:()->
        if game.fever is true
            game.tensionSetValue(game.fever_down_tension)
            if game.tension <= 0
                game.autoMemberSetAfeterFever()
                game.main_scene.gp_slot.upperFrame.frame = 0
                game.pause_scene.pause_main_layer.save_game_button.makeAble()
                game.bgmStop(game.main_scene.gp_slot.fever_bgm)
                #game.bgmPlay(@bgm, true)
                @gp_system.changeBetChangeFlg(true)
                @gp_effect.feverEffectEnd()
                game.fever = false

    _gyroMove:()->
        window.addEventListener("deviceorientation",
            (evt)->
                x = evt.gamma
                if 15 < x
                    game.main_scene.gyroList.right = true
                else if x < -15
                    game.main_scene.gyroList.left = true
                else
                    game.main_scene.gyroList.right = false
                    game.main_scene.gyroList.left = false
            , false
        )