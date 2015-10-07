#TODO 持っていないものは半透明、セット中は透明
class pauseMemberSetLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new memberSetDialogHtml()
        @close_button = new memberSetDialogCloseButton()
        @menu_title = new memberSetDiscription()
        @set_title = new useSetDiscription()
        @have_title = new useHaveDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@menu_title)
        @addChild(@set_title)
        @addChild(@have_title)
        @member_list = {}
        for i in [11..19]
            @member_list[i] = new useMemberHtml(i)
        @setItemList()
    setItemList:()->
        for member_key, member_val of @member_list
            @addChild(member_val)
            member_val.setPosition()
    resetItemList:()->
        for member_key, member_val of @member_list
            if game.item_have_now.indexOf(parseInt(member_key)) != -1
                member_val.opacity = 1
                member_val.removeClass('grayscale', true)
                member_val.changeIsButton()
            else
                member_val.opacity = 0.5
                member_val.addClass('grayscale', true)
                member_val.changeNotButton()