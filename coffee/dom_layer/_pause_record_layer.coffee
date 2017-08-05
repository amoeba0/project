class pauseRecordLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new recordDialogHtml()
        @close_button = new recordDialogCloseButton()
        @record_title = new recordDiscription()
        @trophy_title = new trophyDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@record_title)
        @addChild(@trophy_title)
        @recordList = {}
        @trophyList = {}
        @bgmList = game.slot_setting.bgm_list
        @bgmList = game.slot_setting.bgm_list
        for kind, position in @bgmList
            @recordList[position] = new recordItemHtml(position, kind)
        for i in [21..24]
            @trophyList[i] = new trophyItemHtml(i - 21, i)
        @setRecordList()
        @resetRecordList()
        @setTrophyList()
        @resetTrophyList()
        @song_help_btn = new helpButtonHtml(4, 50, 80)
        @addChild(@song_help_btn)
        @torophy_help_btn = new helpButtonHtml(5, 50, 520)
        @addChild(@torophy_help_btn)
    setRecordList:()->
        for record_key, record_val of @recordList
            @addChild(record_val)
            record_val.setPosition()
    resetRecordList:()->
        for record_key, record_val of @recordList
            if game.prev_fever_muse.indexOf(parseInt(record_val.kind)) != -1
                record_val.opacity = 1
                record_val.removeDomClass('grayscale', true)
            else
                record_val.opacity = 0.5
                record_val.addDomClass('grayscale', true)
    setTrophyList:()->
        for trophy_key, trophy_val of @trophyList
            @addChild(trophy_val)
            trophy_val.setPosition()
    resetTrophyList:()->
        for trophy_key, trophy_val of @trophyList
            if game.item_have_now.indexOf(parseInt(trophy_val.kind)) != -1
                trophy_val.opacity = 1
                trophy_val.removeDomClass('grayscale', true)
                trophy_val.changeIsButton()
                trophy_val.is_exist = true
            else
                trophy_val.opacity = 0.5
                trophy_val.addDomClass('grayscale', true)
                trophy_val.changeNotButton()
                trophy_val.is_exist = false

class pauseBaseRecordSelectLayer extends appDomLayer
    constructor: ()->
        super
        @dialog = new recordSelectDialogHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()

class pauseRecordSelectLayer extends pauseBaseRecordSelectLayer
    constructor: ()->
        super
        @ok_button = new recordOkButtonHtml()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@ok_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @item_options = game.slot_setting.muse_material_list[kind].bgm[0]
        @item_name.setText(@item_options.title)
        @item_image.setImage(@item_options.image)
        if game.prev_fever_muse.indexOf(parseInt(kind)) != -1
            @item_image.opacity = 1
            @item_image.removeDomClass('grayscale', true)
            @item_name.setText(@item_options.title)
        else
            @item_image.opacity = 0.5
            @item_image.addDomClass('grayscale', true)
            @item_name.setText('？？？')
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = 'ユニット：'+@item_options.unit
        return text

class pauseTrophySelectLayer extends pauseBaseRecordSelectLayer
    constructor: ()->
        super
        @ok_button = new trophyOkButtonHtml()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@ok_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @kind = kind
        @item_options = game.slot_setting.item_list[kind]
        @item_image.setImage(@item_options.image)
        @item_name.setText(@item_options.name)
        discription = @_setDiscription()
        @item_discription.setText(discription)
        switch @kind
            when 21 then @story_button = new secondButtonHtml()
            when 22 then @story_button = new thirdButtonHtml()
            when 23 then @story_button = new fourthButtonHtml()
            when 24 then @story_button = new endingButtonHtml()
        @addChild(@story_button)
        @dialog.class.push('base-dialog-select-high')
        @ok_button.y += 30
        @story_button.y += 30
        @dialog.setHtml()
        @ok_button.x = 250
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        text += '<br>値段：'+game.toJPUnit(@item_options.price)+'円'
        return text