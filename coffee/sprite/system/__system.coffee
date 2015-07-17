class System extends appSprite
    constructor: (w, h) ->
        super w, h
    ###
    枠の無い長方形
    @param color 色
    ###
    drawRect: (color) ->
        surface = new Surface(@w, @h)
        surface.context.fillStyle = color
        surface.context.fillRect(0, 0, @w, @h, 10)
        surface.context.fill()
        return surface
    ###
    枠のある長方形
    @param string strokeColor 枠の色
    @param string fillColor   色
    @param number thick       枠の太さ
    ###
    drawStrokeRect:(strokeColor, fillColor, thick)->
        surface = new Surface(@w, @h)
        surface.context.fillStyle = strokeColor
        surface.context.fillRect(0, 0, @w, @h)
        surface.context.fillStyle = fillColor
        surface.context.fillRect(thick, thick, @w - (thick * 2), @h - (thick * 2))
        return surface