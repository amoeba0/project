class pauseItemUseLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemUseDialogHtml()
        @close_button = new itemUseDialogCloseButton()
        @menu_title = new itemUseDiscription()
        @set_title = new useSetDiscription()
        @have_title = new useHaveDiscription()
        @speed_title = new speedDiscription()
        @set_title.y = 140
        @have_title.y = 300
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@menu_title)
        @addChild(@set_title)
        @addChild(@have_title)
        @addChild(@speed_title)
        @item_list = {} #アイテム所持リスト
        @set_item_list = {} #アイテムセット中リスト
        for i in [1..9]
            @item_list[i] = new useItemHtml(i)
        for i in [1..game.limit_set_item_num]
            @set_item_list[i] = new setItemHtml(i)
            @addChild(@set_item_list[i])
        @setItemList()
        @dspSetItemList()
    setItemList:()->
        for item_key, item_val of @item_list
            @addChild(item_val)
            item_val.setPosition()
    resetItemList:()->
        for item_key, item_val of @item_list
            if game.item_set_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 0
                item_val.changeNotButton()
                item_val.is_exist = false
            else if game.item_have_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 1
                item_val.removeDomClass('grayscale', true)
                item_val.changeIsButton()
                item_val.is_exist = true
            else
                item_val.opacity = 0.5
                item_val.addDomClass('grayscale', true)
                item_val.changeNotButton()
                item_val.is_exist = false
    #セットされているアイテムをレンダリングする
    dspSetItemList:()->
        game.setItemSlot()
        @resetItemList()
        for item_key, item_val of @set_item_list
            item_val.setPosition()
            if game.max_set_item_num < item_key
                item_val.setItemKind(0)
                item_val.opacity = 0.5
                item_val.changeNotButton()
                item_val.addDomClass('grayscale', true)
            else if game.item_set_now[item_key - 1] != undefined
                item_val.setItemKind(game.item_set_now[item_key - 1])
                item_val.opacity = 1
                item_val.changeIsButton()
                item_val.removeDomClass('grayscale', true)
            else
                item_val.setItemKind(0)
                item_val.opacity = 1
                item_val.changeIsButton()
                item_val.removeDomClass('grayscale', true)

class pauseItemUseSelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new itemUseSelectDialogHtml()
        @cancel_button = new itemUseCancelButtonHtml()
        @set_button = new itemUseSetButtonHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@cancel_button)
        @addChild(@set_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @set_button.setText(kind)
        @item_kind = kind
        @item_options = game.slot_setting.item_list[kind]
        if @item_options is undefined
            @item_options = game.slot_setting.item_list[0]
        @item_name.setText(@item_options.name)
        @item_image.setImage(@item_options.image)
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        if @item_options.durationSec != undefined
            text += '<br>持続時間：'+@item_options.durationSec+'秒'
        return text
    setItem:()->
        @_itemSet(@item_kind)
        game.slot_setting.setItemDecreasePoint()
        game.main_scene.gp_system.itemDsp()
        game.pause_scene.pause_item_use_layer.dspSetItemList()
        game.pause_scene.removeItemUseSelectMenu()
    #アイテムをセットする
    _itemSet:(kind)->
        if game.item_set_now.indexOf(parseInt(kind)) == -1
            if (game.max_set_item_num <= game.item_set_now.length)
                game.item_set_now.shift()
            game.item_set_now.push(kind)
        else
            game.item_set_now = game.arrayValueDel(game.item_set_now, kind)
            game.prev_item = []