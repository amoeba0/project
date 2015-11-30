class dialogHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
class modal extends dialogHtml
    constructor:()->
        super game.width, game.height
        @class = ['modal']
        @text = '　'
        @setHtml()
class baseDialogHtml extends dialogHtml
    constructor: (width, height) ->
        super width, height
        @class = ['base-dialog']
class saveDialogHtml extends baseDialogHtml
    constructor: () ->
        super 375, 375
        @text = '保存しました。'
        @class.push('base-dialog-save')
        @x = 60
        @y = 150
        @setHtml()
class menuDialogHtml extends baseDialogHtml
    constructor:()->
        super 420, 460
        @text = '　'
        @class.push('base-dialog-menu')
        @x = 25
        @y = 80
        @setHtml()
class itemBuyDialogHtml extends menuDialogHtml
    constructor:()->
        super

class itemUseDialogHtml extends menuDialogHtml
    constructor:()->
        super

class memberSetDialogHtml extends menuDialogHtml
    constructor:()->
        super

class recordDialogHtml extends menuDialogHtml
    constructor:()->
        super

class selectDialogHtml extends baseDialogHtml
    constructor:()->
        super 300, 400
        @text = '　'
        @class.push('base-dialog-select')
        @x = 35
        @y = 150
        @setHtml()

class itemBuySelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class itemUseSelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class memberUseSelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class discriptionTextDialogHtml extends dialogHtml
    constructor:(w, h)->
        super w, h
        @class.push('base-discription')

class titleDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 400, 20
        @class.push('title-discription')

class itemItemBuyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 220
        @y = 130
        @text = '魔法'
        @setHtml()

class memberItemBuyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 220
        @y = 370
        @text = '部員'
        @setHtml()

class useSetDiscription extends titleDiscription
    constructor:()->
        super
        @x = 180
        @y = 170
        @text = 'セット中'
        @setHtml()

class useHaveDiscription extends titleDiscription
    constructor:()->
        super
        @x = 170
        @y = 370
        @text = '所持リスト'
        @setHtml()

class itemNameDiscription extends titleDiscription
    constructor:()->
        super
        @x = 50
        @y = 290
    setText:(text)->
        @text = text
        @setHtml()

class itemDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 390, 150
        @x = 50
        @y = 340
    setText:(text)->
        @text = text
        @setHtml()

class longTitleDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 250, 20
        @class.push('head-title-discription')

class itemUseDiscription extends longTitleDiscription
    constructor:()->
        super
        @x = 120
        @y = 110
        @text = '魔法をセットする'
        @setHtml()

class memberSetDiscription extends longTitleDiscription
    constructor:()->
        super
        @x = 120
        @y = 110
        @text = '部員を編成する'
        @setHtml()