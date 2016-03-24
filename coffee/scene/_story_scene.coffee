class stolyScene extends appScene
    constructor: () ->
        super
    resetScene:()->
        @gp_panorama = new gpStoryPanorama()
        @gp_sentence = new gpStorySentence()
        @gp_object = new gpStoryObject()
        @addChild(@gp_panorama)
        @addChild(@gp_sentence)
        @addChild(@gp_object)
    #http://wise9.github.io/enchant.js/doc/core/ja/symbols/enchant.Timeline.html
    #http://r.jsgames.jp/games/1687/
    testStart:()->
        @resetScene()
        @cueSet({
            0:=>
                @gp_panorama.haiko.x = @gp_panorama.haiko.x_static
            1:=>
                @gp_object.honoka.moveToStatic()
            3:=>
                @gp_panorama.haiko.tl.fadeOut(24)
                @gp_sentence.txtSet('test', 48, 0.5)
                @gp_object.honoka.tateShake()
                @gp_object.kotori.moveToStatic()
            5:=>
                @gp_sentence.txtSet(
                    'hoge<br>hoge
                    hogehoge'
                )
                @gp_object.kotori.yokoShake()
            6:=>
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotate()
                @gp_object.kotori.scale()
            9:=>
                @gp_object.honoka.moveToInit()
                @gp_object.kotori.moveToInit()
            11:=>
                game.endStory()
        })
    opStart:()->
        @resetScene()
    edStart:()->
        @resetScene()
    ###
    タイムラインのキューの単位を秒数に変換してセット
    ###
    cueSet:(cue)->
        ret = {}
        for sec, func of cue
            ret[Math.floor(sec * game.fps)] = func
        @tl.cue(ret)
