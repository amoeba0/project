class Face extends System
    constructor: (w, h) ->
        super w, h
        @x = 0
        @y = 210
    ###
    縦揺れ
    ###
    tateShake:(time=2, scale=10, speed=2)->
        for i in [1..time]
            @_tateShakeONe(scale, speed)
    ###
    横揺れ
    ###
    yokoShake:(time=2, scale=10, speed=2)->
        for i in [1..time]
            @_yokoShakeONe(scale, speed)
    _tateShakeONe:(scale, speed)->
        @tl.moveBy(0, scale * (-1), 2).moveBy(0, scale * 2, 2).moveBy(0, scale * (-1), 2)
    _yokoShakeONe:(scale, speed)->
        @tl.moveBy(scale * (-1), 0, 2).moveBy(scale * 2, 0, 2).moveBy(scale * (-1), 0, 2)
    ###
    回転
    ###
    rotate:(time=1,speed=24)->
        @tl.rotateTo(360*time, 24)
    ###
    大きくなる
    ###
    scale:(scale=2, speed=24)->
        @tl.scaleTo(scale, scale, speed, enchant.Easing.QUAD_EASEOUT).scaleTo(1, 1, speed, enchant.Easing.CUBIC_EASEIN)
    ###
    定位置に移動
    ###
    moveToStatic:()->
        @tl.moveX(@x_static, 24, enchant.Easing.QUAD_EASEIN)
    ###
    初期位置に移動
    ###
    moveToInit:()->
        @tl.moveX(@x_init, 24, enchant.Easing.QUAD_EASEIN)
class kotoriFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_kotori")
        @x_init = 0 - @width
        @x_static = 50
class honokaFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_honoka")
        @x_init = game.width
        @x_static = 290
class haikoFace extends Face
    constructor:()->
        super 140, 200
        @y = 180
        @image = game.imageload("face_haiko")
        @x_init = game.width
        @x_static = 170