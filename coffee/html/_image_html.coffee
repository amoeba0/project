class imageHtml extends systemHtml
    constructor: (width, height) ->
        super width, height

###
アイテム画像のベース
@param kind 種別
###
class baseItemHtml extends systemHtml
    constructor: (kind)->
        super 100, 100
        @image_name = 'test_image'
        @setImageHtml()
        @item_kind = kind
        @scaleX = 0.7
        @scaleY = 0.7
        @positionY = 0
        @positionX = 0
        @positoin_kind = @item_kind
    setPosition:()->
        if @positoin_kind <= 4
            @y = @positionY
            @x = 80 * (@positoin_kind - 1) + 70 + @positionX
        else
            @y = @positionY + 80
            @x = 80 * (@positoin_kind - 5) + 30 + @positionX
    dispItemBuySelectDialog:(kind)->
        game.pause_scene.setItemBuySelectMenu(kind)
    dispItemUseSelectDialog:(kind)->
        game.pause_scene.setItemUseSelectMenu(kind)
    dispMemberUseSelectDialog:(kind)->
        game.pause_scene.setMemberUseSelectMenu(kind)

###
アイテム
###
class itemHtml extends baseItemHtml
    constructor:(kind)->
        super kind
        @image_name = 'item_'+kind
        @setImageHtml()

class buyItemHtml extends itemHtml
    constructor:(kind)->
        super kind
        @positionY = 160
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            @dispItemBuySelectDialog(@item_kind)

class useItemHtml extends itemHtml
    constructor:(kind)->
        super kind
        @positionY = 400
        @is_exist = false
    ontouchend:()->
        if @is_exist is true
            @dispItemUseSelectDialog(@item_kind)

class setItemHtml extends baseItemHtml
    constructor:(position)->
        super position
        @kind = 0
        @positionY = 210
        @positionX = 200
        @positoin_kind = position - 1
        @_setImage(0)
    setItemKind:(kind)->
        @kind = kind
        @_setImage(kind)
        if kind != 0
            @changeIsButton()
        else
            @changeNotButton()
    _setImage:(kind)->
        @image_name = 'item_'+kind
        @setImageHtml()
    ontouchend: ()->
        if @kind != 0
            game.pause_scene.setItemUseSelectMenu(@kind)
###
部員
###
class memberHtml extends baseItemHtml
    constructor:(kind)->
        super kind
        @image_name = 'item_'+kind
        @setImageHtml()
        @positoin_kind = @item_kind - 10

class buyMemberHtml extends memberHtml
    constructor:(kind)->
        super kind
        @positionY = 400
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            @dispItemBuySelectDialog(@item_kind)

class useMemberHtml extends memberHtml
    constructor:(kind)->
        super kind
        @positionY = 400
        @is_exist = false
    ontouchend:()->
        if @is_exist is true
            @dispMemberUseSelectDialog(@item_kind)

class setMemberHtml extends baseItemHtml
    constructor:(position)->
        super position
        @kind = 0
        @positionY = 210
        @positionX = 120
        @positoin_kind = position - 1
        @_setImage(10)
    setItemKind:(kind)->
        @kind = kind
        @_setImage(kind)
        if kind != 10
            @changeIsButton()
        else
            @changeNotButton()
    _setImage:(kind)->
        @image_name = 'item_'+kind
        @setImageHtml()
    ontouchend: ()->
        if @kind != 10
            game.pause_scene.setMemberUseSelectMenu(@kind)

class selectItemImage extends imageHtml
    constructor:()->
        super 100, 100
        @x = 200
        @y = 180
        @is_button = false
    setImage:(image)->
        @image_name = image
        @setImageHtml()