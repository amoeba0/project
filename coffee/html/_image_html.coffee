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
        @positoin_kind = @item_kind
    setPosition:()->
        if @positoin_kind <= 4
            @y = @positionY
            @x = 80 * (@positoin_kind - 1) + 70
        else
            @y = @positionY + 80
            @x = 80 * (@positoin_kind - 5) + 30
    dispItemBuySelectDialog:(kind)->
        game.pause_scene.setItemBuySelectMenu(kind)

###
アイテム
###
class itemHtml extends baseItemHtml
    constructor:(kind)->
        super kind

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

###
部員
###
class memberHtml extends baseItemHtml
    constructor:(kind)->
        super kind
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

class selectItemImage extends imageHtml
    constructor:()->
        super 100, 100
        @x = 200
        @y = 180
        @is_button = false
    setImage:(image)->
        @image_name = image
        @setImageHtml()