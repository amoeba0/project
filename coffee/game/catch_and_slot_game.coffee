class catchAndSlotGame extends appGame
    constructor:(w, h)->
        super w, h

class LoveliveGame extends catchAndSlotGame
    constructor:()->
        super @width, @height
        @width = 320
        @height = 320
        @fps = 24
        #画像リスト
        @imgList = ['chara1', 'icon1']
        #音声リスト
        @sondList = []
        @preloadAll()

    onload:() ->
        @main_scene = new mainScene()
        @pushScene(@main_scene)