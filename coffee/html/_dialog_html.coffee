class dialogHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
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
        super 375, 400
        @text = '　'
        @class.push('base-dialog-menu')
        @x = 45
        @y = 100
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