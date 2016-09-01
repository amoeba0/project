class gpStoryObject extends appGroup
    constructor: () ->
        super
        @back_btn = new storyBackBtn(80, 40)
        @back_txt = new storyBackTxt(80, 40)
        @addChild(@back_btn)
        @addChild(@back_txt)
        @kotori = new kotoriFace()
        @honoka = new honokaFace()
        @umi = new umiFace()
        #@addChild(@kotori)
        #@addChild(@honoka)
        #@kotori.x = @kotori.x_init
        #@honoka.x = @honoka.x_init