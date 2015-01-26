class MyGame extends Game
    constructor:(w, h)->
        super width, height
        @width = 320
        @height = 320
        @fps = 24
        @preload('images/chara1.png')

    onload:() ->
        bear = new Bear(32, 32, "images/chara1.png")
        @rootScene.addChild(bear)