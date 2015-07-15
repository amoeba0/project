class System extends appSprite
    constructor: (w, h) ->
        super w, h
    drawRect: (color) ->
        surface = new Surface(@w, @h)
        surface.context.fillStyle = color
        surface.context.fillRect(0, 0, @w, @h, 10)
        surface.context.fill()
        return surface