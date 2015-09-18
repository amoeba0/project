class pauseScene extends appScene
    constructor: () ->
        super
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @pause_back = new pauseBack()
        @pause_main_layer = new pauseMainLayer()
        @pause_save_layer = new pauseSaveLayer()
        @pause_item_buy_layer = new pauseItemBuyLayer()
        @pause_item_use_layer = new pauseItemUseLayer()
        @pause_member_set_layer = new pauseMemberSetLayer()
        @pause_item_buy_select_layer = new pauseItemBuySelectLayer()
        @addChild(@pause_back)
        @addChild(@pause_main_layer)
    setSaveMenu: () ->
        @addChild(@pause_save_layer)
        game.saveGame()
    removeSaveMenu:()->
        @removeChild(@pause_save_layer)
    setItemBuyMenu:()->
        @addChild(@pause_item_buy_layer)
    removeItemBuyMenu:()->
        @removeChild(@pause_item_buy_layer)
    setItemUseMenu:()->
        @pause_item_use_layer.resetItemList()
        @addChild(@pause_item_use_layer)
    removeItemUseMenu:()->
        @removeChild(@pause_item_use_layer)
    setMemberSetMenu:()->
        @pause_member_set_layer.resetItemList()
        @addChild(@pause_member_set_layer)
    removeMemberSetMenu:()->
        @removeChild(@pause_member_set_layer)
    setItemBuySelectMenu:(kind)->
        @addChild(@pause_item_buy_select_layer)
        @pause_item_buy_select_layer.setSelectItem(kind)
    removeItemBuySelectMenu:()->
        @removeChild(@pause_item_buy_select_layer)
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
