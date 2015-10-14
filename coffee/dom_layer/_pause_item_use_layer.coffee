#TODO 持っていないものは半透明、セット中は透明
class pauseItemUseLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemUseDialogHtml()
        @close_button = new itemUseDialogCloseButton()
        @menu_title = new itemUseDiscription()
        @set_title = new useSetDiscription()
        @have_title = new useHaveDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@menu_title)
        @addChild(@set_title)
        @addChild(@have_title)
        @item_list = {}
        for i in [1..9]
            @item_list[i] = new useItemHtml(i)
        @setItemList()
    setItemList:()->
        for item_key, item_val of @item_list
            @addChild(item_val)
            item_val.setPosition()
    resetItemList:()->
        for item_key, item_val of @item_list
            if game.item_have_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 1
                item_val.removeDomClass('grayscale', true)
                item_val.changeIsButton()
            else
                item_val.opacity = 0.5
                item_val.addDomClass('grayscale', true)
                item_val.changeNotButton()