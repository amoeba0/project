class buttonHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
        @class = ['base-button']
    touchendEvent:() ->

###
ポーズメニューのボタン
###
class pauseMainMenuButtonHtml extends buttonHtml
    constructor: () ->
        super 300, 45
        @x = 90
        @y = 0
        @class.push('pause-main-menu-button')
    ontouchend: (e) ->
        @touchendEvent()

###
ゲームへ戻る
###
class returnGameButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super
        @y = 150
        @text = 'ゲームに戻る'
        @setHtml()
    touchendEvent:() ->
        game.pause_scene.buttonList.pause = true

###
ゲームを保存する
###
class saveGameButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super
        @y = 300
        @text = 'ゲームを保存する'
        @setHtml()
    touchendEvent:() ->
        game.pause_scene.setSaveMenu()

###
OKボタン
###
class baseOkButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @class.push('base-ok-button')
        @text = 'ＯＫ'
        @setHtml()
    ontouchend: (e) ->
        @touchendEvent()

###
セーブのOKボタン
###
class saveOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 170
        @y = 380
    touchendEvent:() ->
        game.pause_scene.removeSaveMenu()

###
タイトルメニューのボタン
###
class titleMenuButtonHtml extends buttonHtml
    constructor: () ->
        super 200, 45
        @x = 140
        @y = 0
        @class.push('title-menu-button')
    ontouchend: (e) ->
        @touchendEvent()

###
ゲーム開始ボタン
###
class startGameButtonHtml extends titleMenuButtonHtml
    constructor: () ->
        super
        @y = 350
        @text = 'ゲーム開始'
        @setHtml()
    touchendEvent:() ->
        game.loadGame()
        game.replaceScene(game.main_scene)