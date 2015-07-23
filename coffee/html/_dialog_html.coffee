class dialogHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
class baseDialogHtml extends dialogHtml
    constructor: () ->
        super 375, 375
        @class = ['base-dialog']
class saveDialogHtml extends baseDialogHtml
    constructor: () ->
        super
        @text = '保存しました。'
        @class.push('base-dialog-save')
        @x = 60
        @y = 150
        @setHtml()