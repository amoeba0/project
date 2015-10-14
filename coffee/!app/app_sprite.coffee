class appSprite extends Sprite
    constructor: (w, h) ->
        super w, h
        @w = w
        @h = h
    _makeContext:() ->
        @surface = new Surface(@w, @h)
        @context = @surface.context

    ###
    枠の無い長方形
    @param color 色
    ###
    drawRect: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.fillRect(0, 0, @w, @h, 10)
        @context.fill()
        return @surface
    ###
    枠のある長方形
    @param string strokeColor 枠の色
    @param string fillColor   色
    @param number thick       枠の太さ
    ###
    drawStrokeRect:(strokeColor, fillColor, thick)->
        @_makeContext()
        @context.fillStyle = strokeColor
        @context.fillRect(0, 0, @w, @h)
        @context.fillStyle = fillColor
        @context.fillRect(thick, thick, @w - (thick * 2), @h - (thick * 2))
        return @surface

    ###
    左向きの三角形
    @param color 色
    ###
    drawLeftTriangle: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.beginPath()
        @context.moveTo(0, @h / 2)
        @context.lineTo(@w, 0)
        @context.lineTo(@w, @h)
        @context.closePath()
        @context.fill()
        return @surface

    ###
    上向きの三角形
    @param color 色
    ###
    drawUpTriangle: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.beginPath()
        @context.moveTo(@w / 2, 0)
        @context.lineTo(@w, @h)
        @context.lineTo(0, @h)
        @context.closePath()
        @context.fill()
        return @surface

    ###
    丸
    @param color 色
    ###
    drawCircle: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.arc(@w / 2, @h / 2, @w / 2, 0, Math.PI * 2, true)
        @context.fill()
        return @surface