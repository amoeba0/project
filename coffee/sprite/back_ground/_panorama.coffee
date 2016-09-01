class Panorama extends backGround
    constructor: (w, h) ->
        super w, h
class BackPanorama extends Panorama
    constructor: (w, h) ->
        super game.width, game.height
        @image = game.imageload("sky")
class FrontPanorama extends Panorama
    constructor: (w, h) ->
        super game.width, 310
        @image = game.imageload("okujou")
        @setPosition()
    setPosition:()->
        @x = 0
        @y = game.height - @h + 3
class StoryPanorama extends Panorama
    constructor:(image)->
        w = game.width - 10
        h = game.width
        super w, h
        @image = game.imageload(image)
        @x = 5
        @y = Math.floor((game.height - h) / 2)
