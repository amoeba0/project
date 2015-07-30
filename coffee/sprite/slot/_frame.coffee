class Frame extends Slot
    constructor: (w, h) ->
        super w, h

class UnderFrame extends Frame
    constructor: (w,h) ->
        super 369, 123
        @image = @drawRect('white')

class UpperFrame extends Frame
    constructor: (w,h) ->
        super w, h