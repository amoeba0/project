class pauseScene extends appScene
    constructor: () ->
        super
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @pause_back = new pauseBack()
        @addChild(@pause_back)
        @pause_main_layer = new pauseMainLayer()
        @addChild(@pause_main_layer)
        @pause_save_layer = new pauseSaveLayer()
    setSaveMenu: () ->
        @addChild(@pause_save_layer)
        @_exeGameSave()
    removeSaveMenu:()->
        @removeChild(@pause_save_layer)
    onenterframe: (e) ->
        @_pauseKeyPush()
    ###
    ポーズキーまたはポーズボタンを押した時の動作
    ###
    _pauseKeyPush:()->
        if game.input.x is true || @buttonList.pause is true
            if @keyList.pause is false
                game.popPauseScene()
                @keyList.pause = true
        else
            if @keyList.pause = true
                @keyList.pause = false
    ###
    データ保存の実行
    ###
    _exeGameSave:()->
        saveData = {
            'money'    : game.money,
            'bet'      : game.bet,
            'combo'    : game.combo,
            'tension'  : game.tension,
            'past_fever_num' : game.past_fever_num
            'prev_muse': JSON.stringify(game.slot_setting.prev_muse)
        }
        for key, val of saveData
            window.localStorage.setItem(key, val)