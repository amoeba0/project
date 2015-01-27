class MyGame extends Game
    constructor:()->
        super @width, @height
        @width = 320
        @height = 320
        @fps = 24
        #ミュート（消音）フラグ
        @mute = false
        #画像リスト
        @imgList = ['chara1', 'icon1']
        #音声リスト
        @sondList = []
        @preloadAll()

    onload:() ->
        @main_scene = new mainScene()
        @pushScene(@main_scene)

    ###
        画像の呼び出し
    ###
    imageload:(img) ->
        return @assets["images/"+img+".png"]

    ###
        音声の呼び出し
    ###
    soundload:(sound) ->
        return @assets["sounds/"+sound+".mp3"]

    ###
        素材をすべて読み込む
    ###
    preloadAll:()->
        tmp = []
        if @imgList?
            for val in @imgList
                tmp.push "images/"+val+".png"
        if @mute is false and @soundList?
            for val in @soundList
                tmp.push "sounds/"+val+".mp3"
        @preload(tmp)