class Frame extends Slot
    constructor: (w, h) ->
        super w, h

class UnderFrame extends Frame
    constructor: (w,h) ->
        super 246, 82
        @image = game.imageload("under_frame")

class UpperFrame extends Frame
    constructor: (w,h) ->
        super w, h