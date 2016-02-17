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
        @pause_save_confirm_layer = new pauseSaveConfirmLayer()
        @addChild(@pause_save_confirm_layer)
        @isAblePopPause = false
    setSaveMenu:()->
        @pause_save_layer = new pauseSaveLayer()
        @addChild(@pause_save_layer)
        game.saveGame()
    setTitleConfirmMenu:()->
        @pause_title_confirm_layer = new pauseTitleConfirmLayer()
        @addChild(@pause_title_confirm_layer)
        @isAblePopPause = false
    removeSaveConfirmMenu:()->
        @removeChild(@pause_save_confirm_layer)
        @pause_save_confirm_layer = null
        @isAblePopPause = true
    removeTitleConfirmMenu:()->
        @removeChild(@pause_title_confirm_layer)
        @pause_title_confirm_layer = null
        @isAblePopPause = true
    removeSaveMenu:()->
        @removeChild(@pause_save_layer)
        @removeChild(@pause_save_confirm_layer)
        @pause_save_layer = null
        @pause_save_confirm_layer = null
        @isAblePopPause = true
    setItemBuyMenu:()->
        @pause_item_buy_layer = new pauseItemBuyLayer()
        @addChild(@pause_item_buy_layer)
        @isAblePopPause = false
    removeItemBuyMenu:()->
        @removeChild(@pause_item_buy_layer)
        @isAblePopPause = true
        game.setItemSlot()
    setItemUseMenu:()->
        @pause_item_use_layer = new pauseItemUseLayer()
        @pause_item_use_layer.resetItemList()
        @pause_item_use_layer.dspSetItemList()
        @addChild(@pause_item_use_layer)
        @isAblePopPause = false
    removeItemUseMenu:()->
        @removeChild(@pause_item_use_layer)
        @pause_item_use_layer = null
        @isAblePopPause = true
    setMemberSetMenu:()->
        @pause_member_set_layer = new pauseMemberSetLayer()
        @pause_member_set_layer.resetItemList()
        @addChild(@pause_member_set_layer)
        @isAblePopPause = false
    removeMemberSetMenu:()->
        @removeChild(@pause_member_set_layer)
        @pause_member_set_layer = null
        game.musePreLoadByMemberSetNow()
        @isAblePopPause = true
    setItemBuySelectMenu:(kind)->
        @pause_item_buy_select_layer = new pauseItemBuySelectLayer()
        @addChild(@pause_item_buy_select_layer)
        @pause_item_buy_select_layer.setSelectItem(kind)
    removeItemBuySelectMenu:()->
        @removeChild(@pause_item_buy_select_layer)
        @pause_item_buy_select_layer = null
        game.itemUseExe()
    setItemUseSelectMenu:(kind)->
        @pause_item_use_select_layer = new pauseItemUseSelectLayer()
        @addChild(@pause_item_use_select_layer)
        @pause_item_use_select_layer.setSelectItem(kind)
    removeItemUseSelectMenu:()->
        @removeChild(@pause_item_use_select_layer)
        @pause_item_use_select_layer = null
        game.itemUseExe()
    setMemberUseSelectMenu:(kind)->
        @pause_member_use_select_layer = new pauseMemberUseSelectLayer()
        @addChild(@pause_member_use_select_layer)
        @pause_member_use_select_layer.setSelectItem(kind)
    removeMemberUseSelectMenu:()->
        @removeChild(@pause_member_use_select_layer)
        @pause_member_use_select_layer = null
    setRecordMenu:()->
        @pause_record_layer = new pauseRecordLayer()
        @addChild(@pause_record_layer)
        @isAblePopPause = false
    removeRecordMenu:()->
        @removeChild(@pause_record_layer)
        @pause_record_layer = null
        @isAblePopPause = true
    setRecordSelectMenu:(kind)->
        @pause_record_select_layer = new pauseRecordSelectLayer()
        @addChild(@pause_record_select_layer)
        @pause_record_select_layer.setSelectItem(kind)
    removeRecordSelectMenu:()->
        @removeChild(@pause_record_select_layer)
        @pause_record_select_layer = null
    setTrophySelectMenu:(kind)->
        @pause_trophy_select_layer = new pauseTrophySelectLayer()
        @addChild(@pause_trophy_select_layer)
        @pause_trophy_select_layer.setSelectItem(kind)
    removeTrophySelectmenu:()->
        @removeChild(@pause_trophy_select_layer)
        @pause_trophy_select_layer = null
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
