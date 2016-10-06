class formHtml extends systemHtml
    constructor: (width, height) ->
        super width, height

class checkboxHtml extends formHtml
    constructor:()->
        super
        @checked = false
    setCheckboxHtml:(checked=false)->
        checked_txt = ''
        checked_color = 'check-grayout'
        if checked is true
            checked_txt = 'checked'
            checked_color = ''
        @_element.innerHTML = '<label class="base-checkbox '+checked_color+'"><input type="checkbox" class="checkbox-size" '+checked_txt+'>'+@text+'</label>'
    check:()->
        @setCheckboxHtml(true)
        @checked = true
    uncheck:()->
        @setCheckboxHtml(false)
        @checked = false

class betCheckboxHtml extends checkboxHtml
    constructor:()->
        super
        @text = '掛け金を自動で上げる'
        @x = 90
        @y = 235
        @setCheck()
    setCheck:()->
        if game.auto_bet is 1
            @check()
        else
            @uncheck()
    ontouchend: (e) ->
        if game.auto_bet is 1
            game.auto_bet = 0
        else
            game.auto_bet = 1
        @setCheck()