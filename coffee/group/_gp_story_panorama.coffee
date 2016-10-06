class gpStoryPanorama extends appGroup
    constructor: (panoramaImage) ->
        super
        @back = new blackBack()
        @panorama = new StoryPanorama(panoramaImage)
        @addChild(@back)
        @addChild(@panorama)
    panoramaChange:(image)->
        @panorama.image = game.imageload(image)
    panoramaChangeRect:(color='black')->
        @panorama.image = @panorama.drawRect(color)