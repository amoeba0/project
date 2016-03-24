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
        @font_size = 24
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 0
        @y = 7
        @zandaka_text = '残高'
        @yen_text = '円'
        @setValue()
    ###
    所持金の文字列を設定する
    @param number val 所持金
    ###
    setValue: ()->
        @text = @zandaka_text + game.toJPUnit(game.money) + @yen_text
        @setXposition()
    ###
    X座標の位置を設定
    ###
    setXposition: () ->
        @x = game.width - @_boundWidth - 7
    setPositionPause:()->
        @x = 100
        @y = 190

class betText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 22
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 37
        @y = 7
        @kakekin_text = '掛金'
        @yen_text = '円'
        @text = @kakekin_text + game.toJPUnit(game.bet) + @yen_text
    setValue: () ->
        @text = @kakekin_text + game.toJPUnit(game.bet) + @yen_text
        game.main_scene.gp_system.low_bet_button.setXposition()
    setPositionPause:()->
        @x = 140
        @y = 245

class comboText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 37
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 195
        @y = 75
    setValue: () ->
        @text = game.combo
        @setXposition()
    setXposition: () ->
        unit = game.main_scene.gp_system.combo_unit_text
        @x = game.width / 2 - (@_boundWidth + unit._boundWidth + 5) / 2
        if 3 <= game.max_set_item_num
            @x += 50
        unit.x = @x + @_boundWidth + 5
class comboUnitText extends text
    constructor: () ->
        super
        @text = 'combo'
        @color = 'black'
        @font = "22px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 217
        @y = 90

class storyBackTxt extends text
    constructor: (width, height) ->
        super
        @text = '戻る'
        @color = 'black'
        @font = (height - 8) + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = game.width - width - 10 + 9
        @y = game.height - height - 50 + 2
    ontouchend: () ->
        game.endStory()

class storyMessage extends text
    constructor: (width, height) ->
        super width, height
        @text = ''
        @fontInit = "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @font = ''
        @color = "white"
        @message = ''
        @speed = 4
        @x = 30
        @y = game.width + Math.floor((game.height - game.width) / 2) - height - 5
    onenterframe:()->
        if @all_length > @now_length
            @now_length += @speed
            @text = @message.substring(0, @now_length)
    init:(message, fontSize=22, speed=4)->
        @font = fontSize + @fontInit
        @speed = speed
        @all_length = message.length
        @now_length = 0
        @message = message
        @text = ""