class buttonHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
        @class = ['base-button']
        @dicisionSe = game.soundload('dicision')
        @cancelSe = game.soundload('cancel')
        @is_button = true
    touchendEvent:() ->
    makeAble:()->
        @is_button = true
        @setHtml()
        @opacity = 1
    makeDisable:()->
        @is_button = false
        @setHtml()
        @opacity = 0.5

###
ポーズメニューのボタン
###
class pauseMainMenuButtonHtml extends buttonHtml
    constructor: (width, height) ->
        super width, height
        @x = 30
        @y = 0
        @class.push('pause-main-menu-button')
    ontouchend: (e) ->
        @touchendEvent()

###
ゲームへ戻る
###
class returnGameButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 300, 45
        @y = 640
        @text = 'ゲームに戻る'
        @class.push('pause-main-menu-button-white')
        @setHtml()
    touchendEvent:() ->
        #game.sePlay(@cancelSe)
        game.pause_scene.buttonList.pause = true

class batuButtonHtml extends buttonHtml
    constructor: () ->
        super 70, 70
        @x = 420
        @y = 30
        @text = '×'
        @class = ['batu-button']
        @setHtml()
    ontouchend: (e) ->
        game.pause_scene.buttonList.pause = true

###
ゲームを保存する
###
class saveGameButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 100, 45
        @x = 30
        @y = 535
        @text = 'セーブ'
        @class.push('pause-main-menu-button-mini')
        @class.push('pause-main-menu-button-blue')
        @setHtml()
    touchendEvent:() ->
        if game.fever is false
            game.sePlay(@dicisionSe)
            game.pause_scene.setSaveConfirmMenu()

class returnTitleButtonHtml extends pauseMainMenuButtonHtml
    constructor:()->
        super 100, 45
        @x = 310
        @y = 535
        @text = 'タイトル'
        @class.push('pause-main-menu-button-mini')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@dicisionSe)
        game.pause_scene.setTitleConfirmMenu()

class buyItemButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 400, 45
        @y = 325
        @text = 'アイテムSHOP'
        @class.push('pause-main-menu-button-purple')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@dicisionSe)
        game.pause_scene.setItemBuyMenu()

class useItemButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 100, 45
        @x = 30
        @y = 430
        @text = 'スキル'
        @class.push('pause-main-menu-button-small')
        @class.push('pause-main-menu-button-green')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@dicisionSe)
        game.pause_scene.setItemUseMenu()

class setMemberButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 100, 45
        @x = 170
        @y = 430
        @text = '部員'
        @class.push('pause-main-menu-button-small')
        @class.push('pause-main-menu-button-red')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@dicisionSe)
        game.pause_scene.setMemberSetMenu()

class recordButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 100, 45
        @x = 310
        @y = 430
        @text = '実績'
        @class.push('pause-main-menu-button-small')
        @class.push('pause-main-menu-button-orange')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@dicisionSe)
        game.pause_scene.setRecordMenu()

###
OKボタン
###
class baseOkButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @class.push('base-ok-button')
        if game.isSumaho()
            @class.push('base-ok-button-sp')
        @text = 'ＯＫ'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        @touchendEvent()

###
セーブのOKボタン
###
class saveOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 170
        @y = 334
    touchendEvent:() ->
        game.pause_scene.removeSaveMenu()

class saveConfirmOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 80
        @y = 334
    touchendEvent:()->
        game.pause_scene.setSaveMenu()

###
タイトルへ戻るOKボタン
###
class titleConfirmOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 80
        @y = 334
    touchendEvent:() ->
        game.returnToTitle()

class recordOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 170
        @y = 484
    touchendEvent:() ->
        game.pause_scene.removeRecordSelectMenu()

class trophyOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 170
        @y = 484
    touchendEvent:() ->
        game.pause_scene.removeTrophySelectmenu()

class helpOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 260
        @y = 500
    touchendEvent:() ->
        game.pause_scene.helpEnd()

class helpNextButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @x = 260
        @y = 500
        @class.push('base-buy-button')
        if game.isSumaho()
            @class.push('base-ok-button-sp')
        @text = '次へ'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        game.pause_scene.pause_help_layer.goNext()

class helpPrevButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @x = 60
        @y = 500
        @class.push('base-buy-button')
        if game.isSumaho()
            @class.push('base-ok-button-sp')
        @text = '前へ'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        game.pause_scene.pause_help_layer.goPrev()

###
キャンセルボタン
###
class baseCancelButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @class.push('base-cancel-button')
        if game.isSumaho()
            @class.push('base-cancel-button-sp')
        @text = 'キャンセル'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@cancelSe)
        @touchendEvent()

class saveConfirmCancelButtonHtml extends baseCancelButtonHtml
    constructor:()->
        super
        @x = 260
        @y = 335
    touchendEvent:()->
        game.pause_scene.removeSaveConfirmMenu()

class titleConfirmCancelButtonHtml extends baseCancelButtonHtml
    constructor:()->
        super
        @x = 260
        @y = 335
    touchendEvent:()->
        game.pause_scene.removeTitleConfirmMenu()

###
アイテム購入のキャンセルボタン
###
class itemBuyCancelButtonHtml extends baseCancelButtonHtml
    constructor:()->
        super
        @y = 500

    touchendEvent:() ->
        game.pause_scene.removeItemBuySelectMenu()
    setBuyImpossiblePositon:()->
        @x = 250
    setBuyPossiblePosition:()->
        @x = 250

###
アイテム使用のキャンセルボタン
###
class itemUseCancelButtonHtml extends baseCancelButtonHtml
    constructor:()->
        super
        @y = 500
        @x = 250
    touchendEvent:()->
        game.pause_scene.removeItemUseSelectMenu()

###
部員使用のキャンセルボタン
###
class memberUseCancelButtonHtml extends baseCancelButtonHtml
    constructor:()->
        super
        @y = 500
        @x = 250
    touchendEvent:()->
        game.pause_scene.removeMemberUseSelectMenu()

###
購入ボタン
###
class baseByuButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @class.push('base-buy-button')
        if game.isSumaho()
            @class.push('base-buy-button-sp')
        @text = '購入'
        @setHtml()
    ontouchend: (e) ->
        @touchendEvent()

###
アイテム購入の購入ボタン
###
class itemBuyBuyButtonHtml extends baseByuButtonHtml
    constructor:()->
        super
        @y = 500
        @impossible = true
    touchendEvent:() ->
        if @impossible is false
            game.sePlay(@dicisionSe)
            game.pause_scene.pause_item_buy_select_layer.buyItem()
    setBuyImpossiblePositon:()->
        @x = 70
        @class.push('grayscale')
        @opacity = 0.5
        @setHtml()
        @impossible = true
    setBuyPossiblePosition:()->
        @x = 70
        @class = game.arrayValueDel(@class, 'grayscale')
        @opacity = 1
        @setHtml()
        @impossible = false

###
セットボタン
###
class baseSetButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @class.push('base-set-button')
        if game.isSumaho()
            @class.push('base-ok-button-sp')
        @text = 'セット'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        @touchendEvent()

###
アイテム使用のセットボタン
###
class itemUseSetButtonHtml extends baseSetButtonHtml
    constructor:()->
        super
        @y = 500
        @x = 70
    touchendEvent:()->
        game.pause_scene.pause_item_use_select_layer.setItem()
    setText:(kind)->
        if game.item_set_now.indexOf(parseInt(kind)) != -1
            @text = '解除'
            @setHtml()
        else
            @text = 'セット'
            @setHtml()


###
部員使用のセットボタン
###
class memberUseSetButtonHtml extends baseSetButtonHtml
    constructor:()->
        super
        @y = 500
        @x = 70
    touchendEvent:()->
        game.pause_scene.pause_member_use_select_layer.setMember()
    setText:(kind)->
        if game.member_set_now.indexOf(parseInt(kind)) != -1
            @text = '解除'
            @setHtml()
        else
            @text = 'セット'
            @setHtml()

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
        game.sePlay(@dicisionSe)
        @touchendEvent()

###
ゲーム開始ボタン
###
class startGameButtonHtml extends titleMenuButtonHtml
    constructor: () ->
        super
        @y = 630
        @text = '続きから'
        @setHtml()
    touchendEvent:() ->
        game.loadGameStart()

class newGameButtonHtml extends titleMenuButtonHtml
    constructor: () ->
        super
        @y = 550
        @text = '初めから'
        @setHtml()
    touchendEvent:() ->
        game.newGameStart()

class story1stButtonHtml extends titleMenuButtonHtml
    constructor: () ->
        super
        @y = 470
        @text = '第1話'
        @setHtml()
    touchendEvent:() ->
        game.startOpStory()

###
ダイアログを閉じるボタン
###
class dialogCloseButton extends systemHtml
    constructor:()->
        super 90, 90
        @image_name = 'close'
        @is_button = true
        @x = 370
        @y = 70
        @setImageHtml()
        @cancelSe = game.soundload('cancel')

class itemBuyDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 40
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeItemBuyMenu()

class itemUseDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 40
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeItemUseMenu()

class memberSetDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 40
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeMemberSetMenu()

class recordDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 40
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeRecordMenu()

class helpDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 80
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.helpEnd()

###
部員のおすすめ編成
###
class autoMemberSetButtonHtml extends buttonHtml
    constructor:()->
        super 180, 45
        @x = 45
        @y = 560
        @class.push('osusume-button')
        if game.isSumaho()
            @class.push('base-ok-button-sp')
        @text = 'おまかせ'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        game.member_set_now = game.slot_setting.getRoleAbleMemberList()
        if game.member_set_now.indexOf(game.slot_setting.now_muse_num) != -1
            game.slot_setting.now_muse_num = 0
        game.pause_scene.pause_member_set_layer.dispSetMemberList()

###
部員の全解除
###
class autoMemberUnsetButtonHtml extends buttonHtml
    constructor:()->
        super 180, 45
        @x = 245
        @y = 560
        @class.push('osusume-button')
        if game.isSumaho()
            @class.push('base-ok-button-sp')
        @text = '全解除'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        game.member_set_now = []
        game.pause_scene.pause_member_set_layer.dispSetMemberList()

class storyButtonHtml extends buttonHtml
    constructor:()->
        super 150, 45
        @x = 70
        @y = 483
        @class.push('story-button')
        @text = ''
    ontouchend: (e) ->
        game.startEdStory()

class secondButtonHtml extends storyButtonHtml
    constructor:()->
        super
        @text = '第２話'
        @setHtml()
    ontouchend: (e) ->
        game.start2ndStory()

class thirdButtonHtml extends storyButtonHtml
    constructor:()->
        super
        @text = '第３話'
        @setHtml()
    ontouchend: (e) ->
        game.start3rdStory()

class fourthButtonHtml extends storyButtonHtml
    constructor:()->
        super
        @text = '第４話'
        @setHtml()
    ontouchend: (e) ->
        game.start4thStory()

class endingButtonHtml extends storyButtonHtml
    constructor:()->
        super
        @text = '最終話'
        @setHtml()
    ontouchend: (e) ->
        game.startEdStory()

class helpButtonHtml extends buttonHtml
    constructor:(type=0, x=0, y=0)->
        super 70, 25
        @type = type
        @x = x
        @y = y
        @text = 'HELP'
        @class.push('help-button')
        @setUnread()
    ontouchend:(e)->
        game.sePlay(@dicisionSe)
        @helpDsp(@type)
    helpDsp:(type)->
        game.pause_scene.helpDsp(type)
        if game.help_read.indexOf(type) is -1
            game.help_read.push(type)
            @setUnread()
    setUnread:()->
        if game.help_read.indexOf(@type) is -1
            @class.push('help-button-unread')
        else
            @class = game.arrayValueDel(@class, 'help-button-unread')
        @setHtml()

class tweetButtonHtml extends pauseMainMenuButtonHtml
    constructor:()->
        super 100, 45
        @x = 170
        @y = 535
        @text = '<div class="tweet-up">稼いだ金額を</div><div class="tweet-low">ツイート</div>'
        @class.push('pause-main-menu-button-mini')
        @class.push('pause-main-menu-button-sky')
        @class.push('pause-main-menu-button-tweet')
        @setHtml()
        @money = game.toJPUnit(game.max_money, 0, 1)
        if game.money >= Math.pow(10, 19)
            @money += '＋端数　円くらい'
        else
            @money += '円'
    ontouchend:(e)->
        window.open('https://twitter.com/intent/tweet?url=https%3A%2F%2Fkotoyayo.firebaseapp.com%2Fkotori%2Findex.html\&ref_src=twsrc%5Etfw\&tw_p=tweetbutton\&text=スロットことりのおやつで'+@money+'稼いだよ！\&hashtags=スロットことりのおやつ')