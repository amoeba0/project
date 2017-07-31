class dialogHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
class modal extends dialogHtml
    constructor:()->
        super game.width, game.height
        @class = ['modal']
        @text = '　'
        @setHtml()
class baseDialogHtml extends dialogHtml
    constructor: (width, height) ->
        super width, height
        @class = ['base-dialog']
class saveDialogHtml extends baseDialogHtml
    constructor: () ->
        super 375, 375
        @class.push('base-dialog-save')
        @x = 60
        @y = 150
        @setHtml()
class betDialogHtml extends baseDialogHtml
    constructor:()->
        super 340, 240
        @x = 60
        @y = 90
        @class.push('base-dialog-bet')
        @setHtml()
class menuDialogHtml extends baseDialogHtml
    constructor:(width=420, height=460)->
        super width, height
        @text = '　'
        @classPush()
        @x = 25
        @y = 80
        @setHtml()
    classPush:()->
        @class.push('base-dialog-menu')
class itemBuyDialogHtml extends menuDialogHtml
    constructor:()->
        super 420, 500
        @y = 50
    classPush:()->
        @class.push('base-dialog-high')

class itemUseDialogHtml extends menuDialogHtml
    constructor:()->
        super 420, 500
        @y = 50
    classPush:()->
        @class.push('base-dialog-high')

class memberSetDialogHtml extends menuDialogHtml
    constructor:()->
        super 420, 500
        @y = 50
    classPush:()->
        @class.push('base-dialog-high')

class recordDialogHtml extends menuDialogHtml
    constructor:()->
        super 420, 500
        @y = 50
    classPush:()->
        @class.push('base-dialog-high')

class selectDialogHtml extends baseDialogHtml
    constructor:()->
        super 300, 400
        @text = '　'
        @class.push('base-dialog-select')
        @x = 35
        @y = 150
        @setHtml()

class itemBuySelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class itemUseSelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class memberUseSelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class recordSelectDialogHtml extends selectDialogHtml
    constructor:()->
        super

class discriptionTextDialogHtml extends dialogHtml
    constructor:(w, h)->
        super w, h
        @class.push('base-discription')
        if game.isSumaho()
            @class.push('base-discription-sp')

class titleDiscription extends discriptionTextDialogHtml
    constructor:(width=400, height=20)->
        super width, height
        @class.push('title-discription')
        if game.isSumaho()
            @class.push('title-discription-sp')

class itemItemBuyDiscription extends titleDiscription
    constructor:()->
        super 120, 20
        @x = 180
        @y = 80
        @text = 'スキル'
        @class.push('head2-discription')
        @setHtml()

class memberItemBuyDiscription extends titleDiscription
    constructor:()->
        super 120, 20
        @x = 180
        @y = 310
        @text = '部員'
        @class.push('head2-discription')
        @setHtml()

class trophyItemBuyDiscription extends titleDiscription
    constructor:()->
        super 180, 20
        @x = 160
        @y = 530
        @text = 'トロフィー'
        @class.push('head2-discription')
        @setHtml()

class useSetDiscription extends titleDiscription
    constructor:()->
        super 160, 20
        @x = 160
        @y = 170
        @text = 'セット中'
        @class.push('head2-discription')
        @setHtml()

class memberUseDiscription extends titleDiscription
    constructor:()->
        super 250, 20
        @x = 130
        @y = 170
        @text = 'ユニット編成中'
        @class.push('head2-discription')
        @setHtml()

class useHaveDiscription extends titleDiscription
    constructor:()->
        super 200, 20
        @x = 150
        @y = 370
        @text = '所持リスト'
        @class.push('head2-discription')
        @setHtml()

class recordDiscription extends titleDiscription
    constructor:()->
        super 100, 200
        @x = 200
        @y = 80
        @text = '楽曲'
        @class.push('head2-discription')
        @setHtml()

class trophyDiscription extends titleDiscription
    constructor:()->
        super 180, 20
        @x = 160
        @y = 520
        @text = 'トロフィー'
        @class.push('head2-discription')
        @setHtml()

class speedDiscription extends titleDiscription
    constructor:()->
        super 340, 20
        @x = 80
        @y = 530
        @text = '移動速度とジャンプ力'
        @class.push('head2-discription')
        @setHtml()

class menuDiscription extends titleDiscription
    constructor:()->
        super
        @x = 170
        @y = 30
        @class.push('white-text')
        @text = 'メニュー'
        @setHtml()

class itemNameDiscription extends titleDiscription
    constructor:()->
        super
        @x = 50
        @y = 290
    setText:(text)->
        @text = text
        @setHtml()

class itemDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 390, 150
        @x = 50
        @y = 340
    setText:(text)->
        @text = text
        @setHtml()

class saveConfirmDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 390, 150
        @x = 100
        @y = 230
        @text = 'ゲームの進行状態を保存します。<br>よろしいですか？'
        @setHtml()

class titleConfirmDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 390, 150
        @x = 80
        @y = 210
        @text = 'タイトル画面に戻ります。<br>保存していないゲームの進行状況は<br>失われます。<br>よろしいですか？'
        @setHtml()

class saveEndDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 390, 150
        @x = 100
        @y = 230
        @text = 'セーブ完了しました。'
        @setHtml()

class longTitleDiscription extends discriptionTextDialogHtml
    constructor:()->
        super 270, 20
        @class.push('head-title-discription')
        if game.isSumaho()
            @class.push('head-title-discription-sp')


class itemUseDiscription extends longTitleDiscription
    constructor:()->
        super
        @x = 110
        @y = 80
        @text = 'スキルをセットする'
        @class.push('head1-discription')
        @setHtml()

class memberSetDiscription extends longTitleDiscription
    constructor:()->
        super
        @x = 150
        @y = 80
        @text = '部員を編成する'
        @class.push('head1-discription')
        @width = 220
        @setHtml()

class titleDiscription extends dialogHtml
    constructor:()->
        super game.width, 200
        @x = 0
        @y = 200
        @sousa = '←→・・・横移動、　z・・・ジャンプ<br>
            ↑↓・・・掛け金の変更、　x・・・メニュー画面'
        @sp = ''
        if game.isSumaho() is true
            @sousa = '←→・・・横移動<br>
                ●・・・ジャンプ<br>
                ↑↓・・・掛け金の変更、　MENU・・・メニュー画面'
            @sp = '-sp'
        @text= '<div class="title-head'+@sp+'">・遊び方</div>
            <div class="title-dsc'+@sp+'">
                上からおやつが降ってくるのでキャッチして下さい。<br>
                キャッチに成功するとスロットマシンが止まります。
            </div>
            <div class="title-head'+@sp+'">・操作方法</div>
            <div class="title-dsc'+@sp+'">'+@sousa+'</div>'
        @class.push('title-scene-discription')
        @setHtml()

class helpTitle extends dialogHtml
    constructor:(txt)->
        super 300, 50
        @x = 70
        @y = 130
        @sp = ''
        if game.isSumaho() is true then @sp = '-sp'
        @class.push('help-title' + @sp)
        @text = txt
        @setHtml()

class pageNum extends dialogHtml
    constructor:(txt)->
        super 100, 30
        if game.isSumaho()
            @x = 190
        else
            @x = 180
            @width = 120
        @y = 180
        @sp = ''
        if game.isSumaho() is true then @sp = '-sp'
        @class.push('help-discription' + @sp)
        @setText(txt)
    setText:(txt)->
        @text = txt
        @setHtml()

class helpDiscription extends dialogHtml
    constructor:(txt)->
        super 380, 460
        @x = 50
        @y = 220
        @sp = ''
        if game.isSumaho() is true then @sp = '-sp'
        @class.push('help-discription' + @sp)
        @setText(txt)
    setText:(txt)->
        @text = txt
        @setHtml()