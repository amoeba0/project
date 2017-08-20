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
        @font_size = 22
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
        @y = 120

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
        @text = @kakekin_text + game.toJPUnit(game.bet, 1) + @yen_text
    setValue: () ->
        @text = @kakekin_text + game.toJPUnit(game.bet, 1) + @yen_text
        game.main_scene.gp_system.low_bet_button.setXposition()
    setPositionPause:()->
        @x = 140
        @y = 175

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

class tensionText extends text
    constructor:()->
        super
        @text = 'テンション'
        @color = 'black'
        @font_size = 22
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ Ｐゴシック'"
        @x = -40
        @y = 43
        @scaleX = 0.7

class storyBackTxt extends text
    constructor: (width, height) ->
        super
        @text = '終了'
        @color = 'black'
        @font = (height - 8) + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = game.width - width - 10 + 9
        @y = game.height - height - 50 + 2
    ontouchend: () ->
        game.endStory()

class storyPauseTxt extends text
    constructor: (width, height) ->
        super
        @text = '一時停止'
        @color = 'black'
        @font = (height - 8) + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 12
        @y = game.height - height - 50 + 2
    ontouchend: () ->
        game.storyPause()

class storyPauseMsgTxt extends text
    constructor:()->
        super
        @text = 'PAUSE'
        @color = 'white'
        @font = "86px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = Math.floor(game.width / 5) + 20
        @y = Math.floor(game.height / 2) - 86

class storyPauseEndTxt extends text
    constructor:()->
        super
        @text = '再開'
        @color = 'white'
        @font = "54px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = Math.floor(game.width / 2) - 54
        @y = Math.floor(game.height / 2) + 86
    ontouchend:()->
        game.storyPauseEnd()


class storyMessage extends text
    constructor: (width, height) ->
        super
        @width = width
        @height = height
        @text = ''
        @fontInit = "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @font = ''
        @color = "white"
        @speed = 4
        @waitTime = 12
        @x = 30
        @y = game.width + Math.floor((game.height - game.width) / 2) - height
        @splited = []
        @splitedLength = []
        @nowSplited = 0
        @wait = 0
        @splitedNum = 0
    onenterframe:()->
        if @nowSplited <= @splitedNum
            if @wait is 0
                if @splitedLength[@nowSplited] > @now_length
                    @now_length += @speed
                    init_text = ''
                    if 1 <= @nowSplited
                        for i in [0..@nowSplited-1]
                            init_text += @splited[i]
                    tmp_txt = init_text + @splited[@nowSplited].substring(0, @now_length)
                    end = tmp_txt.slice(-1)
                    if end == '<'
                        @now_length += 3
                        tmp_txt = init_text + @splited[@nowSplited].substring(0, @now_length)
                    @text = tmp_txt
                else
                    @now_length = 0
                    @nowSplited += 1
                    @wait = @waitTime
            else
                @wait -= 1
    init:(message, fontSize=22, speed=1)->
        @font = fontSize + @fontInit
        @speed = speed
        @splited = message.split(',')
        @splitedNum = @splited.length
        @splitedLength = []
        for i, val of @splited
            @splitedLength[i] = val.length
        @now_length = 0
        @nowSplited = 0
        @wait = 0
        @text = ""

class kaisetuOkButton extends text
    constructor:()->
        super
        @text = 'OK'
        @color = 'white'
        @font_size = 86
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 200
        @y = 550
    ontouchend:()->
        game.popKaisetuScene()

class kaisetuXButton extends text
    constructor:()->
        super
        @text = '×'
        @color = 'white'
        @font_size = 52
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 430
        @y = 0
    ontouchend:()->
        game.popKaisetuScene()