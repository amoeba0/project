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
        @y = 100
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
        @y = 200
        @text = 'ゲームを保存する'
        @setHtml()
    touchendEvent:() ->
        game.pause_scene.setSaveMenu()

class buyItemButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super
        @y = 300
        @text = 'アイテム・部員を買う'
        @setHtml()
    touchendEvent:() ->
        game.pause_scene.setItemBuyMenu()

class useItemButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super
        @y = 400
        @text = 'アイテムを使う'
        @setHtml()
    touchendEvent:() ->
        game.pause_scene.setItemUseMenu()

class setMemberButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super
        @y = 500
        @text = '部員を編成する'
        @setHtml()
    touchendEvent:() ->
        game.pause_scene.setMemberSetMenu()

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

###
ダイアログを閉じるボタン
###
class dialogCloseButton extends systemHtml
    constructor:()->
        super 30, 30
        @image_name = 'close'
        @x = 375
        @y = 115
        @setImageHtml()

class itemBuyDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
    ontouchend: () ->
        game.pause_scene.removeItemBuyMenu()

class itemUseDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
    ontouchend: () ->
        game.pause_scene.removeItemUseMenu()

class memberSetDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
    ontouchend: () ->
        game.pause_scene.removeMemberSetMenu()