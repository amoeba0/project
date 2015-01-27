enchant()
window.onload = ->
    #グローバル変数にはwindow.をつけて宣言する
    window.game = new LoveliveGame()
    game.start()
class appGame extends Game
    constructor:(w, h)->
        super w, h
        #ミュート（消音）フラグ
        @mute = false
        @imgList = []
        @soundList = []
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
class appGroup extends Group
    constructor: () ->
        super
class appLabel extends Label
    constructor: () ->
        super
class appNode extends Node
    constructor: () ->
        super
class appScene extends Scene
    constructor: () ->
        super
class appSprite extends Sprite
    constructor: (w, h) ->
        super w, h
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
class text extends appLabel
    constructor: () ->
        super
class gameCycle extends appNode
    constructor: () ->
        super
class objectCtrl extends appNode
    constructor: () ->
        super
class slotCtrl extends appNode
    constructor: () ->
        super
class mainScene extends appScene
    constructor:()->
        super
        @initial()
    initial:()->
        @setPlayer()
    setPlayer:()->
        @bear = new Bear()
        @addChild(@bear)
class titleScene extends appScene
    constructor: () ->
        super
class backGround extends appSprite
    constructor: (w, h) ->
        super w, h
class Floor extends backGround
    constructor: (w, h) ->
        super w, h
class Panorama extends backGround
    constructor: (w, h) ->
        super w, h
class appObject extends appSprite
    constructor: (w, h) ->
        super w, h
class Character extends appObject
    constructor: (w, h) ->
        super w, h
class Guest extends Character
    constructor: (w, h) ->
        super w, h
class Player extends Character
    constructor: (w, h) ->
        super w, h

class Bear extends Player
    constructor: () ->
        super 32, 32
        @image = game.imageload("chara1")
        @x = 0
        @y = 0

    onenterframe: (e) ->
        @x = @x + 1
class Item extends appObject
    constructor: (w, h) ->
        super w, h
class Catch extends Item
    constructor: (w, h) ->
        super w, h
class Money extends Item
    constructor: (w, h) ->
        super w, h
class Slot extends appSprite
    constructor: (w, h) ->
        super w, h
class System extends appSprite
    constructor: (w, h) ->
        super w, h
class Button extends System
    constructor: (w, h) ->
        super w, h
class Param extends System
    constructor: (w, h) ->
        super w, h