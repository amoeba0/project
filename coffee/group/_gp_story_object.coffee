class gpStoryObject extends appGroup
    constructor: () ->
        super
        @back_btn = new storyBackBtn(80, 40)
        @back_txt = new storyBackTxt(80, 40)
        @pause_btn = new storyPauseBtn(140, 40)
        @pause_txt = new storyPauseTxt(140, 40)
        @addChild(@back_btn)
        @addChild(@back_txt)
        @addChild(@pause_btn)
        @addChild(@pause_txt)
        @kotori = new kotoriFace()
        @honoka = new honokaFace()
        @umi    = new umiFace()
        @maki   = new makiFace()
        @rin    = new rinFace()
        @hanayo = new hanayoFace()
        @nico   = new nicoFace()
        @nozomi = new nozomiFace()
        @eli    = new eliFace()
        @bgm = null
    playBgm:(bgm)->
        @bgm = game.soundload('bgm/'+bgm)
        game.bgmPlay(@bgm)
class gpStoryObjectUp extends appGroup
    constructor: () ->
        super
        @emote = new Emote()
        @addChild(@emote)