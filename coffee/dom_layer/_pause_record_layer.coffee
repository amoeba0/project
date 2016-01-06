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
        @setTrophyList()
    setRecordList:()->
        for record_key, record_val of @recordList
            @addChild(record_val)
            record_val.setPosition()
    setTrophyList:()->
        for trophy_key, trophy_val of @trophyList
            @addChild(trophy_val)
            trophy_val.setPosition()

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
        @item_options = game.slot_setting.item_list[kind]
        @item_name.setText(@item_options.name)
        @item_image.setImage(@item_options.image)
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        text += '<br>値段：'+game.toJPUnit(@item_options.price)+'円'
        text += '<br>出現条件：'+@item_options.conditoin
        return text