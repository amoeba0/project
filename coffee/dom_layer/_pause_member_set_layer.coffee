class pauseMemberSetLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new memberSetDialogHtml()
        @close_button = new memberSetDialogCloseButton()
        @menu_title = new memberSetDiscription()
        @set_title = new useSetDiscription()
        @have_title = new useHaveDiscription()
        @auto_button = new autoMemberSetButtonHtml()
        @unset_button = new autoMemberUnsetButtonHtml()
        @set_title.y = 140
        @have_title.y = 320
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@menu_title)
        @addChild(@set_title)
        @addChild(@have_title)
        @addChild(@auto_button)
        @addChild(@unset_button)
        @member_list = {}
        @set_member_list = {}
        for i in [11..19]
            @member_list[i] = new useMemberHtml(i)
        for i in [1..game.max_set_member_num]
            @set_member_list[i] = new setMemberHtml(i)
            @addChild(@set_member_list[i])
        @setItemList()
        @dispSetMemberList()
    setItemList:()->
        for member_key, member_val of @member_list
            @addChild(member_val)
            member_val.setPosition()
    resetItemList:()->
        for member_key, member_val of @member_list
            if game.member_set_now.indexOf(parseInt(member_key)) != -1
                member_val.opacity = 0
                member_val.changeNotButton()
                member_val.is_exist = false
            else if game.item_have_now.indexOf(parseInt(member_key)) != -1
                member_val.opacity = 1
                member_val.removeDomClass('grayscale', true)
                member_val.changeIsButton()
                member_val.is_exist = true
            else
                member_val.opacity = 0.5
                member_val.addDomClass('grayscale', true)
                member_val.changeNotButton()
                member_val.is_exist = false
    #セットされている部員をレンダリングする
    dispSetMemberList:()->
        @resetItemList()
        now_nuse_set = false
        for member_key, member_val of @set_member_list
            member_val.setPosition()
            if game.member_set_now[member_key - 1] != undefined
                member_val.setItemKind(game.member_set_now[member_key - 1])
                member_val.opacity = 1
                member_val.disabled = false
            else
                if now_nuse_set is false and game.slot_setting.now_muse_num != 0
                    member_val.setItemKind(game.slot_setting.now_muse_num)
                    member_val.opacity = 0.5
                    member_val.disabled = true
                    member_val.changeNotButton()
                    now_nuse_set = true
                else
                    member_val.setItemKind(10)
                    member_val.opacity = 1
                    member_val.disabled = false

class pauseMemberUseSelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new memberUseSelectDialogHtml()
        @cancel_button = new memberUseCancelButtonHtml()
        @set_button = new memberUseSetButtonHtml()
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
        return text
    setMember:()->
        @_memberSet(@item_kind)
        game.pause_scene.pause_member_set_layer.dispSetMemberList()
        game.pause_scene.removeMemberUseSelectMenu()
    _memberSet:(kind)->
        if game.member_set_now.indexOf(parseInt(kind)) == -1
            if (game.max_set_member_num <= game.member_set_now.length)
                game.member_set_now.shift()
            game.member_set_now.push(kind)
        else
            game.member_set_now = game.arrayValueDel(game.member_set_now, kind)