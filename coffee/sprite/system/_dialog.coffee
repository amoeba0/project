class Dialog extends System
    constructor: (w, h) ->
        super w, h
    ###
    ダイアログの描画
    ###
    drawDialog: () ->
        return @drawStrokeRect('#aaaaaa', '#ffffff', 5)
class pauseBack extends Dialog
    constructor: (w, h) ->
        super game.width, game.height
        @image = @drawRect('#000000')
        @opacity = 0.8

class whiteBack extends Dialog
    constructor: (w, h) ->
        super game.width, game.height
        @image = @drawRect('#FFFFFF')
        @opacity = 1

class blackBack extends Dialog
    constructor: (w, h) ->
        super game.width, game.height
        @image = @drawRect('#000000')
        @opacity = 1

class storyTextWindow extends Dialog
    constructor:(w, h)->
        super w, h
        @image = @drawRect('#ff69b4')
        @opacity = 0.8
        @x = 10
        @y = game.width + Math.floor((game.height - game.width) / 2) - h - 10