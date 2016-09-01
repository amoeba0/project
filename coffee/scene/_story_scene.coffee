class stolyScene extends appScene
    constructor: () ->
        super
        @gp_load = new gpLoadStory()
        @loadFile = []
        @cue = {}
        @panorama = ''
    resetScene:()->
        @gp_panorama = new gpStoryPanorama(@panorama)
        @gp_sentence = new gpStorySentence()
        @gp_object = new gpStoryObject()
        @addChild(@gp_panorama)
        @addChild(@gp_sentence)
        @addChild(@gp_object)
    startScene:()->
        @addChild(@gp_load)
        game.multiLoad(@loadFile)
    startSceneExe:()->
        @removeChild(@gp_load)
        @resetScene()
        @cueSet(@cue)
    faceSet:(face, x=0, y=0)->
        @gp_object.addChild(face)
        face.x =  @gp_panorama.panorama.x + x
        face.y = @gp_panorama.panorama.y + y
    #http://wise9.github.io/enchant.js/doc/core/ja/symbols/enchant.Timeline.html
    #http://r.jsgames.jp/games/1687/
    ###
    必要な素材は必ずresetScene()で生成するクラス内で呼び出す
    'back_gakko', 'back_busitu', 'back_stage'
    'face_honoka','face_kotori', 'face_umi', 'face_maki', 'face_rin', 'face_hanayo', 'face_nico', 'face_nozomi', 'face_eli'
    ###
    testStart:()->
        @panorama = 'back_gakko'
        @loadFile = ['images/back_gakko.png', 'images/face_honoka.png']
        @cue = {
            0:=>
                @faceSet(@gp_object.honoka, 170, 90)
            1:=>
                @gp_object.honoka.randomShake()
            5:=>
                game.endStory()
        }
        @startScene()
    opStart:()->
        @panorama = 'back_gakko'
        @loadFile = ['images/back_gakko.png', 'images/face_honoka.png', 'images/face_kotori.png', 'images/face_umi.png']
        @cue = {
            0:=>
                @gp_sentence.txtSet(
                    'ここは某音ノ木坂学院、<br>廃校が決まったあと、突然穂乃果が<br>スクールアイドルを始めると言い出した'
                )
            4:=>
                @faceSet(@gp_object.honoka, 170, 90)
                @faceSet(@gp_object.kotori, 20, 95)
                @faceSet(@gp_object.umi, 320, 85)
            5:=>
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>海未ちゃん、,ことりちゃん、,<br>スクールアイドルを始めるよ！'
                )
            9:=>
                @gp_sentence.txtEnd()
                @gp_object.kotori.rotateShake()
                @gp_sentence.txtSet(
                    'ことり<br>スクールアイドルってあの？<br>学生たちでアイドルをやってる、,<br>ネットでPVなんかも公開してて、,<br>全国に有名なスクールアイドルもいる'
                )
            15:=>
                @gp_sentence.txtEnd()
                @gp_object.honoka.tateShake2()
                @gp_sentence.txtSet(
                    '穂乃果<br>そう、それだよ！,スクールアイドル！,<br>スクールアイドルを始めて有名になれば,<br>廃校を阻止することができるよ！'
                )
            21:->
                @gp_sentence.txtEnd()
                @gp_object.umi.tateShake()
                @gp_sentence.txtSet(
                    '海未<br>穂乃果、,簡単にスクールアイドルを<br>始めるとは言ってもですね、,<br>廃校を阻止するだけ有名になるには、'
                )
            26:->
                @gp_sentence.txtEnd()
                @gp_object.umi.rotateShake()
                @gp_sentence.txtSet(
                    '海未<br>歌や衣装、,ダンスにPV撮影等、,<br>それなりにプロに匹敵するだけのものが<br>必要になるんですよ。'
                )
            31:->
                @gp_sentence.txtEnd()
                @gp_object.umi.tateShake()
                @gp_sentence.txtSet(
                    '海未<br>私達３人だけでは到底<br>それだけの物は用意できません。'
                )
            35:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>それなら大丈夫だよ、,海未ちゃん！,<br>お金の力があればなんとかなるよ！'
                )
            40:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>プロの作詞者、,プロの作曲者、,<br>衣装や舞台装置、,<br>他にもいっぱいプロのスタッフたちを,<br>お金で雇えば、'
                )
            46:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.tateShake2()
                @gp_sentence.txtSet(
                    '穂乃果<br>素敵なPVが撮影できるよ！'
                )
            49:->
                @gp_sentence.txtEnd()
                @gp_object.umi.tateShake()
                @gp_sentence.txtSet(
                    '海未<br>何を他力本願なことを<br>言っているのですか、,<br>それに、,仮にそうするとしても、,<br>そんなお金、,どこにあるというのですか、'
                )
            55:->
                @gp_sentence.txtEnd()
                @gp_object.umi.rotateShake()
                @gp_sentence.txtSet(
                    '海未<br>簡単に見積もっても,<br>『１００万円』程は必要ですよ！'
                )
            59:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>なーんだ、,『１００万円』か、,<br>そんなの簡単じゃん！,<br>スロットマシンで稼げばいいじゃない！'
                )
            64:->
                @gp_sentence.txtEnd()
                @gp_object.umi.scale()
                @gp_sentence.txtSet(
                    '海未<br>ちょっと穂乃果、,<br>それ本気で言っているのですか！？'
                )
            68:->
                @gp_sentence.txtEnd()
                @gp_object.kotori.scale()
                @gp_sentence.txtSet(
                    'ことり<br>そうだよホノカチャン！,<br>さすがにギャンブルは無茶だよ！'
                )
            72:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.scaleIn()
                @gp_sentence.txtSet(
                    '穂乃果<br>ダイジョーブ、,ダイジョーブ！<br>ここに穂乃果のなけなしのお小遣い,<br>『１００円』があるから、'
                )
            77:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.tateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>これを元手に頑張ってね！,<br>それじゃあ任せたよ！,ことりちゃん！'
                )
            79:->
                @gp_object.honoka.scaleOut()
            81:->
                @gp_sentence.txtEnd()
                @gp_object.kotori.randomShake()
                @gp_sentence.txtSet(
                    'ことり<br>『１００円』！？,<br>ちょっとホノカチャン、,無理だよぉ！,<br>それに何で私！？'
                )
            85:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>ことりちゃん、,大好き！,<br>頑張ってね！'
                )
            89:->
                @gp_sentence.txtEnd()
                @gp_object.kotori.tateShake2()
                @gp_sentence.txtSet(
                    'ことり<br>うん、,ホノカチャン！,<br>わたし頑張る！'
                )
            93:->
                @gp_sentence.txtEnd()
                @gp_object.umi.scale()
                @gp_sentence.txtSet(
                    '海未<br>穂乃果！,いいかげんにしなさい！,<br>ことりも、,、,無茶です！'
                )
            97:->
                @gp_sentence.txtEnd()
                @gp_object.honoka.rotateShake()
                @gp_sentence.txtSet(
                    '穂乃果<br>海未ちゃんも,だーいすき！！'
                )
            101:->
                @gp_sentence.txtEnd()
                @gp_object.umi.tateShake2()
                @gp_sentence.txtSet(
                    '海未<br>まったく、,仕方ないですね、,<br>ことり、,頼みましたよ。'
                )
            105:->
                @gp_sentence.txtEnd()
                @gp_object.kotori.tateShake2()
                @gp_sentence.txtSet(
                    'ことり<br>うん！,それじゃあ私に任せてね！,<br>『１００万円』稼いでくるから！'
                )
            110:->
                @gp_sentence.txtEnd()
                game.endStory()
        }
        @startScene()
    edStart:()->

    ###
    タイムラインのキューの単位を秒数に変換してセット
    ###
    cueSet:(cue)->
        ret = {}
        for sec, func of cue
            ret[Math.floor(sec * game.fps)] = func
        @tl.cue(ret)
