class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = '#93F0FF'
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        #ソフトキーのリスト
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_panorama = new gpPanorama()
        @addChild(@gp_panorama)
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
        if game.input.left is true || @buttonList.left is true
            if @keyList.left is false
                @keyList.left = true
                @gp_system.left_button.changePushColor()
        else
            if @keyList.left is true
                @keyList.left = false
                @gp_system.left_button.changePullColor()
        # 右
        if game.input.right is true || @buttonList.right is true
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
            if @keyList.pause = true
                @keyList.pause = false

    ###
    フィーバー中に一定時間でテンションが下がる
    テンションが0になったらフィーバーを解く
    ###
    tensionSetValueFever:()->
        if game.fever is true
            game.tensionSetValue(game.fever_down_tension)
            if game.tension <= 0
                game.bgmStop(game.main_scene.gp_slot.fever_bgm)
                @gp_system.changeBetChangeFlg(true)
                game.fever = false