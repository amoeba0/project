class text extends appLabel
    constructor: () ->
        super
###
所持金
###
class moneyText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 30
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
        @x = 0
        @y = 10
        @zandaka_text = '残高'
        @yen_text = '円'
        @setValue()
    ###
    所持金の文字列を設定する
    @param number val 所持金
    ###
    setValue: ()->
        @text = @zandaka_text + game.money + @yen_text
        @setXposition()
    ###
    X座標の位置を設定
    ###
    setXposition: () ->
        @x = game.width - @_boundWidth - 10

class betText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 30
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
        @x = 10
        @y = 10
        @kakekin_text = '掛金'
        @yen_text = '円'
        @setValue()
    setValue: () ->
        @text = @kakekin_text + game.bet + @yen_text