class pauseScene extends appScene
    constructor: () ->
        super
        @gp_main_menu = new gpMainMenu()
        @gp_save_menu = new gpSaveMenu()
        @addChild(@gp_main_menu)
    setSaveMenu: () ->
        @addChild(@gp_save_menu)
        @_exeGameSave()
    removeSaveMenu:()->
        @removeChild(@gp_save_menu)
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