class pauseScene extends appScene
    constructor: () ->
        super
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @pause_back = new pauseBack()
        @pause_main_layer = new pauseMainLayer()
        @pause_save_confirm_layer = new pauseSaveConfirmLayer()
        @pause_save_layer = new pauseSaveLayer()
        @pause_title_confirm_layer = new pauseTitleConfirmLayer()
        @pause_item_buy_layer = new pauseItemBuyLayer()
        @pause_item_use_layer = new pauseItemUseLayer()
        @pause_member_set_layer = new pauseMemberSetLayer()
        @pause_item_buy_select_layer = new pauseItemBuySelectLayer()
        @pause_item_use_select_layer = new pauseItemUseSelectLayer()
        @pause_member_use_select_layer = new pauseMemberUseSelectLayer()
        @pause_record_layer = new pauseRecordLayer()
        @pause_record_select_layer = new pauseRecordSelectLayer()
        @pause_trophy_select_layer = new pauseTrophySelectLayer()
        @addChild(@pause_back)
        @addChild(@pause_main_layer)
        @isAblePopPause = true
    setSaveConfirmMenu: () ->
        @addChild(@pause_save_confirm_layer)
        @isAblePopPause = false
    setSaveMenu:()->
        @addChild(@pause_save_layer)
        game.saveGame()
    setTitleConfirmMenu:()->
        @addChild(@pause_title_confirm_layer)
        @isAblePopPause = false
    removeSaveConfirmMenu:()->
        @removeChild(@pause_save_confirm_layer)
        @isAblePopPause = true
    removeTitleConfirmMenu:()->
        @removeChild(@pause_title_confirm_layer)
        @isAblePopPause = true
    removeSaveMenu:()->
        @removeChild(@pause_save_layer)
        @removeChild(@pause_save_confirm_layer)
        @isAblePopPause = true
    setItemBuyMenu:()->
        @addChild(@pause_item_buy_layer)
        @isAblePopPause = false
    removeItemBuyMenu:()->
        @removeChild(@pause_item_buy_layer)
        @isAblePopPause = true
        game.setItemSlot()
    setItemUseMenu:()->
        @pause_item_use_layer.resetItemList()
        @pause_item_use_layer.dspSetItemList()
        @addChild(@pause_item_use_layer)
        @isAblePopPause = false
    removeItemUseMenu:()->
        @removeChild(@pause_item_use_layer)
        @isAblePopPause = true
    setMemberSetMenu:()->
        @pause_member_set_layer.resetItemList()
        @addChild(@pause_member_set_layer)
        @isAblePopPause = false
    removeMemberSetMenu:()->
        @removeChild(@pause_member_set_layer)
        game.musePreLoadByMemberSetNow()
        @isAblePopPause = true
    setItemBuySelectMenu:(kind)->
        @addChild(@pause_item_buy_select_layer)
        @pause_item_buy_select_layer.setSelectItem(kind)
    removeItemBuySelectMenu:()->
        @removeChild(@pause_item_buy_select_layer)
        game.itemUseExe()
    setItemUseSelectMenu:(kind)->
        @addChild(@pause_item_use_select_layer)
        @pause_item_use_select_layer.setSelectItem(kind)
    removeItemUseSelectMenu:()->
        @removeChild(@pause_item_use_select_layer)
        game.itemUseExe()
    setMemberUseSelectMenu:(kind)->
        @addChild(@pause_member_use_select_layer)
        @pause_member_use_select_layer.setSelectItem(kind)
    removeMemberUseSelectMenu:()->
        @removeChild(@pause_member_use_select_layer)
    setRecordMenu:()->
        @addChild(@pause_record_layer)
        @isAblePopPause = false
    removeRecordMenu:()->
        @removeChild(@pause_record_layer)
        @isAblePopPause = true
    setRecordSelectMenu:(kind)->
        @addChild(@pause_record_select_layer)
        @pause_record_select_layer.setSelectItem(kind)
    removeRecordSelectMenu:()->
        @removeChild(@pause_record_select_layer)
    setTrophySelectMenu:(kind)->
        @addChild(@pause_trophy_select_layer)
        @pause_trophy_select_layer.setSelectItem(kind)
    removeTrophySelectmenu:()->
        @removeChild(@pause_trophy_select_layer)
    onenterframe: (e) ->
        @_pauseKeyPush()
    ###
    ポーズキーまたはポーズボタンを押した時の動作
    ###
    _pauseKeyPush:()->
        if game.input.x is true || @buttonList.pause is true
            if @keyList.pause is false
                if @isAblePopPause is true
                    game.popPauseScene()
                @keyList.pause = true
        else
            if @keyList.pause = true
                @keyList.pause = false
