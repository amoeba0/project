###
演出
###
class performanceEffect extends effect
    constructor: (w, h) ->
        super w, h
###
チャンス
###
class chanceEffect extends performanceEffect
    constructor:()->
        super 237, 50
        @image = game.imageload("chance")
        @y = 290
        @x = game.width
        @existTime = 2
        @sound = game.soundload('clear')
    onenterframe: (e) ->
        if @age - @set_age is @fast_age
            game.sePlay(@sound)
            @vx = @_setVxSlow()
        if @age - @set_age is @slow_age
            @vx = @_setVxFast()
        @x += @vx
        if @x + @w < 0
            game.main_scene.gp_slot.endForceSlotHit()
            game.main_scene.gp_effect.removeChild(@)
    setInit:()->
        @existTime = game.slot_setting.setChanceTime()
        @x = game.width
        @vx = @_setVxFast()
        @set_age = @age
        @fast_age = Math.round(0.3 * game.fps)
        @slow_age = Math.round(@existTime * game.fps) + @fast_age
    _setVxFast:()->
        return Math.round(((game.width + @w) / 2) / (0.3 * game.fps)) * -1
    _setVxSlow:()->
        return Math.round(((game.width - @w) / 4) / (@existTime * game.fps)) * -1

###
フィーバー
###
class feverEffect extends performanceEffect
    constructor:()->
        super 190, 50
        @image = game.imageload("fever")
        @y = 290
        @x = (game.width - @w) / 2
        @frame = 0
class feverOverlay extends feverEffect
    constructor:()->
        super
        @frame = 1
        @opacity_frm = Math.floor(100 / game.fps) / 100
    setInit:()->
        @opacity = 0
    onenterframe: (e) ->
        @opacity += @opacity_frm
        if @opacity < 0
            @opacity = 0
            @opacity_frm *= -1
        if 1 < @opacity
            @opacity = 1
            @opacity_frm *= -1

###
キラキラ
###
class kirakiraEffect extends performanceEffect
    constructor:()->
        super 50, 50
        @image = game.imageload("kira")
        @flashPeriodFrm = game.fps #光ってる間の時間
        @setInit()
    setInit:()->
        @x = Math.floor(Math.random() * game.width)
        @y = Math.floor(Math.random() * game.height)
        @randomPeriodFrm = Math.floor(Math.random() * 3 * game.fps) #次に光るまでの時間
        @halfFrm = @randomPeriodFrm + Math.round(@flashPeriodFrm / 2)
        @totalFrm = @randomPeriodFrm + @flashPeriodFrm
        randomSize = Math.floor(Math.random() * 30) + 20
        @scaleV = Math.floor((randomSize / 50) * 200 / @flashPeriodFrm) / 100 #1フレーム当たりに変わるサイズ
        @opacityV = Math.floor((Math.random() * 50 + 50) * 2 / @flashPeriodFrm) / 100 #1フレームあたりに変わる透明度
        @scaleX = 0
        @scaleY = 0
        @opacity = 0
    onenterframe: (e) ->
        unitAge = @age % @totalFrm
        if unitAge < @randomPeriodFrm
        else if unitAge < @halfFrm
            @scaleX += @scaleV
            @scaleY += @scaleV
            @opacity += @opacityV
        else if unitAge < @totalFrm
            @scaleX -= @scaleV
            @scaleY -= @scaleV
            @opacity -= @opacityV
            if @scaleX < 0
                @scaleX = 0
            if @scaleY < 0
                @scaleY = 0
            if @opacity < 0
                @opacity = 0
        else if unitAge is 0
            @setInit()

