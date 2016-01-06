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
    constructor:(width=420, height=460)->
        super width, height
        @text = '　'
        @classPush()
        @x = 25
        @y = 80
        @setHtml()
    classPush:()->
        @class.push('base-dialog-menu')
class itemBuyDialogHtml extends menuDialogHtml
    constructor:()->
        super 420, 500
        @y = 50
    classPush:()->
        @class.push('base-dialog-high')

class itemUseDialogHtml extends menuDialogHtml
    constructor:()->
        super

class memberSetDialogHtml extends menuDialogHtml
    constructor:()->
        super

class recordDialogHtml extends menuDialogHtml
    constructor:()->
        super 420, 500
        @y = 50
    classPush:()->
        @class.push('base-dialog-high')

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

class recordSelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class discriptionTextDialogHtml extends dialogHtml
    constructor:(w, h)->
        super w, h
        @class.push('base-discription')

class titleDiscription extends discriptionTextDialogHtml
    constructor:(width=400, height=20)->
        super width, height
        @class.push('title-discription')

class itemItemBuyDiscription extends titleDiscription
    constructor:()->
        super 100, 20
        @x = 220
        @y = 80
        @text = '魔法'
        @setHtml()

class memberItemBuyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 220
        @y = 310
        @text = '部員'
        @setHtml()

class trophyItemBuyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 200
        @y = 530
        @text = 'トロフィー'
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

class recordDiscription extends titleDiscription
    constructor:()->
        super 100, 200
        @x = 200
        @y = 80
        @text = '楽曲'
        @setHtml()

class trophyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 170
        @y = 520
        @text = 'トロフィー'
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