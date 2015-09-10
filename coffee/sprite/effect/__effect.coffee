class effect extends appSprite
    constructor: (w, h) ->
        super w, h
    drawCircle: (color) ->
        @surface = new Surface(@w, @h)
        @context = @surface.context
        @context.fillStyle = color
        @context.arc(@w / 2, @h / 2, @w / 2, 0, Math.PI * 2, true)
        @context.fill()
        return @surface