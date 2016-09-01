class gpStorySentence extends appGroup
    constructor: () ->
        super
        w = game.width - 20
        h = Math.floor(game.width / 3)
        @window = new storyTextWindow(w, h)
        @message = new storyMessage(w - 60, h)
        @addChild(@window)
    txtSet:(txt, fontSize, speed)->
        @message.init(txt, fontSize, speed)
        @addChild(@message)
    txtEnd:()->
        @removeChild(@message)