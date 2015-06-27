class gpPanorama extends appGroup
    constructor: () ->
        super
        @back_panorama = new BackPanorama()
        @addChild(@back_panorama)
        @front_panorama = new FrontPanorama()
        @addChild(@front_panorama)