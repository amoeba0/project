class pauseItemBuyLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemBuyDialogHtml()
        @close_button = new itemBuyDialogCloseButton()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @item_list = {}
        for i in [1..9]
            @item_list[i] = new buyItemHtml(i)
        @member_list = {}
        for i in [11..19]
            @member_list[i] = new buyMemberHtml(i)
        @setItemList()
        @item_title = new itemItemBuyDiscription()
        @addChild(@item_title)
        @member_title = new memberItemBuyDiscription()
        @addChild(@member_title)
    setItemList:()->
        for item_key, item_val of @item_list
            @addChild(item_val)
            item_val.setPosition()
        for member_key, member_val of @member_list
            @addChild(member_val)
            member_val.setPosition()

class pauseItemBuySelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new itemBuySelectDialogHtml()
        @cancel_button = new itemBuyCancelButtonHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
        @addChild(@cancel_button)
    setSelectItem:(kind)->
        item_options = game.slot_setting.item_list[kind]
        if item_options is undefined
            item_options = game.slot_setting.item_list[0]
        @item_name.setText(item_options.name)
        @item_image.setImage(item_options.image)
        discription = @_setDiscription(item_options)
        @item_discription.setText(discription)
    _setDiscription:(item_options)->
        text = '効果：'+item_options.discription
        if item_options.durationSec != undefined
            text += '<br>持続時間：'+item_options.durationSec+'秒'
        if item_options.condFunc() is true
            text += '<br>値段：'+item_options.price+'円'
        else
            text += '<br>出現条件：'+item_options.conditoin
        return text
