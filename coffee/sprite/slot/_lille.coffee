class Lille extends Slot
    constructor: (w, h) ->
        super 110, 110
        @image = game.imageload("lille")
        @lilleArray = [] #リールの並び
        @isRotation = false #trueならリールが回転中
        @nowEye = 0 #リールの現在の目
    onenterframe: (e) ->
        if @isRotation is true
            @eyeIncriment()
    ###
    回転中にリールの目を１つ進める
    ###
    eyeIncriment: () ->
        @nowEye += 1
        if @lilleArray[@nowEye] is undefined
            @nowEye = 0
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
        @lilleArray = [1,2,3,4,2,3,5,2,1,3,4,5,2,5,7,1,2,3,4,5,1,7]
        @eyeInit()
        @x = -50

class MiddleLille extends Lille
    constructor: () ->
        super
        @lilleArray = [3,5,2,5,4,2,3,4,7,2,1,5,4,3,5,2,3,7,1,4,5,3]
        @eyeInit()
        @x = 120

class RightLille extends Lille
    constructor: () ->
        super
        @lilleArray = [2,4,1,5,1,4,2,7,2,4,3,1,7,2,3,7,1,5,3,2,4,5]
        @eyeInit()
        @x = 300