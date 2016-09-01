class Face extends System
    constructor: (w, h) ->
        super w, h
        @x = 0
        @y = 210
    ###
    縦揺れ
    ###
    tateShake:()->
        @tl.moveBy(0, -10, 4, enchant.Easing.QUAD_EASEOUT).moveBy(0, 10, 2, enchant.Easing.QUAD_EASEIN)
        @tl.moveBy(0, 20, 6, enchant.Easing.QUAD_EASEOUT).moveBy(0, -20, 8, enchant.Easing.QUAD_EASEIN)
    tateShake2:()->
        @_tateShake()
    _tateShake:()->
        for i in [1..2]
            @tl.moveBy(0, -10, 2, enchant.Easing.QUAD_EASEOUT).moveBy(0, 10, 1, enchant.Easing.QUAD_EASEIN)
            @tl.moveBy(0, 10, 1, enchant.Easing.QUAD_EASEOUT).moveBy(0, -10, 2, enchant.Easing.QUAD_EASEIN)
    ###
    回転揺れ
    ###
    rotateShake:()->
        @tl.rotateBy(-20, 4, enchant.Easing.QUAD_EASEOUT).rotateBy(20, 4, enchant.Easing.QUAD_EASEIN)
        @tl.rotateBy(20, 4, enchant.Easing.QUAD_EASEOUT).rotateBy(-20, 4, enchant.Easing.QUAD_EASEIN)
        @tl.rotateBy(-10, 2, enchant.Easing.QUAD_EASEOUT).rotateBy(10, 2, enchant.Easing.QUAD_EASEIN)
        @tl.rotateBy(10, 2, enchant.Easing.QUAD_EASEOUT).rotateBy(-10, 2, enchant.Easing.QUAD_EASEIN)
    ###
    震える
    ###
    randomShake:()->
        max = 3
        initx = @x
        inity = @y
        rdx = Math.floor(max * 2 * Math.random()) - max
        rdy = Math.floor(max * 2 * Math.random()) - max
        @tl.moveBy(rdx, rdy, 2, enchant.Easing.QUAD_EASEOUT)
        for i in [1..24]
            rdx = -rdx + Math.floor(max * 2 * Math.random()) - max
            rdy = -rdy + Math.floor(max * 2 * Math.random()) - max
            @tl.moveBy(rdx, rdy, 2, enchant.Easing.QUART_EASEINOUT)
        @tl.moveTo(initx, inity, 2, enchant.Easing.QUAD_EASEIN)
    ###
    大きくなって戻る
    ###
    scale:()->
        @tl.scaleTo(2, 2, 24, enchant.Easing.QUAD_EASEOUT).scaleTo(1, 1, 24, enchant.Easing.CUBIC_EASEIN)
    ###
    大きくなる
    ###
    scaleIn:()->
        @tl.scaleTo(1.5, 1.5, 24, enchant.Easing.QUAD_EASEOUT)
    ###
    元の大きさに戻る
    ###
    scaleOut:()->
        @tl.scaleTo(1, 1, 24, enchant.Easing.CUBIC_EASEIN)

class kotoriFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_kotori")
class honokaFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_honoka")
class umiFace extends Face
    constructor: () ->
        super 140, 140
        @image = game.imageload("face_umi")