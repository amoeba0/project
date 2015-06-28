class Lille extends Slot
    constructor: (w, h) ->
        super 110, 110
        @image = game.imageload("lille")
        @lotate_se = game.soundload('select')
        @lilleArray = [] #リールの並び
        @isRotation = false #trueならリールが回転中
        @nowEye = 0 #リールの現在の目
    onenterframe: (e) ->
        if @isRotation is true
            @eyeIncriment()
            @soundLotateSe()
    ###
    回転中にリールの目を１つ進める
    ###
    eyeIncriment: () ->
        @nowEye += 1
        if @lilleArray[@nowEye] is undefined
            @nowEye = 0
        @frameChange()

    soundLotateSe:()->

    frameChange:()->
        @frame = @lilleArray[@nowEye]

    rotationStop: ()->
        @isRotation = false

    ###
    初回リールの位置をランダムに決める
    ###
    eyeInit: () ->
        @nowEye = Math.floor(Math.random() * @lilleArray.length)
        @eyeIncriment()

class LeftLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.slot_setting.lille_array_0[0]
        @eyeInit()
        @x = -55

class MiddleLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.slot_setting.lille_array_0[1]
        @eyeInit()
        @x = 110

class RightLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.slot_setting.lille_array_0[2]
        @eyeInit()
        @x = 274
    soundLotateSe:()->
        if @age % 2 is 0
            game.sePlay(@lotate_se)