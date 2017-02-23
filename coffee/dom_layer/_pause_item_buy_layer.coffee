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
        @trophy_list = {}
        for i in [21..24]
            @trophy_list[i] = new buyTrophyItemHtml(i - 21, i)
        @setItemList()
        @resetItemList()
        @item_title = new itemItemBuyDiscription()
        @addChild(@item_title)
        @member_title = new memberItemBuyDiscription()
        @addChild(@member_title)
        @trophy_title = new trophyItemBuyDiscription()
        @addChild(@trophy_title)
        @skill_help_btn = new helpButtonHtml(1, 50, 80)
        @addChild(@skill_help_btn)
        @member_help_btn = new helpButtonHtml(3, 50, 310)
        @addChild(@member_help_btn)
        @torophy_help_btn = new helpButtonHtml(5, 50, 540)
        @addChild(@torophy_help_btn)
    setItemList:()->
        for item_key, item_val of @item_list
            @addChild(item_val)
            item_val.setPosition()
        for member_key, member_val of @member_list
            @addChild(member_val)
            member_val.setPosition()
        for trophy_key, trophy_val of @trophy_list
            @addChild(trophy_val)
            trophy_val.setPosition()
    #持ってるアイテムを透明にする、クリックできなくする
    resetItemList:()->
        master_list = game.slot_setting.item_list
        for i in [1..19]
            if master_list[i] is undefined
                master_list[i] = master_list[0]
        @_resetItemList(@item_list, master_list)
        @_resetItemList(@member_list, master_list)
        @_resetItemList(@trophy_list, master_list)
    _resetItemList:(item_list, master_list)->
        for item_key, item_val of item_list
            if master_list[item_key].price > game.money
                item_val.opacity = 0.5
                item_val.is_exist = true
                item_val.changeIsButton()
                #item_val.addDomClass('grayscale', true)
            else
                item_val.opacity = 1
                item_val.is_exist = true
                item_val.changeIsButton()
                #item_val.removeDomClass('grayscale', true)
            if game.item_have_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 0
                item_val.is_exist = false
                item_val.changeNotButton()

class pauseItemBuySelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new itemBuySelectDialogHtml()
        @cancel_button = new itemBuyCancelButtonHtml()
        @buy_button = new itemBuyBuyButtonHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
        @addChild(@cancel_button)
        @addChild(@buy_button)
        @item_kind = 0
        @item_options = []
    setSelectItem:(kind)->
        @item_kind = kind
        if 21 <= kind
            @dialog.class.push('base-dialog-select-high')
            @buy_button.y += 20
            @cancel_button.y += 20
            @dialog.setHtml()
        @item_options = game.slot_setting.item_list[kind]
        if @item_options is undefined
            @item_options = game.slot_setting.item_list[0]
        @item_name.setText(@item_options.name)
        @item_image.setImage(@item_options.image)
        discription = @_setDiscription()
        @item_discription.setText(discription)
        @_setButton()
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        text += '<br>値段：'+game.toJPUnit(@item_options.price)+'円'+'(所持金'+game.toJPUnit(game.money)+'円)'
        return text
    _setButton:()->
        if game.money >= @item_options.price
            @cancel_button.setBuyPossiblePosition()
            @buy_button.setBuyPossiblePosition()
        else
            @cancel_button.setBuyImpossiblePositon()
            @buy_button.setBuyImpossiblePositon()
    ###
    アイテムの購入
    ###
    buyItem:()->
        game.money -= @item_options.price
        game.pause_scene.pause_main_layer.statusDsp()
        game.item_have_now.push(@item_kind)
        if 11 <= @item_kind && @item_kind <= 19
            game.slot_setting.setMemberItemPrice()
        game.pause_scene.removeItemBuySelectMenu()
        game.pause_scene.pause_item_buy_layer.resetItemList()
        game.main_scene.gp_system.money_text.setValue()
        if 21 <= @item_kind
            switch @item_kind
                when 21 then game.start2ndStory()
                when 22 then game.start3rdStory()
                when 23 then game.start4thStory()
                when 24 then game.startEdStory()
