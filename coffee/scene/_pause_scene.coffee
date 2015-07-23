class pauseScene extends appScene
    constructor: () ->
        super
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
    ###
    データ保存の実行
    ###
    _exeGameSave:()->
        saveData = {
            'money'    : game.money,
            'bet'      : game.bet,
            'combo'    : game.combo,
            'tension'  : game.tension,
            'prev_muse': JSON.stringify(game.slot_setting.prev_muse)
        }
        for key, val of saveData
            window.localStorage.setItem(key, val)