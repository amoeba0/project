class Panorama extends backGround
    constructor: (w, h) ->
        super w, h
class BackPanorama extends Panorama
    constructor: (w, h) ->
        super game.width, game.height
        @image = game.imageload("sky")
class FrontPanorama extends Panorama
    constructor: (w, h) ->
        super game.width, 300
        @image = game.imageload("okujou")
        @setPosition()
    setPosition:()->
        @x = 0
        @y = 420