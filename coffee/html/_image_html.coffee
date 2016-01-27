class imageHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
        @is_button = true

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
        @is_button = true
        @scaleX = 0.7
        @scaleY = 0.7
        @positionY = 0
        @positionX = 0
        @positoin_kind = @item_kind
        @dicisionSe = game.soundload('dicision')
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
        @positionY = 110
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemBuySelectDialog(@item_kind)

class useItemHtml extends itemHtml
    constructor:(kind)->
        super kind
        @positionY = 330
        @is_exist = false
    ontouchend:()->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemUseSelectDialog(@item_kind)

class setItemHtml extends baseItemHtml
    constructor:(position)->
        super position
        @kind = 0
        @positionY = 180
        @positionX = 120
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
            game.sePlay(@dicisionSe)
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
        @positionY = 340
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemBuySelectDialog(@item_kind)

class useMemberHtml extends memberHtml
    constructor:(kind)->
        super kind
        @positionY = 350
        @is_exist = false
    ontouchend:()->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispMemberUseSelectDialog(@item_kind)

class setMemberHtml extends baseItemHtml
    constructor:(position)->
        super position
        @kind = 0
        @disabled = false
        @positionY = 180
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
        if @kind != 10 and @disabled is false
            game.sePlay(@dicisionSe)
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

class baseRecordItemHtml extends systemHtml
    constructor: (position, kind)->
        super 100, 100
        @position = position
        @kind = kind
        @is_button = true
        @scaleX = 0.65
        @scaleY = 0.65
        @positionY = 0
        @positionX = 0
        @dicisionSe = game.soundload('dicision')
    setPosition:()->
        @y = @positionY + (Math.floor(@position / 5) + 1) * 75
        @x = 75 * (@position % 5) + @positionX

class recordItemHtml extends baseRecordItemHtml
    constructor: (position, kind)->
        super position, kind
        @image_name = 'bgm_' + kind
        @setImageHtml()
        @positionY = 40
        @positionX = 35
    ontouchend: ()->
        game.sePlay(@dicisionSe)
        game.pause_scene.setRecordSelectMenu(@kind)
class trophyItemHtml extends baseRecordItemHtml
    constructor: (position, kind)->
        super position, kind
        @image_name = 'item_' + kind
        @setImageHtml()
        @positionY = 480
        @positionX = 75
        @is_exist = true
    ontouchend: ()->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            game.pause_scene.setTrophySelectMenu(@kind)
class buyTrophyItemHtml extends baseRecordItemHtml
    constructor: (position, kind)->
        super position, kind
        @image_name = 'item_' + kind
        @setImageHtml()
        @positionY = 480
        @positionX = 75
        @item_kind = kind
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemBuySelectDialog(@item_kind)
    dispItemBuySelectDialog:(kind)->
        game.pause_scene.setItemBuySelectMenu(kind)