###
顔
###
class Face extends System
    constructor: (w, h) ->
        super w, h
        @x = 0
        @y = 210
        @emoteX = -30 #顔アイコンから感情アイコンまでの相対位置
        @emoteY = -50 #顔アイコンから感情アイコンまでの相対位置
        @emoteSize = 1 #感情アイコンの大きさ
    ###
    縦揺れ
    ###
    tateShake:()->
        @tl.moveBy(0, -10 * @emoteSize, 4, enchant.Easing.QUAD_EASEOUT).moveBy(0, 10 * @emoteSize, 2, enchant.Easing.QUAD_EASEIN)
        @tl.moveBy(0, 20 * @emoteSize, 6, enchant.Easing.QUAD_EASEOUT).moveBy(0, -20 * @emoteSize, 8, enchant.Easing.QUAD_EASEIN)
    tateShake2:()->
        @_tateShake()
    _tateShake:()->
        for i in [1..2]
            @tl.moveBy(0, -10 * @emoteSize, 2, enchant.Easing.QUAD_EASEOUT).moveBy(0, 10 * @emoteSize, 1, enchant.Easing.QUAD_EASEIN)
            @tl.moveBy(0, 10 * @emoteSize, 1, enchant.Easing.QUAD_EASEOUT).moveBy(0, -10 * @emoteSize, 2, enchant.Easing.QUAD_EASEIN)
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
        for i in [1..48]
            rdx = Math.floor(20 * max * Math.random()) / 10 - max
            rdy = Math.floor(20 * max * Math.random()) / 10 - max
            @tl.moveTo(initx + rdx, inity + rdy, 1, enchant.Easing.QUART_EASEINOUT)
        @tl.moveTo(initx, inity, 2, enchant.Easing.QUART_EASEINOUT)
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

    setEmote:(type='', size=1)->
        emote = game.story_scene.gp_object_up.emote
        emote.changeImage(type)
        _emoteX = @emoteX
        _emoteY = @emoteY
        if @emoteSize != 1
            emote.scaleX = @emoteSize
            emote.scaleY = @emoteSize
            _emoteX = Math.floor(_emoteX * @emoteSize)
            _emoteY = Math.floor(_emoteY * @emoteSize)
        emote.set(@x + _emoteX, @y + _emoteY)

    scaleChange:(scale=1)->
        @scaleX = scale
        @scaleY = scale
        @emoteSize = scale


class kotoriFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_kotori")
        @emoteX = -30
        @emoteY = -50
class honokaFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_honoka")
        @emoteX = -30
        @emoteY = -50
class umiFace extends Face
    constructor: () ->
        super 140, 140
        @image = game.imageload("face_umi")
        @emoteX = -30
        @emoteY = -50
class makiFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_maki")
        @emoteX = -30
        @emoteY = -50
class rinFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_rin")
        @emoteX = -30
        @emoteY = -50
class hanayoFace extends Face
    constructor: () ->
        super 135, 135
        @image = game.imageload("face_hanayo")
        @emoteX = -30
        @emoteY = -50
class nicoFace extends Face
    constructor: () ->
        super 160, 135
        @image = game.imageload("face_nico")
        @emoteX = -10
        @emoteY = -50
class nozomiFace extends Face
    constructor: () ->
        super 165, 165
        @image = game.imageload("face_nozomi")
        @emoteX = -10
        @emoteY = -50
class eliFace extends Face
    constructor: () ->
        super 140, 140
        @image = game.imageload("face_eli")
        @emoteX = -30
        @emoteY = -45

###
感情アイコン
###
class Emote extends System
    constructor:()->
        super 70, 70
        @image = game.imageload("emote")
        @opacity = 0
        @type = {'bikkuri':0, 'hatena':1,'onpu':2, 'heart':3, 'ase':4, 'gabin':5, 'ten':6}
        @prev_frame = 0
        @frame = 0
        @sound = null
    set:(x, y)->
        @opacity = 1
        @x = x
        @y = y
    unset:()->
        @opacity = 0
    changeImage:(name)->
        type = @prev_frame
        if name != ''
            type = @type[name]
        @frame = type
        @prev_frame = @frame
        switch name
            when 'bikkuri' then @sound = game.soundload('emote1')
            when 'hatena'  then @sound = game.soundload('emote2')
            when 'onpu'    then @sound = game.soundload('emote3')
            when 'heart'   then @sound = game.soundload('emote3')
            when 'ase'     then @sound = game.soundload('emote4')
            when 'gabin'   then @sound = game.soundload('emote4')
            when 'ten'     then @sound = game.soundload('emote2')
        game.sePlay(@sound)