class gpStoryPanorama extends appGroup
    constructor: () ->
        super
        @back = new blackBack()
        @panorama = new StoryPanorama()
        @haiko = new haikoFace()
        @addChild(@back)
        @addChild(@panorama)
        @addChild(@haiko)
        @haiko.x = @haiko.x_init