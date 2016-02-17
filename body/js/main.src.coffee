enchant()
window.onload = ->
    #グローバル変数にはwindow.をつけて宣言する
    window.game = new LoveliveGame()
    game.start()
class appDomLayer extends DomLayer
    constructor: () ->
        super
        @modal = new modal()
class appGame extends Game
    constructor:(w, h)->
        super w, h
        #if @isSumaho() is false
        @scale = 1
        @is_server = false
        @mute = false #ミュート（消音）フラグ
        @imgList = []
        @soundList = []
        @nowPlayBgm = null
        @loadedFile = [] #ロード済みのファイル
        @mstVolume = 1 #ゲームの全体的な音量
        @_getIsServer()

    ###
    動かしてる環境がローカルか、サーバーかを判定
    ###
    _getIsServer:()->
        if location.href.indexOf('file:/') != -1
            @is_server = false
        else
            @is_server = true

    getWindowScale:()->
        scale = 1
        browserAspect = window.innerHeight / window.innerWidth
        gameAspect = @height / @width
        if browserAspect < gameAspect
            scale = Math.floor(window.innerHeight * 1000 / @height) / 1000
        else
            scale = Math.floor(window.innerWidth * 1000 / @width) / 1000
        return scale

    ###
        画像の呼び出し
    ###
    imageload:(img) ->
        callImg = @assets["images/"+img+".png"]
        if callImg is undefined
            callImg = null
        return callImg

    ###
        音声の呼び出し
    ###
    soundload:(sound) ->
        return @assets["sounds/"+sound+".mp3"]

    ###
    効果音を鳴らす
    ###
    sePlay:(se)->
        se.clone().play()

    ###
    BGMをならす
    ###
    bgmPlay:(bgm, bgm_loop = false)->
        if bgm != undefined
            bgm.play()
            @nowPlayBgm = bgm
            if bgm_loop is true
                if @is_server is true
                    bgm.src.loop = true
                else
                    bgm._element.loop = true

    ###
    BGMを止める
    ###
    bgmStop:(bgm)->
        if bgm != undefined
            bgm.stop()
            @nowPlayBgm = null

    ###
    BGMの中断
    ###
    bgmPause:(bgm)->
        if bgm != undefined
            bgm.pause()

    ###
    現在再生中のBGMを一時停止する
    ###
    nowPlayBgmPause:()->
        if @nowPlayBgm != null
            @bgmPause(@nowPlayBgm)

    ###
    現在再生中のBGMを再開する
    ###
    nowPlayBgmRestart:(bgm_loop = false)->
        if @nowPlayBgm != null
            @bgmPlay(@nowPlayBgm, bgm_loop)

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

    ###
    enchant.jsのload関数をラッピング
    ロード終了後にloadedFileにロードしたファイルを置いておいて、ロード済みかどうかの判別に使う
    ###
    appLoad:(file)->
        @load(file)
        #if @loadedFile.indexOf(file) is -1
        #@load(file, @setLoadedFile(file))

    ###
    ロード済みのファイルを記憶しておく
    ###
    setLoadedFile:(file)->
        @loadedFile.push(file)

    ###
    数値から右から数えた特定の桁を取り出して数値で返す
    @param number num   数値
    @param number digit 右から数えた桁数、例：1の位は１、10の位は２、１００の位は３
    @return number
    ###
    getDigitNum:(num, digit)->
        tmp_num = num + ''
        split_num = tmp_num.length - digit
        split = tmp_num.substring(split_num, split_num + 1)
        result = Number(split)
        return result

    ###
    配列、オブジェクトの参照渡しを防ぐためにコピーする
    http://monopocket.jp/blog/javascript/2137/
    @param array or object target コピー対象
    @param boolean isObject true:object false:array
    @return array or object
    ###
    arrayCopy:(target, isObject = false)->
        if isObject is true
            tmp_arr = {}
        else
            tmp_arr = []
        return $.extend(true, tmp_arr, target)

    ###
    配列から重複を除外したリストを返す
    ###
    getDeduplicationList:(arr)->
        return arr.filter(
            (x, i, self)->
                return self.indexOf(x) == i
        )
    ###
    数値の昇順ソート
    ###
    sortAsc:(arr)->
        return arr.sort(
            (a,b)->
                if a < b
                    return -1
                if a > b
                    return 1
                return 0
        )
    ###
    数値の降順ソート
    ###
    sortDesc:(arr)->
        return arr.sort(
            (a,b)->
                if a > b
                    return -1
                if a < b
                    return 1
                return 0
        )
    ###
    配列から指定の値を削除して詰めて返す
    @param arr    対象の配列
    @param target 削除する値
    @return array
    ###
    arrayValueDel:(arr, target)->
        arr.some((v, i)->
            if v == target
                arr.splice(i, 1)
        )
        return arr

    ###
    targetの配列の中にsearchの配列が全て入っていたらtrueを返す
    １つでも入っていなかったらfalseを返す
    @param arr target 検索する対象の配列
    @param arr search 検索する文字列を格納した配列
    @return boolean
    ###
    arrIndexOf:(target, search)->
        rslt = true
        for searchVal in search
            if target.indexOf(searchVal) is -1
                rslt = false
                break
        return rslt

    ###
    数値の単位を漢数字で区切る
    ###
    toJPUnit:(num)->
        str = num + ''
        n = ''
        n_ = ''
        count = 0
        ptr = 0
        kName = ['', '万', '億', '兆', '京', '垓']
        i = str.length - 1
        while i >= 0
            n_ = str.charAt(i) + n_
            count++
            if count % 4 == 0 and i != 0
                if n_ != '0000'
                    n = n_ + kName[ptr] + n
                n_ = ''
                ptr += 1
            if i == 0
                n = n_ + kName[ptr] + n
            i--
        return n

    ###
    ユーザーエージェントの判定
    ###
    userAgent:()->
        u = window.navigator.userAgent.toLowerCase()
        mobile = {
            0: u.indexOf('windows') != -1 and u.indexOf('phone') != -1 or u.indexOf('iphone') != -1 or u.indexOf('ipod') != -1 or u.indexOf('android') != -1 and u.indexOf('mobile') != -1 or u.indexOf('firefox') != -1 and u.indexOf('mobile') != -1 or u.indexOf('blackberry') != -1
            iPhone: u.indexOf('iphone') != -1
            Android: u.indexOf('android') != -1 and u.indexOf('mobile') != -1
        }
        tablet = u.indexOf('windows') != -1 and u.indexOf('touch') != -1 or u.indexOf('ipad') != -1 or u.indexOf('android') != -1 and u.indexOf('mobile') == -1 or u.indexOf('firefox') != -1 and u.indexOf('tablet') != -1 or u.indexOf('kindle') != -1 or u.indexOf('silk') != -1 or u.indexOf('playbook') != -1
        pc = !mobile[0] and !tablet
        return {
            Mobile: mobile
            Tablet: tablet
            PC: pc
        }
    ###
    スマホかタブレットならtrueを返す
    ###
    isSumaho:()->
        ua = @userAgent()
        rslt = false
        if ua.Mobile[0] is true || ua.Tablet is true
            rslt = true
        return rslt
class appGroup extends Group
    constructor: () ->
        super
class appHtml extends Entity
    constructor: (width, height) ->
        super
        @_element = document.createElement('div')
        @width = width
        @height = height
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
        @w = w
        @h = h
    _makeContext:() ->
        @surface = new Surface(@w, @h)
        @context = @surface.context

    ###
    枠の無い長方形
    @param color 色
    ###
    drawRect: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.fillRect(0, 0, @w, @h, 10)
        @context.fill()
        return @surface
    ###
    枠のある長方形
    @param string strokeColor 枠の色
    @param string fillColor   色
    @param number thick       枠の太さ
    ###
    drawStrokeRect:(strokeColor, fillColor, thick)->
        @_makeContext()
        @context.fillStyle = strokeColor
        @context.fillRect(0, 0, @w, @h)
        @context.fillStyle = fillColor
        @context.fillRect(thick, thick, @w - (thick * 2), @h - (thick * 2))
        return @surface

    ###
    左向きの三角形
    @param color 色
    ###
    drawLeftTriangle: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.beginPath()
        @context.moveTo(0, @h / 2)
        @context.lineTo(@w, 0)
        @context.lineTo(@w, @h)
        @context.closePath()
        @context.fill()
        return @surface

    ###
    上向きの三角形
    @param color 色
    ###
    drawUpTriangle: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.beginPath()
        @context.moveTo(@w / 2, 0)
        @context.lineTo(@w, @h)
        @context.lineTo(0, @h)
        @context.closePath()
        @context.fill()
        return @surface

    ###
    丸
    @param color 色
    ###
    drawCircle: (color) ->
        @_makeContext()
        @context.fillStyle = color
        @context.arc(@w / 2, @h / 2, @w / 2, 0, Math.PI * 2, true)
        @context.fill()
        return @surface
class pauseItemBuyLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemBuyDialogHtml()
        @close_button = new itemBuyDialogCloseButton()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @item_list = {}
        for i in [1..9]
            @item_list[i] = new buyItemHtml(i)
        @member_list = {}
        for i in [11..19]
            @member_list[i] = new buyMemberHtml(i)
        @trophy_list = {}
        for i in [21..24]
            @trophy_list[i] = new buyTrophyItemHtml(i - 21, i)
        @setItemList()
        @resetItemList()
        @item_title = new itemItemBuyDiscription()
        @addChild(@item_title)
        @member_title = new memberItemBuyDiscription()
        @addChild(@member_title)
        @trophy_title = new trophyItemBuyDiscription()
        @addChild(@trophy_title)
    setItemList:()->
        for item_key, item_val of @item_list
            @addChild(item_val)
            item_val.setPosition()
        for member_key, member_val of @member_list
            @addChild(member_val)
            member_val.setPosition()
        for trophy_key, trophy_val of @trophy_list
            @addChild(trophy_val)
            trophy_val.setPosition()
    #持ってるアイテムを透明にする、クリックできなくする
    resetItemList:()->
        master_list = game.slot_setting.item_list
        for i in [1..19]
            if master_list[i] is undefined
                master_list[i] = master_list[0]
        @_resetItemList(@item_list, master_list)
        @_resetItemList(@member_list, master_list)
        @_resetItemList(@trophy_list, master_list)
    _resetItemList:(item_list, master_list)->
        for item_key, item_val of item_list
            if master_list[item_key].condFunc() is false || master_list[item_key].price > game.money
                item_val.opacity = 0.5
                item_val.is_exist = true
                item_val.changeIsButton()
                #item_val.addDomClass('grayscale', true)
            else
                item_val.opacity = 1
                item_val.is_exist = true
                item_val.changeIsButton()
                #item_val.removeDomClass('grayscale', true)
            if game.item_have_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 0
                item_val.is_exist = false
                item_val.changeNotButton()

class pauseItemBuySelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new itemBuySelectDialogHtml()
        @cancel_button = new itemBuyCancelButtonHtml()
        @buy_button = new itemBuyBuyButtonHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
        @addChild(@cancel_button)
        @addChild(@buy_button)
        @item_kind = 0
        @item_options = []
    setSelectItem:(kind)->
        @item_kind = kind
        @item_options = game.slot_setting.item_list[kind]
        if @item_options is undefined
            @item_options = game.slot_setting.item_list[0]
        @item_name.setText(@item_options.name)
        @item_image.setImage(@item_options.image)
        discription = @_setDiscription()
        @item_discription.setText(discription)
        @_setButton()
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        if @item_options.durationSec != undefined
            text += '<br>持続時間：'+@item_options.durationSec+'秒'
        if @item_options.condFunc() is true || 20 < @item_kind
            text += '<br>値段：'+game.toJPUnit(@item_options.price)+'円'+'(所持金'+game.toJPUnit(game.money)+'円)'
        if @item_options.condFunc() is false || 20 < @item_kind
            text += '<br>出現条件：'+@item_options.conditoin
            if @item_kind is 21 || @item_kind is 23
                text += '<br>(MAXコンボ'+game.max_combo+')'
            if @item_kind is 22
                text += '<br>('+game.countSoloMusic()+'曲達成済)'
            if @item_kind is 24
                text += '<br>('+game.countFullMusic()+'曲達成済)'
        return text
    _setButton:()->
        if @item_options.condFunc() is true && game.money >= @item_options.price
            @cancel_button.setBuyPossiblePosition()
            @buy_button.setBuyPossiblePosition()
        else
            @cancel_button.setBuyImpossiblePositon()
            @buy_button.setBuyImpossiblePositon()
    ###
    アイテムの購入
    ###
    buyItem:()->
        game.money -= @item_options.price
        game.pause_scene.pause_main_layer.statusDsp()
        game.item_have_now.push(@item_kind)
        game.pause_scene.removeItemBuySelectMenu()
        game.pause_scene.pause_item_buy_layer.resetItemList()
        game.main_scene.gp_system.money_text.setValue()
        if 21 <= @item_kind
            game.pause_scene.pause_record_layer.resetTrophyList()

class pauseItemUseLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemUseDialogHtml()
        @close_button = new itemUseDialogCloseButton()
        @menu_title = new itemUseDiscription()
        @set_title = new useSetDiscription()
        @have_title = new useHaveDiscription()
        @speed_title = new speedDiscription()
        @set_title.y = 140
        @have_title.y = 300
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@menu_title)
        @addChild(@set_title)
        @addChild(@have_title)
        @addChild(@speed_title)
        @item_list = {} #アイテム所持リスト
        @set_item_list = {} #アイテムセット中リスト
        @speed_list = {}
        for i in [1..9]
            @item_list[i] = new useItemHtml(i)
        for i in [1..game.limit_set_item_num]
            @set_item_list[i] = new setItemHtml(i)
            @addChild(@set_item_list[i])
        for i in [1..3]
            @speed_list[i] = new speedHtml(i)
            @addChild(@speed_list[i])
        @setItemList()
        @dspSetItemList()
        @setSpeedList()
    setItemList:()->
        for item_key, item_val of @item_list
            @addChild(item_val)
            item_val.setPosition()
    setSpeedList:()->
        for speed_key, speed_val of @speed_list
            speed_val.setPosition()
            speed_val.opacity = 0.5
            speed_val.addDomClass('grayscale', true)
            speed_val.changeNotButton()
            speed_val.is_exist = false
    resetItemList:()->
        for item_key, item_val of @item_list
            if game.item_set_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 0
                item_val.changeNotButton()
                item_val.is_exist = false
            else if game.item_have_now.indexOf(parseInt(item_key)) != -1
                item_val.opacity = 1
                item_val.removeDomClass('grayscale', true)
                item_val.changeIsButton()
                item_val.is_exist = true
            else
                item_val.opacity = 0.5
                item_val.addDomClass('grayscale', true)
                item_val.changeNotButton()
                item_val.is_exist = false
    #セットされているアイテムをレンダリングする
    dspSetItemList:()->
        game.setItemSlot()
        @resetItemList()
        for item_key, item_val of @set_item_list
            item_val.setPosition()
            if game.max_set_item_num < item_key
                item_val.setItemKind(0)
                item_val.opacity = 0.5
                item_val.changeNotButton()
                item_val.addDomClass('grayscale', true)
            else if game.item_set_now[item_key - 1] != undefined
                item_val.setItemKind(game.item_set_now[item_key - 1])
                item_val.opacity = 1
                item_val.changeIsButton()
                item_val.removeDomClass('grayscale', true)
            else
                item_val.setItemKind(0)
                item_val.opacity = 1
                item_val.changeIsButton()
                item_val.removeDomClass('grayscale', true)

class pauseItemUseSelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new itemUseSelectDialogHtml()
        @cancel_button = new itemUseCancelButtonHtml()
        @set_button = new itemUseSetButtonHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@cancel_button)
        @addChild(@set_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @set_button.setText(kind)
        @item_kind = kind
        @item_options = game.slot_setting.item_list[kind]
        if @item_options is undefined
            @item_options = game.slot_setting.item_list[0]
        @item_name.setText(@item_options.name)
        @item_image.setImage(@item_options.image)
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        if @item_options.durationSec != undefined
            text += '<br>持続時間：'+@item_options.durationSec+'秒'
        return text
    setItem:()->
        @_itemSet(@item_kind)
        game.slot_setting.setItemDecreasePoint()
        game.main_scene.gp_system.itemDsp()
        game.pause_scene.pause_item_use_layer.dspSetItemList()
        game.pause_scene.removeItemUseSelectMenu()
    #アイテムをセットする
    _itemSet:(kind)->
        if game.item_set_now.indexOf(parseInt(kind)) == -1
            if (game.max_set_item_num <= game.item_set_now.length)
                game.item_set_now.shift()
            game.item_set_now.push(kind)
        else
            game.item_set_now = game.arrayValueDel(game.item_set_now, kind)
            game.prev_item = []
class pauseMainLayer extends appDomLayer
    constructor: () ->
        super
        @return_game_button = new returnGameButtonHtml()
        @save_game_button = new saveGameButtonHtml()
        @title_button = new returnTitleButtonHtml()
        @buy_item_button = new buyItemButtonHtml()
        @use_item_button = new useItemButtonHtml()
        @set_member_button = new setMemberButtonHtml()
        @record_button = new recordButtonHtml()
        @bet_dialog = new betDialogHtml()
        @addChild(@return_game_button)
        @addChild(@save_game_button)
        @addChild(@title_button)
        @addChild(@buy_item_button)
        @addChild(@use_item_button)
        @addChild(@set_member_button)
        @addChild(@record_button)
        @addChild(@bet_dialog)
        @money_text = new moneyText()
        @addChild(@money_text)
        @bet_text = new betText()
        @addChild(@bet_text)
        @heigh_bet_button = new heighBetButtonPause()
        @addChild(@heigh_bet_button)
        @low_bet_button = new lowBetButtonPause()
        @addChild(@low_bet_button)
        @y = -20
    statusDsp:()->
        @money_text.setValue()
        @money_text.setPositionPause()
        @bet_text.setValue()
        @bet_text.setPositionPause()
        @low_bet_button.setXposition()
        if game.fever is true
            @heigh_bet_button.opacity = 0
            @low_bet_button.opacity = 0
        else
            @heigh_bet_button.opacity = 1
            @low_bet_button.opacity = 1
    betSetting:(up)->
        if game.fever is false
            game.slot_setting.betChange(up)
            @bet_text.setValue()
            @bet_text.setPositionPause()
            @low_bet_button.setXposition()
class pauseMemberSetLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new memberSetDialogHtml()
        @close_button = new memberSetDialogCloseButton()
        @menu_title = new memberSetDiscription()
        @set_title = new useSetDiscription()
        @have_title = new useHaveDiscription()
        @auto_button = new autoMemberSetButtonHtml()
        @unset_button = new autoMemberUnsetButtonHtml()
        @set_title.y = 140
        @have_title.y = 320
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@menu_title)
        @addChild(@set_title)
        @addChild(@have_title)
        @addChild(@auto_button)
        @addChild(@unset_button)
        @member_list = {}
        @set_member_list = {}
        for i in [11..19]
            @member_list[i] = new useMemberHtml(i)
        for i in [1..game.max_set_member_num]
            @set_member_list[i] = new setMemberHtml(i)
            @addChild(@set_member_list[i])
        @setItemList()
        @dispSetMemberList()
    setItemList:()->
        for member_key, member_val of @member_list
            @addChild(member_val)
            member_val.setPosition()
    resetItemList:()->
        for member_key, member_val of @member_list
            if game.member_set_now.indexOf(parseInt(member_key)) != -1
                member_val.opacity = 0
                member_val.changeNotButton()
                member_val.is_exist = false
            else if game.item_have_now.indexOf(parseInt(member_key)) != -1
                member_val.opacity = 1
                member_val.removeDomClass('grayscale', true)
                member_val.changeIsButton()
                member_val.is_exist = true
            else
                member_val.opacity = 0.5
                member_val.addDomClass('grayscale', true)
                member_val.changeNotButton()
                member_val.is_exist = false
    #セットされている部員をレンダリングする
    dispSetMemberList:()->
        @resetItemList()
        now_nuse_set = false
        for member_key, member_val of @set_member_list
            member_val.setPosition()
            if game.member_set_now[member_key - 1] != undefined
                member_val.setItemKind(game.member_set_now[member_key - 1])
                member_val.opacity = 1
                member_val.disabled = false
            else
                if now_nuse_set is false and game.slot_setting.now_muse_num != 0
                    member_val.setItemKind(game.slot_setting.now_muse_num)
                    member_val.opacity = 0.5
                    member_val.disabled = true
                    member_val.changeNotButton()
                    now_nuse_set = true
                else
                    member_val.setItemKind(10)
                    member_val.opacity = 1
                    member_val.disabled = false

class pauseMemberUseSelectLayer extends appDomLayer
    constructor:()->
        super
        @dialog = new memberUseSelectDialogHtml()
        @cancel_button = new memberUseCancelButtonHtml()
        @set_button = new memberUseSetButtonHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@cancel_button)
        @addChild(@set_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @set_button.setText(kind)
        @item_kind = kind
        @item_options = game.slot_setting.item_list[kind]
        if @item_options is undefined
            @item_options = game.slot_setting.item_list[0]
        @item_name.setText(@item_options.name)
        @item_image.setImage(@item_options.image)
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        return text
    setMember:()->
        @_memberSet(@item_kind)
        game.pause_scene.pause_member_set_layer.dispSetMemberList()
        game.pause_scene.removeMemberUseSelectMenu()
    _memberSet:(kind)->
        if game.member_set_now.indexOf(parseInt(kind)) == -1
            if (game.max_set_member_num <= game.member_set_now.length)
                game.member_set_now.shift()
            game.member_set_now.push(kind)
        else
            game.member_set_now = game.arrayValueDel(game.member_set_now, kind)
class pauseRecordLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new recordDialogHtml()
        @close_button = new recordDialogCloseButton()
        @record_title = new recordDiscription()
        @trophy_title = new trophyDiscription()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @addChild(@record_title)
        @addChild(@trophy_title)
        @recordList = {}
        @trophyList = {}
        @bgmList = game.slot_setting.bgm_list
        @bgmList = game.slot_setting.bgm_list
        for kind, position in @bgmList
            @recordList[position] = new recordItemHtml(position, kind)
        for i in [21..24]
            @trophyList[i] = new trophyItemHtml(i - 21, i)
        @setRecordList()
        @resetRecordList()
        @setTrophyList()
        @resetTrophyList()
    setRecordList:()->
        for record_key, record_val of @recordList
            @addChild(record_val)
            record_val.setPosition()
    resetRecordList:()->
        for record_key, record_val of @recordList
            if game.prev_fever_muse.indexOf(parseInt(record_val.kind)) != -1
                record_val.opacity = 1
                #record_val.removeDomClass('grayscale', true)
            else
                record_val.opacity = 0.5
                #record_val.addDomClass('grayscale', true)
    setTrophyList:()->
        for trophy_key, trophy_val of @trophyList
            @addChild(trophy_val)
            trophy_val.setPosition()
    resetTrophyList:()->
        for trophy_key, trophy_val of @trophyList
            if game.item_have_now.indexOf(parseInt(trophy_val.kind)) != -1
                trophy_val.opacity = 1
                trophy_val.removeDomClass('grayscale', true)
                trophy_val.changeIsButton()
                trophy_val.is_exist = true
            else
                trophy_val.opacity = 0.5
                trophy_val.addDomClass('grayscale', true)
                trophy_val.changeNotButton()
                trophy_val.is_exist = false

class pauseBaseRecordSelectLayer extends appDomLayer
    constructor: ()->
        super
        @dialog = new recordSelectDialogHtml()
        @item_name = new itemNameDiscription()
        @item_image = new selectItemImage()
        @item_discription = new itemDiscription()

class pauseRecordSelectLayer extends pauseBaseRecordSelectLayer
    constructor: ()->
        super
        @ok_button = new recordOkButtonHtml()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@ok_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @item_options = game.slot_setting.muse_material_list[kind].bgm[0]
        @item_name.setText(@item_options.title)
        @item_image.setImage(@item_options.image)
        if game.prev_fever_muse.indexOf(parseInt(kind)) != -1
            @item_image.opacity = 1
            #@item_image.removeDomClass('grayscale', true)
            @item_name.setText(@item_options.title)
        else
            @item_image.opacity = 0.5
            #@item_image.addDomClass('grayscale', true)
            @item_name.setText('？？？')
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = 'ユニット：'+@item_options.unit
        return text

class pauseTrophySelectLayer extends pauseBaseRecordSelectLayer
    constructor: ()->
        super
        @ok_button = new trophyOkButtonHtml()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@ok_button)
        @addChild(@item_image)
        @addChild(@item_name)
        @addChild(@item_discription)
    setSelectItem:(kind)->
        @kind = kind
        @item_options = game.slot_setting.item_list[kind]
        @item_image.setImage(@item_options.image)
        @item_name.setText(@item_options.name)
        discription = @_setDiscription()
        @item_discription.setText(discription)
    _setDiscription:()->
        text = '効果：'+@item_options.discription
        text += '<br>値段：'+game.toJPUnit(@item_options.price)+'円'+'(所持金'+game.toJPUnit(game.money)+'円)'
        text += '<br>出現条件：'+@item_options.conditoin
        if @kind is 21 || @kind is 23
            text += '<br>(MAXコンボ'+game.max_combo+')'
        if @kind is 22
            text += '<br>('+game.countSoloMusic()+'曲達成済)'
        if @kind is 24
            text += '<br>('+game.countFullMusic()+'曲達成済)'
        return text
class pauseSaveConfirmLayer extends appDomLayer
    constructor:()->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @discription = new saveConfirmDiscription()
        @addChild(@discription)
        @ok_button = new saveConfirmOkButtonHtml()
        @addChild(@ok_button)
        @cancel_button = new saveConfirmCancelButtonHtml()
        @addChild(@cancel_button)

class pauseSaveLayer extends appDomLayer
    constructor: () ->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @discription = new saveEndDiscription()
        @addChild(@discription)
        @ok_button = new saveOkButtonHtml()
        @addChild(@ok_button)

class pauseTitleConfirmLayer extends appDomLayer
    constructor:()->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @discription = new titleConfirmDiscription()
        @addChild(@discription)
        @ok_button = new titleConfirmOkButtonHtml()
        @addChild(@ok_button)
        @cancel_button = new titleConfirmCancelButtonHtml()
        @addChild(@cancel_button)
class titleMainLayer extends appDomLayer
    constructor: () ->
        super
        @start_game_button = new startGameButtonHtml()
        @addChild(@start_game_button)
        @new_game_button = new newGameButtonHtml()
        @addChild(@new_game_button)

class catchAndSlotGame extends appGame
    constructor:(w, h)->
        super w, h

class LoveliveGame extends catchAndSlotGame
    constructor:()->
        super @width, @height
        @local_storage = window.localStorage
        @debug = new Debug()
        @slot_setting = new slotSetting()
        @test = new Test()
        @width = 480
        @height = 720
        if @debug.toubai
            @scale = 1
        else
            @scale = @getWindowScale()
        @fps = 24
        #画像リスト
        @imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira', 'big-kotori'
                    'heart', 'explosion', 'items', 'coin_pla']
        #音声リスト
        @soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear', 'explosion', 'bgm/bgm1']

        @keybind(90, 'z')
        @keybind(88, 'x')
        @keybind(67, 'c')
        @preloadAll()

        #ゲーム中どこからでもアクセスのある数値
        @money_init = 100 #ゲーム開始時の所持金
        @fever = false #trueならフィーバー中
        @fever_down_tension = 0
        @item_kind = 0 #落下アイテムの種類（フレーム）
        @fever_hit_eye = 0 #どの目で当たって今フィーバーになっているか
        @now_item = 0 #現在セット中のアイテム（１つめ）
        @already_added_material = [] #ゲームを開いてから現在までにロードしたμ’ｓの画像や楽曲の素材の番号
        @limit_set_item_num = 3
        @max_set_member_num = 3
        @next_auto_set_member = [] #ソロ楽曲全達成後にフィーバー後自動的に部員に設定されるリスト

        #セーブする変数(slot_settingにもあるので注意)
        @money = 0 #現在の所持金
        @bet = 1 #現在の掛け金
        @combo = 0 #現在のコンボ
        @max_combo = 0 #MAXコンボ
        @tension = 0 #現在のテンション(500がマックス)
        @item_point = 500 #アイテムのポイント（500がマックス）
        @past_fever_num = 0 #過去にフィーバーになった回数
        @next_add_member_key = 0 #メンバーがセットされている場合、次に挿入されるメンバーの配列のキー
        @max_set_item_num = 1 #アイテムスロットの最大数
        @item_have_now = [] #現在所持しているアイテム
        @item_set_now = [] #現在セットされているアイテム
        @member_set_now = [] #現在セットされているメンバー
        @prev_fever_muse = [] #過去にフィーバーになったμ’ｓメンバー（ユニット番号も含む）
        @prev_item = [] #前にセットしていたアイテム

        @init_load_val = {
            'money':100,
            'bet':1,
            'combo':0,
            'max_combo':0,
            'tension':0,
            'past_fever_num':0,
            'item_point':500,
            'next_add_member_key':0,
            'now_muse_num':0,
            'max_set_item_num':1,
            'item_have_now':[],
            'item_set_now':[],
            'member_set_now':[],
            'prev_fever_muse':[],
            'prev_item':[],
            'left_lille':@arrayCopy(@slot_setting.lille_array_0[0]),
            'middle_lille':@arrayCopy(@slot_setting.lille_array_0[1]),
            'right_lille':@arrayCopy(@slot_setting.lille_array_0[2])
        }

        @money = @money_init

    onload:() ->
        #テスト
        if @test.test_exe_flg is true
            @main_scene = new mainScene()
            @pause_scene = new pauseScene()
            @loadGame()
            @test_scene = new testScene()
            @pushScene(@test_scene)
            @test.testExe()
        else
            @title_scene = new titleScene()
            @pushScene(@title_scene)
            if @debug.force_main_flg is true
                @main_scene = new mainScene()
                @pause_scene = new pauseScene()
                @loadGame()
                @bgmPlayOnTension()
                @pushScene(@main_scene)
                if @debug.force_pause_flg is true
                    @setPauseScene()

    ###
    タイトルへ戻る
    ###
    returnToTitle:()->
        @popScene(@pause_scene)
        @popScene(@main_scene)

    ###
    続きからゲーム開始
    ###
    loadGameStart:()->
        @main_scene = new mainScene()
        @pause_scene = new pauseScene()
        @loadGame()
        @bgmPlayOnTension()
        @pushScene(@main_scene)

    ###
    最初からゲーム開始
    ###
    newGameStart:()->
        @main_scene = new mainScene()
        @pause_scene = new pauseScene()
        @_loadGameInit()
        @_gameInitSetting()
        @bgmPlayOnTension()
        @pushScene(@main_scene)

    bgmPlayOnTension:()->
        half = Math.floor(@slot_setting.tension_max / 2)
        if half <= @tension
            @bgmPlay(@main_scene.bgm, true)

    ###
    現在セットされているメンバーをもとに素材をロードします
    ###
    musePreLoadByMemberSetNow:()->
        roles = @getRoleByMemberSetNow()
        @musePreLoadMulti(roles)

    ###
    現在セットされているメンバーをもとに組み合わせ可能な役の一覧を全て取得します
    ###
    getRoleByMemberSetNow:()->
        max = @max_set_member_num
        roles = game.arrayCopy(@member_set_now)
        tmp = game.arrayCopy(@member_set_now)
        if @slot_setting.now_muse_num != 0 && @member_set_now.length != max
            roles.push(@slot_setting.now_muse_num)
            tmp.push(@slot_setting.now_muse_num)
        roles.push(@slot_setting.getHitRole(tmp[0], tmp[1], tmp[2]))
        roles.push(@slot_setting.getHitRole(tmp[1], tmp[1], tmp[2]))
        roles.push(@slot_setting.getHitRole(tmp[0], tmp[0], tmp[2]))
        roles.push(@slot_setting.getHitRole(tmp[0], tmp[0], tmp[1]))
        roles = @getDeduplicationList(roles)
        roles = @arrayValueDel(roles, 20)
        return roles

    ###
    配列で指定して複数のμ’ｓ素材を一括でロードします
    @param array nums 配列でロードする素材番号の指定
    ###
    musePreLoadMulti:(nums)->
        for key, val of nums
            if @already_added_material.indexOf(val) == -1
                @musePreLoad(val)


    ###
    スロットにμ’ｓを挿入するときに必要なカットイン画像や音楽を予めロードしておく
    @param number num ロードする素材番号の指定
    ###
    musePreLoad:(num = 0)->
        if num is 0
            muse_num = @slot_setting.now_muse_num
        else
            muse_num = num
        @already_added_material.push(muse_num)
        if @slot_setting.muse_material_list[muse_num] != undefined
            material = @slot_setting.muse_material_list[muse_num]
            if material['cut_in'] != undefined && material['cut_in'].length > 0
                for key, val of material['cut_in']
                    @appLoad('images/cut_in/'+val.name + '.png')
            if material['voice'] != undefined && material['voice'].length > 0
                for key, val of material['voice']
                    @appLoad('sounds/voice/'+val+'.mp3')
            if material['bgm'] != undefined && material['bgm'].length > 0
                @appLoad('sounds/bgm/'+material['bgm'][0]['name']+'.mp3')

    ###
    テンションゲージを増減する
    @param number val 増減値
    ###
    tensionSetValue:(val)->
        @slot_setting.changeLilleForTension(@tension, val)
        prev_tension = @tension
        @tension += val
        if @tension < 0
            @tension = 0
        else if @tension > @slot_setting.tension_max
            @tension = @slot_setting.tension_max
        @main_scene.gp_system.tension_gauge.setValue()
        @_bgmPlayStopOnTension(prev_tension)

    _bgmPlayStopOnTension:(prev_tension)->
        if @fever is false
            half = Math.floor(@slot_setting.tension_max / 2)
            if prev_tension < half && half <= @tension
                @bgmPlayOnTension()
            if @tension < half && half <= prev_tension
                @bgmStop(@main_scene.bgm)

    ###
    現在アイテムがセットされているかを確認する
    ###
    isItemSet:(kind)->
        rslt = false
        if game.item_set_now.indexOf(kind) != -1
            rslt = true
        return rslt

    ###
    現在アイテムを持っているかを確認する
    ###
    isItemHave:(kind)->
        rslt = false
        if game.item_have_now.indexOf(kind) != -1
            rslt = true
        return rslt

    ###
    アイテムの効果を発動する
    ###
    itemUseExe:()->
        if @isItemSet(4)
            @main_scene.gp_stage_front.player.setMxUp()
        else
            @main_scene.gp_stage_front.player.resetMxUp()
        if @isItemSet(3)
            @main_scene.gp_stage_front.player.setMyUp()
        else
            @main_scene.gp_stage_front.player.resetMyUp()

    ###
    アイテムスロットを表示する
    ###
    setItemSlot:()->
        if @isItemHave(22) && @isItemHave(23)
            @max_set_item_num = 3
        else if @isItemHave(22) || @isItemHave(23)
            @max_set_item_num = 2
        else
            @max_set_item_num = 1
        @main_scene.gp_system.itemDsp()
        @main_scene.gp_system.combo_text.setXposition()
        @slot_setting.setItemPointMax()

    countSoloMusic:()->
        cnt = 0
        for val in @prev_fever_muse
            if val < 20
                cnt += 1
        return cnt

    countFullMusic:()->
        return @prev_fever_muse.length

    ###
    フィーバー開始直前に自動的に次の部員を設定
    ソロ楽曲が全て出ないうちは設定しない
    先にメンバーだけ記憶しておいてあらかじめ素材をロードしておく
    フィーバー終了時にautoMemberSetAfeterFever()で実際に追加
    設定された部員は自動的に空にする
    ###
    autoMemberSetBeforeFever:()->
        if @arrIndexOf(@prev_fever_muse, [11,12,13,14,15,16,17,18,19])
            @member_set_now = []
            @next_auto_set_member = @slot_setting.getRoleAbleMemberList()
            @musePreLoadMulti(@next_auto_set_member)
            @pause_scene.pause_member_set_layer.dispSetMemberList()

    ###
    フィーバー終了直後にあらかじめロードしておいた次の部員を自動的に設定
    手動で設定された部員がいない時のみ実行
    ###
    autoMemberSetAfeterFever:()->
        if @next_auto_set_member.length != 0 && @member_set_now.length is 0
            @member_set_now = @next_auto_set_member
            @pause_scene.pause_member_set_layer.dispSetMemberList()

    ###
    アイテムを取った時にテンションゲージを増減する
    ###
    tensionSetValueItemCatch:()->
        val = @slot_setting.setTensionItemCatch()
        @tensionSetValue(val)
    ###
    アイテムを落とした時にテンションゲージを増減する
    ###
    tensionSetValueItemFall:()->
        val = @slot_setting.setTensionItemFall()
        @tensionSetValue(val)

    ###
    はずれのアイテムを取った時にテンションゲージを増減する
    ###
    tensionSetValueMissItemCatch:()->
        val = @slot_setting.setTensionMissItem()
        @tensionSetValue(val)

    ###
    スロットが当たった時にテンションゲージを増減する
    @param number hit_eye     当たった目の番号
    ###
    tensionSetValueSlotHit:(hit_eye)->
        val = @slot_setting.setTensionSlotHit(hit_eye)
        @tensionSetValue(val)
    ###
    ポーズシーンをセットする
    ###
    setPauseScene:()->
        @pause_scene.keyList.pause = true
        @pushScene(@pause_scene)
        @pause_scene.pause_item_buy_layer.resetItemList()
        @pause_scene.pause_main_layer.statusDsp()
        @nowPlayBgmPause()
    ###
    ポーズシーンをポップする
    ###
    popPauseScene:()->
        @pause_scene.buttonList.pause = false
        @main_scene.keyList.pause = true
        @main_scene.gp_system.bet_text.setValue()
        @popScene(@pause_scene)
        @nowPlayBgmRestart()

    ###
    ゲームをロードする
    ###
    loadGame:()->
        if @debug.test_load_flg is true
            @_loadGameTest()
        else if @debug.not_load_flg is true
            @_loadGameInit()
        else
            @_loadGameProduct()
        @_gameInitSetting()

    ###
    ロードするデータの空の値
    ###
    _defaultLoadData:(key)->
        data = {
            'money'    : 0,
            'bet'      : 0,
            'combo'    : 0,
            'max_combo': 0,
            'tension'  : 0,
            'past_fever_num' : 0,
            'item_point' : 0,
            'now_muse_num': 0,
            'next_add_member_key': 0,
            'left_lille': '[]',
            'middle_lille': '[]',
            'right_lille': '[]',
            'item_have_now':'[]',
            'item_set_now':'[]',
            'member_set_now':'[]',
            'prev_fever_muse':'[]',
            'max_set_item_num':0,
            'prev_item':'[]'
        }
        ret = null
        if data[key] is undefined
            console.error(key+'のデータのロードに失敗しました。')
        else
            ret = data[key]
        return ret

    ###
    ゲームをセーブする、ブラウザのローカルストレージへ
    ###
    saveGame:()->
        saveData = {
            'money'    : @money,
            'bet'      : @bet,
            'combo'    : @combo,
            'max_combo': @max_combo,
            'tension'  : @tension,
            'past_fever_num' : @past_fever_num,
            'item_point' : @item_point,
            'now_muse_num': @slot_setting.now_muse_num,
            'next_add_member_key': @next_add_member_key,
            'left_lille': JSON.stringify(@main_scene.gp_slot.left_lille.lilleArray),
            'middle_lille': JSON.stringify(@main_scene.gp_slot.middle_lille.lilleArray),
            'right_lille': JSON.stringify(@main_scene.gp_slot.right_lille.lilleArray),
            'item_have_now':JSON.stringify(@item_have_now),
            'item_set_now':JSON.stringify(@item_set_now),
            'member_set_now':JSON.stringify(@member_set_now),
            'prev_fever_muse':JSON.stringify(@prev_fever_muse),
            'max_set_item_num':@max_set_item_num,
            'prev_item':JSON.stringify(@prev_item)
        }
        for key, val of saveData
            @local_storage.setItem(key, val)

    ###
    ゲームのロード本番用、ブラウザのローカルストレージから
    ###
    _loadGameProduct:()->
        money = @local_storage.getItem('money')
        if money != null
            @money = parseInt(money)
            @bet = @_loadStorage('bet', 'num')
            @combo = @_loadStorage('combo', 'num')
            @max_combo = @_loadStorage('max_combo', 'num')
            @tension = @_loadStorage('tension', 'num')
            @past_fever_num = @_loadStorage('past_fever_num', 'num')
            @item_point = @_loadStorage('item_point', 'num')
            @next_add_member_key = @_loadStorage('next_add_member_key', 'num')
            @slot_setting.now_muse_num = @_loadStorage('now_muse_num', 'num')
            @main_scene.gp_slot.left_lille.lilleArray = @_loadStorage('left_lille', 'json')
            @main_scene.gp_slot.middle_lille.lilleArray = @_loadStorage('middle_lille', 'json')
            @main_scene.gp_slot.right_lille.lilleArray = @_loadStorage('right_lille', 'json')
            @item_have_now = @_loadStorage('item_have_now', 'json')
            @item_set_now = @_loadStorage('item_set_now', 'json')
            @member_set_now = @_loadStorage('member_set_now', 'json')
            @prev_fever_muse = @_loadStorage('prev_fever_muse', 'json')
            @max_set_item_num = @_loadStorage('max_set_item_num', 'num')
            @prev_item = @_loadStorage('prev_item', 'json')
    ###
    ローカルストレージから指定のキーの値を取り出して返す
    @param string key ロードするデータのキー
    @param string type ロードするデータのタイプ（型） num json
    ###
    _loadStorage:(key, type)->
        ret = null
        val = @local_storage.getItem(key)
        if val is undefined || val is null
            ret = @_defaultLoadData(key)
        else
            switch type
                when 'num' then ret = parseInt(val)
                when 'json' then ret = JSON.parse(val)
                else ret = val
        return ret

    ###
    ゲームのロードテスト用、デバッグの決まった値
    ###
    _loadGameTest:()->
        load_val = @debug.test_load_val
        load_val.left_lille = @arrayCopy(@slot_setting.lille_array_0[0])
        load_val.middle_lille = @arrayCopy(@slot_setting.lille_array_0[1])
        load_val.right_lille = @arrayCopy(@slot_setting.lille_array_0[2])
        @_loadGameFix(load_val)

    ###
    ゲームのロード、新規ゲーム用
    ###
    _loadGameInit:()->
        @_loadGameFix(@init_load_val)

    ###
    ゲームのロード、固定値をロードする
    ###
    _loadGameFix:(data)->
        @money = @_loadGameFixUnit(data, 'money')
        @bet = @_loadGameFixUnit(data, 'bet')
        @combo = @_loadGameFixUnit(data, 'combo')
        @max_combo = @_loadGameFixUnit(data, 'max_combo')
        @tension = @_loadGameFixUnit(data, 'tension')
        @past_fever_num = @_loadGameFixUnit(data, 'past_fever_num')
        @item_point = @_loadGameFixUnit(data, 'item_point')
        @next_add_member_key = @_loadGameFixUnit(data, 'next_add_member_key')
        @slot_setting.now_muse_num = @_loadGameFixUnit(data, 'now_muse_num')
        @item_have_now = @_loadGameFixUnit(data, 'item_have_now')
        @item_set_now = @_loadGameFixUnit(data, 'item_set_now')
        @prev_fever_muse = @_loadGameFixUnit(data, 'prev_fever_muse')
        @member_set_now = @_loadGameFixUnit(data, 'member_set_now')
        @max_set_item_num = @_loadGameFixUnit(data, 'max_set_item_num')
        @slot_setting.now_muse_num = @_loadGameFixUnit(data, 'now_muse_num')
        @main_scene.gp_slot.left_lille.lilleArray = @_loadGameFixUnit(data, 'left_lille')
        @main_scene.gp_slot.middle_lille.lilleArray = @_loadGameFixUnit(data, 'middle_lille')
        @main_scene.gp_slot.right_lille.lilleArray = @_loadGameFixUnit(data, 'right_lille')
        @prev_item = @_loadGameFixUnit(data, 'prev_item')

    _loadGameFixUnit:(data, key)->
        if data[key] != undefined
            ret = data[key]
        else
            ret = @_defaultLoadData(key)
        return ret

    ###
    ゲームロード後の画面表示等の初期値設定
    ###
    _gameInitSetting:()->
        #一人目のμ’ｓメンバーを決めて素材をロードする
        if @slot_setting.now_muse_num is 0
            @slot_setting.setMuseMember()
        @musePreLoad()
        sys = @main_scene.gp_system
        sys.money_text.setValue()
        sys.bet_text.setValue()
        sys.combo_text.setValue()
        sys.combo_text.setXposition()
        sys.tension_gauge.setValue()
        sys.itemDsp()
        @pause_scene.pause_item_buy_layer.resetItemList()
        @pause_scene.pause_item_use_layer.dspSetItemList()
        @pause_scene.pause_member_set_layer.dispSetMemberList()
        @pause_scene.pause_record_layer.resetRecordList()
        @pause_scene.pause_record_layer.resetTrophyList()
        @slot_setting.setMemberItemPrice()
        @slot_setting.setItemPointMax()
        @slot_setting.setItemDecreasePoint()
        @musePreLoadByMemberSetNow()
        @itemUseExe()
        @main_scene.gp_system.whiteOut()
class gpEffect extends appGroup
    constructor: () ->
        super
        @chance_effect = new chanceEffect()
        @fever_effect = new feverEffect()
        @fever_overlay = new feverOverlay()
        @kirakira_effect = []
        @kirakira_num = 40
        @item_catch_effect = []

    cutInSet:(num = 0)->
        setting = game.slot_setting
        if setting.muse_material_list[setting.add_muse_num] != undefined
            @cut_in = new cutIn(num)
            @addChild(@cut_in)
            game.main_scene.gp_stage_front.missItemFallSycleNow = 0
    chanceEffectSet:()->
        @addChild(@chance_effect)
        @chance_effect.setInit()

    feverEffectSet:()->
        @addChild(@fever_effect)
        @addChild(@fever_overlay)
        @fever_overlay.setInit()
        @_setKirakiraEffect()

    feverEffectEnd:()->
        @removeChild(@fever_effect)
        @removeChild(@fever_overlay)
        @_endKirakiraEffect()

    _setKirakiraEffect:()->
        for i in [1..@kirakira_num]
            @kirakira_effect.push(new kirakiraEffect())
            @addChild(@kirakira_effect[i-1])

    _endKirakiraEffect:()->
        for i in [1..@kirakira_num]
            @removeChild(@kirakira_effect[i-1])

    setItemChatchEffect:(x, y)->
        @item_catch_effect = []
        for i in [1..4]
            @item_catch_effect.push(new itemCatchEffect(i, x, y))
            @addChild(@item_catch_effect[i-1])
class gpPanorama extends appGroup
    constructor:()->
        super

class gpBackPanorama extends gpPanorama
    constructor: () ->
        super
        @back_panorama = new BackPanorama()
        @big_kotori = new bigKotori()
        @now_back_effect_flg = false #背景レイヤーのエフェクトを表示中ならtrue
        @back_effect_rate = 200 #背景レイヤーのエフェクトが表示される確率
        @addChild(@back_panorama)
    ###
    背景レイヤーのエフェクト表示を開始
    ###
    setBackEffect:()->
        if game.fever is false && @now_back_effect_flg is false
            random = Math.floor(Math.random() * @back_effect_rate)
            if random is 1
                @_setBigKotori()
    ###
    進撃のことりを設置
    ###
    _setBigKotori:()->
        @big_kotori.setInit()
        @addChild(@big_kotori)
        @now_back_effect_flg = true
    ###
    進撃のことりを終了
    ###
    endBigKotori:()->
        @removeChild(@big_kotori)
        @now_back_effect_flg = false

class gpFrontPanorama extends gpPanorama
    constructor:()->
        super
        @front_panorama = new FrontPanorama()
        @addChild(@front_panorama)
class gpSlot extends appGroup
    constructor: () ->
        super
        @underFrame = new UnderFrame()
        @addChild(@underFrame)
        @lille_stop_se = game.soundload('dicision')
        @slot_hit_se = game.soundload('start')
        @fever_bgm = game.soundload('bgm/zenkai_no_lovelive')
        @isStopping = false #スロット停止中
        @stopIntervalFrame = 9 #スロットが連続で止まる間隔（フレーム）
        @slotIntervalFrameRandom = 0
        @stopStartAge = 0 #スロットの停止が開始したフレーム
        @leftSlotEye = 0 #左のスロットが当たった目
        @feverSec = 0 #フィーバーの時間
        @hit_role = 0 #スロットが揃った目の役
        @isForceSlotHit = false
        @slotSet()
        @debugSlot()
        @upperFrame = new UpperFrame()
        @addChild(@upperFrame)
    onenterframe: (e) ->
        @slotStopping()

    ###
    スロットが一定の時間差で連続で停止する
    ###
    slotStopping: ()->
        if @isStopping is true
            if @age is @stopStartAge
                @forceHitStart()
                game.sePlay(@lille_stop_se)
                @left_lille.isRotation = false
                @forceHitLeftLille()
                @saveLeftSlotEye()
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame + @slotIntervalFrameRandom
                game.sePlay(@lille_stop_se)
                @middle_lille.isRotation = false
                @forceHit(@middle_lille)
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame * 2 + @slotIntervalFrameRandom
                game.sePlay(@lille_stop_se)
                @right_lille.isRotation = false
                @forceHit(@right_lille)
                @forceHitEnd()
                @isStopping = false
                @slotHitTest()

    ###
    左のスロットが当たった目を記憶する
    ###
    saveLeftSlotEye:()->
        @leftSlotEye = @left_lille.lilleArray[@left_lille.nowEye]

    forceHitStart:()->
        if game.slot_setting.isForceSlotHit is true
            @isForceSlotHit = true

    forceHitEnd:()->
        @isForceSlotHit = false

    ###
    確率でスロットを強制的に当たりにする
    ###
    forceHit:(target)->
        if @isForceSlotHit is true
            tmp_eye = @_searchEye(target)
            if tmp_eye != 0
                target.nowEye = tmp_eye
                target.frameChange()

    ###
    確率で左のスロットを強制的にμ'sにする
    ###
    forceHitLeftLille:()->
        target = @left_lille
        if @isForceSlotHit is true && game.slot_setting.isForceFever() is true
            tmp_eye = @_searchMuseEye(target)
            if tmp_eye != 0
                target.nowEye = tmp_eye
                target.frameChange()

    ###
    スロットが強制的に当たりになるようにリールから左のリールの当たり目と同じ目を探して配列のキーを返す
    左の当たり目がμ’ｓならリールからμ’ｓの目をランダムで取り出して返す
    ###
    _searchEye:(target)->
        result = 0
        if @leftSlotEye < 10
            for key, val of target.lilleArray
                if val is @leftSlotEye
                    result = key
        else
            result = @_searchMuseEye(target)
        return result

    ###
    リールからμ'sを探してきてそのキーを返します
    リールにμ'sがいなければランダムでキーを返します
    @pram target
    ###
    _searchMuseEye:(target)->
        arr = []
        for key, val of target.lilleArray
            if val > 10
                arr.push(key)
        if arr.length > 0
            random_key = Math.floor(arr.length * Math.random())
            result = arr[random_key]
        else
            result = Math.floor(@left_lille.lilleArray.length * Math.random())
        return result


    ###
    スロットの当選判定をして当たった時の処理を流す
    ###
    slotHitTest: () ->
        if @_isSlotHit() is true
            game.sePlay(@slot_hit_se)
            prize_money = game.slot_setting.calcPrizeMoney(@middle_lille.lilleArray[@middle_lille.nowEye])
            game.tensionSetValueSlotHit(@hit_role)
            @_feverStart(@hit_role)
            if @hit_role is 1
                member = game.slot_setting.getAddMuseNum()
                @slotAddMuse(member)
            else
                game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            if game.slot_setting.isForceSlotHit is true
                @endForceSlotHit()

    ###
    スロットの当選判定をする
    true:３つとも全て同じ目、または、３つとも全てμ’s
    ###
    _isSlotHit:()->
        left = @left_lille.lilleArray[@left_lille.nowEye]
        middle = @middle_lille.lilleArray[@middle_lille.nowEye]
        right = @right_lille.lilleArray[@right_lille.nowEye]
        hit_flg = false
        if left is middle is right
            hit_flg = true
            @hit_role = left
        else if left > 10 && middle > 10 && right > 10
            hit_flg = true
            @hit_role = game.slot_setting.getHitRole(left, middle, right)
        return hit_flg

    ###
    フィーバーを開始する
    ###
    _feverStart:(hit_eye)->
        if game.fever is false
            if (11 <= hit_eye && hit_eye <= 19) || (21 <= hit_eye)
                if game.prev_fever_muse.indexOf(parseInt(hit_eye)) is -1
                    game.prev_fever_muse.push(@hit_role)
                    game.pause_scene.pause_record_layer.resetRecordList()
                    game.pause_scene.pause_main_layer.save_game_button.makeDisable()
                    game.slot_setting.setMemberItemPrice()
                    game.tensionSetValue(game.slot_setting.tension_max)
                    game.fever = true
                    game.past_fever_num += 1
                    game.slot_setting.setMuseMember()
                    game.musePreLoad()
                    game.autoMemberSetBeforeFever()
                    game.fever_hit_eye = hit_eye
                    game.main_scene.gp_system.changeBetChangeFlg(false)
                    game.main_scene.gp_effect.feverEffectSet()
                    @slotAddMuseAll(hit_eye)
                    @_feverBgmStart(hit_eye)

    ###
    フィーバー中のBGMを開始する
    ###
    _feverBgmStart:(hit_eye)->
        bgm = @_getFeverBgm(hit_eye)
        @feverSec = bgm['time']
        @fever_bgm = game.soundload('bgm/'+bgm['name'])
        game.fever_down_tension = Math.round(game.slot_setting.tension_max * 100 / (@feverSec * game.fps)) / 100
        game.fever_down_tension *= -1
        game.bgmStop(game.main_scene.bgm)
        game.bgmPlay(@fever_bgm, false)

    ###
    揃った目の役からフィーバーのBGMを返す
    ###
    _getFeverBgm:(hit_role)->
        material = game.slot_setting.muse_material_list
        if material[hit_role] is undefined
            hit_role = 20
        bgms = material[hit_role]['bgm']
        random = Math.floor(Math.random() * bgms.length)
        return bgms[random]

    ###
    スロットマシンを画面に設置する
    ###
    slotSet: () ->
        @left_lille = new LeftLille()
        @addChild(@left_lille)
        @middle_lille = new MiddleLille()
        @addChild(@middle_lille)
        @right_lille = new RightLille()
        @addChild(@right_lille)

    ###
    リールを指定のリールに変更する
    @param array   lille     リール
    @param boolean isMuseDel μ’sは削除する
    ###
    slotLilleChange:(lille, isMuseDel)->
        @left_lille.lilleArray = @_slotLilleChangeUnit(@left_lille, lille[0], isMuseDel)
        @middle_lille.lilleArray = @_slotLilleChangeUnit(@middle_lille, lille[1], isMuseDel)
        @right_lille.lilleArray = @_slotLilleChangeUnit(@right_lille, lille[2], isMuseDel)

    ###
    リールを指定のリールに変更する（単体）
    リールにμ’sの誰かがいればそのまま残す
    @param array target 変更対象
    @param array change 変更後
    @param boolean isMuseDel μ’sは削除する
    ###
    _slotLilleChangeUnit:(target, change, isMuseDel)->
        arr = []
        return_arr = []
        return_arr = game.arrayCopy(change)
        if isMuseDel is false
            for key, val of target.lilleArray
                if val > 10
                    arr.push(key)
            if arr.length > 0
                for arr_key, arr_val of arr
                    return_arr[arr_val] = target.lilleArray[arr_val]
        return return_arr


    ###
    リールの音ノ木坂学院校章のどこかにμ’sの誰かを挿入
    スロットが音ノ木坂学院校章で止まったときに実行
    @param number num メンバーの指定
    ###
    slotAddMuse:(num)->
        if 11 <= num && num <= 19
            @left_lille.lilleArray = @_slotAddMuseUnit(num, @left_lille)
            @middle_lille.lilleArray = @_slotAddMuseUnit(num, @middle_lille)
            @right_lille.lilleArray = @_slotAddMuseUnit(num, @right_lille)
            game.main_scene.gp_effect.cutInSet(num)

    ###
    リールにμ’sの誰かを挿入(単体)
    @param number num   メンバーの指定
    @param array  lille リール
    ###
    _slotAddMuseUnit:(num, lille)->
        arr = []
        for key, val of lille.lilleArray
            if val is 1
                arr.push(key)
        if arr.length > 0
            random_key = Math.floor(arr.length * Math.random())
            add_num = arr[random_key]
            lille.lilleArray[add_num] = num
        return lille.lilleArray

    ###
    リールの音ノ木坂学院校章の全てにμ’sの誰かを挿入
    フィーバー開始時に実行
    @param number num メンバーの指定
    ###
    slotAddMuseAll:(num)->
        @left_lille.lilleArray = @_slotAddMuseAllUnit(@left_lille.lilleArray[@left_lille.nowEye], @left_lille)
        @middle_lille.lilleArray = @_slotAddMuseAllUnit(@middle_lille.lilleArray[@middle_lille.nowEye], @middle_lille)
        @right_lille.lilleArray = @_slotAddMuseAllUnit(@right_lille.lilleArray[@right_lille.nowEye], @right_lille)

    _slotAddMuseAllUnit:(num, lille)->
        for key, val of lille.lilleArray
            if val is 1
                lille.lilleArray[key] = num
        return lille.lilleArray

    ###
    スロットマシンの回転を始める
    ###
    slotStart: () ->
        @left_lille.isRotation = true
        @middle_lille.isRotation = true
        @right_lille.isRotation = true

    ###
    スロットマシンの回転を止める
    ###
    slotStop:() ->
        @stopStartAge = @age
        @isStopping = true
        @setIntervalFrame()
        @slotStopping()

    ###
    スロットマシン止まる間隔を決める
    ###
    setIntervalFrame:() ->
        @slotIntervalFrameRandom = Math.floor(Math.random() * 3)

    ###
    デバッグ用スロットにすりかえる
    ###
    debugSlot:() ->
        if game.debug.lille_flg is true
            @left_lille.lilleArray = game.arrayCopy(game.debug.lille_array[0])
            @middle_lille.lilleArray = game.arrayCopy(game.debug.lille_array[1])
            @right_lille.lilleArray = game.arrayCopy(game.debug.lille_array[2])

    ###
    スロットの強制当たりを開始する
    ###
    startForceSlotHit:()->
        @upperFrame.frame = 1
        game.main_scene.gp_system.changeBetChangeFlg(false)
        if game.fever is false
            game.main_scene.gp_effect.chanceEffectSet()

    ###
    スロットの強制当たりを終了する
    ###
    endForceSlotHit:()->
        if game.fever is false && game.slot_setting.isForceSlotHit is true
            @upperFrame.frame = 0
            game.main_scene.gp_system.changeBetChangeFlg(true)
            game.slot_setting.isForceSlotHit = false
class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 640 #床の位置

###
ステージ前面
プレイヤーや落下アイテムがある
###
class stageFront extends gpStage
    constructor: () ->
        super
        @itemFallSec = 5 #アイテムを降らせる周期（秒）
        @itemFallSecInit = 5
        @itemFallFrm = 0 #アイテムを降らせる周期（フレーム）
        @catchItems = [] #キャッチアイテムのインスタンスを格納
        @nowCatchItemsNum = 0
        @missItemFallSycle = 4 #ハズレアイテムを取る周期
        @missItemFallSycleNow = 0
        @catchMissItems = []
        @nowCatchMissItemsNum = 0
        @item_fall_se = game.soundload('dicision')
        @miss_fall_se = game.soundload('cancel')
        @explotion_effect = new explosionEffect()
        @initial()
    initial:()->
        @setPlayer()
        @setItemFallSecInit()
    onenterframe: () ->
        @_stageCycle()
    setPlayer:()->
        @player = new Bear()
        @player.y = @floor
        @addChild(@player)
    ###
    アイテムを降らせる間隔を初期化
    ###
    setItemFallSecInit:()->
        if game.debug.item_fall_early_flg is true
            @itemFallSecInit = 3
        @setItemFallFrm(@itemFallSecInit)
    ###
    アイテムを降らせる間隔（フレーム）を設定、再設定
    ###
    setItemFallFrm:(sec)->
        @itemFallSec = sec
        @itemFallFrm = game.fps * sec
        @age = 0
    ###
    一定周期でステージに発生するイベント
    ###
    _stageCycle:()->
        if @age % @itemFallFrm is 0
            @_catchFall()
            @missItemFallSycleNow += 1
            game.main_scene.gp_stage_back.returnMoneyFallStart()
            game.main_scene.gp_back_panorama.setBackEffect()
            if @itemFallSec != @itemFallSecInit
                @setItemFallFrm(@itemFallSecInit)
        if @missItemFallSycleNow is @missItemFallSycle && @age % @itemFallFrm is @itemFallFrm / 2
            if game.isItemSet(1) is false && game.fever is false
                @_missCatchFall()
            @missItemFallSycleNow = 0

    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        if game.bet > game.money
            game.bet = game.slot_setting.betDown()
            game.main_scene.gp_system.bet_text.setValue()
        if 0 < game.money
            game.money -= game.bet
        @catchItems.push(new MacaroonCatch())
        @addChild(@catchItems[@nowCatchItemsNum])
        game.sePlay(@item_fall_se)
        @catchItems[@nowCatchItemsNum].setPosition()
        @nowCatchItemsNum += 1
        game.main_scene.gp_system.money_text.setValue()
        game.main_scene.gp_slot.slotStart()
        if game.slot_setting.getIsForceSlotHit() is true
            game.main_scene.gp_slot.startForceSlotHit()
        else
            game.main_scene.gp_slot.endForceSlotHit()

    _missCatchFall:()->
        if game.money >= game.bet
            @catchMissItems.push(new OnionCatch())
            @addChild(@catchMissItems[@nowCatchMissItemsNum])
            game.sePlay(@miss_fall_se)
            @catchMissItems[@nowCatchMissItemsNum].setPosition()
            @nowCatchMissItemsNum += 1

    setExplosionEffect:(x, y)->
        @addChild(@explotion_effect)
        @explotion_effect.setInit(x, y)


###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsInstance = [] #スロット当選金のインスタンスを格納
        @prizeMoneyItemsNum = {1:0,10:0,100:0,1000:0,10000:0,100000:0,1000000:0,10000000:0,100000000:0,1000000000:0,10000000000:0,100000000000:0} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 4 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
        @oneSetMoney = 1 #1フレームに設置するコインの数

        @returnMoneyItemsInstance = [] #掛け金の戻り分のインスタンスを格納
        @returnMoneyItemsNum = {1:0,10:0,100:0,1000:0,10000:0,100000:0,1000000:0,10000000:0,100000000:0,1000000000:0,10000000000:0,100000000000:0} #掛け金の戻り分を降らせる各コイン数の内訳
        @nowReturnMoneyItemsNum = 0
        @returnMoneyFallIntervalFrm = 4 #掛け金の戻り分を降らせる間隔（フレーム）
    onenterframe: () ->
        @_moneyFall()
        @_returnMoneyFall()
    ###
    スロットの当選金を降らせる
    @param value number 金額
    ###
    fallPrizeMoneyStart:(value) ->
        stage = game.main_scene.gp_stage_front
        if value < 1000000000000
            @prizeMoneyFallIntervalFrm = 4
        else if value < 10000000000000
            @prizeMoneyFallIntervalFrm = 2
        else
            @prizeMoneyFallIntervalFrm = 1
        @prizeMoneyItemsNum = @_calcMoneyItemsNum(value, true)
        @prizeMoneyItemsInstance = @_setMoneyItemsInstance(@prizeMoneyItemsNum, true)
        if @prizeMoneyItemsNum[100000000000] > 1000
            @oneSetMoney = Math.floor(@prizeMoneyItemsNum[100000000000] / 1000)
        @prizeMoneyFallPeriodSec = Math.ceil((@prizeMoneyItemsInstance.length / @oneSetMoney) * @prizeMoneyFallIntervalFrm / game.fps) + stage.itemFallSecInit
        if @prizeMoneyFallPeriodSec > stage.itemFallSecInit
            stage.setItemFallFrm(@prizeMoneyFallPeriodSec)
        @isFallPrizeMoney = true

    ###
    スロットの当選金を降らせる
    ###
    _moneyFall:()->
        if @isFallPrizeMoney is true && @age % @prizeMoneyFallIntervalFrm is 0
            for i in [1..@oneSetMoney]
                # TODO バグあり
                if @prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum] != undefined
                    @addChild(@prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum])
                    @prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum].setPosition()
                    @nowPrizeMoneyItemsNum += 1
                    if @nowPrizeMoneyItemsNum is @prizeMoneyItemsInstance.length
                        @nowPrizeMoneyItemsNum = 0
                        @isFallPrizeMoney = false
    ###
    当選金の内訳のコイン枚数を計算する
    @param value   number 金額
    @prize boolean true:当選金額
    ###
    _calcMoneyItemsNum:(value, prize)->
        ret_data = {1:0,10:0,100:0,1000:0,10000:0,100000:0,1000000:0,10000000:0,100000000:0,1000000000:0,10000000000:0,100000000000:0}
        if value <= 20 #全部1円
            ret_data[1] = value
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100 #1円と10円と端数
            ret_data[1] = game.getDigitNum(value, 1) + 10
            ret_data[10] = game.getDigitNum(value, 2) - 1
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 1000 #10円と100円と端数
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2) + 10
            ret_data[100] = game.getDigitNum(value, 3) - 1
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 10000 #1000円と100円と端数
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3) + 10
            ret_data[1000] = game.getDigitNum(value, 4) - 1
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100000
            ret_data[1] = 0
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3)
            ret_data[1000] = game.getDigitNum(value, 4) + 10
            ret_data[10000] = game.getDigitNum(value, 5) - 1
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 1000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = game.getDigitNum(value, 3)
            ret_data[1000] = game.getDigitNum(value, 4)
            ret_data[10000] = game.getDigitNum(value, 5) + 10
            ret_data[100000] = game.getDigitNum(value, 6) - 1
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 10000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = game.getDigitNum(value, 4)
            ret_data[10000] = game.getDigitNum(value, 5)
            ret_data[100000] = game.getDigitNum(value, 6) + 10
            ret_data[1000000] = game.getDigitNum(value, 7) - 1
            ret_data[10000000] = 0
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = game.getDigitNum(value, 5)
            ret_data[100000] = game.getDigitNum(value, 6)
            ret_data[1000000] = game.getDigitNum(value, 7) + 10
            ret_data[10000000] = game.getDigitNum(value, 8) - 1
            ret_data[100000000] = 0
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 1000000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = game.getDigitNum(value, 6)
            ret_data[1000000] = game.getDigitNum(value, 7)
            ret_data[10000000] = game.getDigitNum(value, 8) + 10
            ret_data[100000000] = game.getDigitNum(value, 9) - 1
            ret_data[1000000000] = 0
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 10000000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = game.getDigitNum(value, 7)
            ret_data[10000000] = game.getDigitNum(value, 8)
            ret_data[100000000] = game.getDigitNum(value, 9) + 10
            ret_data[1000000000] = game.getDigitNum(value, 10) - 1
            ret_data[10000000000] = 0
            ret_data[100000000000] = 0
        else if value < 100000000000
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = game.getDigitNum(value, 8)
            ret_data[100000000] = game.getDigitNum(value, 9)
            ret_data[1000000000] = game.getDigitNum(value, 10) + 10
            ret_data[10000000000] = game.getDigitNum(value, 11) - 1
            ret_data[100000000000] = 0
        else
            ret_data[1] = 0
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
            ret_data[1000000] = 0
            ret_data[10000000] = 0
            ret_data[100000000] = game.getDigitNum(value, 9)
            ret_data[1000000000] = game.getDigitNum(value, 10)
            ret_data[10000000000] = game.getDigitNum(value, 11) + 10
            ret_data[100000000000] = Math.floor(value/100000000000)
        return ret_data

    ###
    当選金コインのインスタンスを設置
    @param number  itemsNum コイン数の内訳
    @param boolean isHoming trueならコインがホーミングする
    @return array
    ###
    _setMoneyItemsInstance:(itemsNum, isHoming)->
        ret_data = []
        if itemsNum[1] > 0
            for i in [1..itemsNum[1]]
                ret_data.push(new OneMoney(isHoming))
        if itemsNum[10] > 0
            for i in [1..itemsNum[10]]
                ret_data.push(new TenMoney(isHoming))
        if itemsNum[100] > 0
            for i in [1..itemsNum[100]]
                ret_data.push(new HundredMoney(isHoming))
        if itemsNum[1000] > 0
            for i in [1..itemsNum[1000]]
                ret_data.push(new ThousandMoney(isHoming))
        if itemsNum[10000] > 0
            for i in [1..itemsNum[10000]]
                ret_data.push(new TenThousandMoney(isHoming))
        if itemsNum[100000] > 0
            for i in [1..itemsNum[100000]]
                ret_data.push(new HundredThousandMoney(isHoming))
        if itemsNum[1000000] > 0
            for i in [1..itemsNum[1000000]]
                ret_data.push(new OneMillionMoney(isHoming))
        if itemsNum[10000000] > 0
            for i in [1..itemsNum[10000000]]
                ret_data.push(new TenMillionMoney(isHoming))
        if itemsNum[100000000] > 0
            for i in [1..itemsNum[100000000]]
                ret_data.push(new OneHundredMillionMoney(isHoming))
        if itemsNum[1000000000] > 0
            for i in [1..itemsNum[1000000000]]
                ret_data.push(new BillionMoney(isHoming))
        if itemsNum[10000000000] > 0
            for i in [1..itemsNum[10000000000]]
                ret_data.push(new TenBillionMoney(isHoming))
        if itemsNum[100000000000] > 0
            for i in [1..itemsNum[100000000000]]
                ret_data.push(new OneHundredBillionMoney(isHoming))
        return ret_data

    ###
    掛け金の戻り分を降らせる、開始
    ###
    returnMoneyFallStart:()->
        val = game.slot_setting.getReturnMoneyFallValue()
        if val < 10
        else if val < 100
            val = Math.floor(val / 10) * 10
        else if val < 1000
            val = Math.floor(val / 100) * 100
        else if val < 10000
            val = Math.floor(val / 1000) * 1000
        else if val < 100000
            val = Math.floor(val / 10000) * 10000
        else if val < 1000000
            val = Math.floor(val / 100000) * 100000
        else if val < 10000000
            val = Math.floor(val / 1000000) * 1000000
        else if val < 100000000
            val = Math.floor(val / 10000000) * 10000000
        else if val < 1000000000
            val = Math.floor(val / 100000000) * 100000000
        else if val < 10000000000
            val = Math.floor(val / 1000000000) * 1000000000
        else if val < 100000000000
            val = Math.floor(val / 10000000000) * 10000000000
        else
            val = Math.floor(val / 100000000000) * 100000000000
        @returnMoneyItemsNum = @_calcMoneyItemsNum(val, false)
        @returnMoneyItemsInstance = @_setMoneyItemsInstance(@returnMoneyItemsNum, false)
        stage = game.main_scene.gp_stage_front
        @returnMoneyFallIntervalFrm = Math.round(stage.itemFallSecInit * game.fps / @returnMoneyItemsInstance.length)
        @nowReturnMoneyItemsNum = 0

    ###
    掛け金の戻り分を降らせる
    ###
    _returnMoneyFall:()->
        if @isFallPrizeMoney is false && @returnMoneyItemsInstance.length > 0 && @age % @returnMoneyFallIntervalFrm is 0
            if @nowReturnMoneyItemsNum is @returnMoneyItemsInstance.length
                @returnMoneyItemsInstance = []
                @nowReturnMoneyItemsNum = 0
            else
                @addChild(@returnMoneyItemsInstance[@nowReturnMoneyItemsNum])
                @returnMoneyItemsInstance[@nowReturnMoneyItemsNum].setPosition()
                @nowReturnMoneyItemsNum += 1
class gpSystem extends appGroup
    constructor: () ->
        super
        @paermit_bet_change_flg = true
        @money_text = new moneyText()
        @addChild(@money_text)
        @bet_text = new betText()
        @addChild(@bet_text)
        @combo_unit_text = new comboUnitText()
        @addChild(@combo_unit_text)
        @combo_text = new comboText()
        @addChild(@combo_text)
        @tension_gauge_back = new TensionGaugeBack()
        @addChild(@tension_gauge_back)
        @tension_gauge = new TensionGauge()
        @addChild(@tension_gauge)
        @pause_button = new pauseButton()
        @addChild(@pause_button)
        @item_slot = {}
        for i in [1..game.limit_set_item_num]
            @item_slot[i] = new ItemSlot(i)
            @addChild(@item_slot[i])
            @item_slot[i].setPositoin(i)
        @item_gauge_back = new ItemGaugeBack()
        @addChild(@item_gauge_back)
        @item_gauge = new ItemGauge()
        @addChild(@item_gauge)
        @left_button = new leftButton()
        @addChild(@left_button)
        @right_button = new rightButton()
        @addChild(@right_button)
        @jump_button = new jumpButton()
        @addChild(@jump_button)
        @heigh_bet_button = new heighBetButton()
        @addChild(@heigh_bet_button)
        @low_bet_button = new lowBetButton()
        @addChild(@low_bet_button)
        @white_back = new whiteBack()
        if game.isSumaho()
            @large_jump_button = new largeJumpButton()
            @addChild(@large_jump_button)
            @large_left_button = new largeLeftButton()
            @addChild(@large_left_button)
            @large_right_button = new largeRightButton()
            @addChild(@large_right_button)
        @keyList = {'up':false, 'down':false}
        @isWhiteBack = false
    onenterframe: (e) ->
        @_betSetting()
        @_setItemPoint()
    ###
    キーの上下を押して掛け金を設定する
    ###
    _betSetting: ()->
        if @paermit_bet_change_flg is true
            if game.main_scene.keyList['up'] is true
                if @keyList['up'] is false
                    @_getBetSettingValue(true)
                    @keyList['up'] = true
            else
                if @keyList['up'] is true
                    @keyList['up'] = false
            if game.main_scene.keyList['down'] is true
                if @keyList['down'] is false
                    @_getBetSettingValue(false)
                    @keyList['down'] = true
            else
                if @keyList['down'] is true
                    @keyList['down'] = false

    ###
    掛け金の変更
    ###
    _getBetSettingValue:(up)->
        game.slot_setting.betChange(up)
        @bet_text.setValue()
    ###
    掛け金の変更が可能かを変更する
    @param boolean flg true:変更可能、false:変更不可能
    ###
    changeBetChangeFlg:(flg)->
        if flg is true
            @heigh_bet_button.opacity = 1
            @low_bet_button.opacity = 1
            @paermit_bet_change_flg = true
        else
            @heigh_bet_button.opacity = 0
            @low_bet_button.opacity = 0
            @paermit_bet_change_flg = false
    ###
    セットしているアイテムを表示する
    ###
    itemDsp:()->
        for i in [1..game.limit_set_item_num]
            if i <= game.max_set_item_num
                if game.item_set_now[i - 1] != undefined
                    @item_slot[i].frame = game.item_set_now[i - 1]
                    @item_slot[i].opacity = 1
                    #game.now_item = game.item_set_now[i]
                else
                    @item_slot[i].frame = 0
                    @item_slot[i].opacity = 1
                    #game.now_item = 0
            else
                @item_slot[i].frame = 0
                @item_slot[i].opacity = 0
    ###
    リアルタイムでアイテムゲージの増減をします
    アイテムスロットが空なら一定時間で回復し、全回復したら前にセットしていたアイテムを自動的にセットします
    アイテムスロットにアイテムが入っていたら、入っているアイテムによって一定時間で減少し、全てなくなったら自動的にアイテムを解除します
    ###
    _setItemPoint:()->
        if game.item_set_now.length is 0
            if game.item_point <= game.slot_setting.item_point_max
                game.item_point = Math.floor(1000 * (game.item_point + game.slot_setting.item_point_value[0])) /1000
                @_makeItemPointMaxProcess()
        else
            if 0 < game.item_point
                game.item_point = Math.floor(1000 * (game.item_point - game.slot_setting.item_decrease_point)) /1000
                if game.item_point < 0
                    game.item_point = 0
                    @_resetItem()
        @_dspItemPoint()
    ###
    アイテムゲージが回復してMAXになった時の処理
    ###
    _makeItemPointMaxProcess:()->
        if game.slot_setting.item_point_max <= game.item_point
            game.item_point = game.slot_setting.item_point_max
            if game.prev_item.length != 0
                game.item_set_now = game.prev_item
                @itemDsp()
                game.pause_scene.pause_item_use_layer.dspSetItemList()
                game.itemUseExe()
    ###
    アイテムゲージを決められた数値だけ回復する
    ###
    upItemPoint:(val)->
        if game.item_point <= game.slot_setting.item_point_max
            game.item_point = Math.floor(1000 * (game.item_point + val)) /1000
            @_makeItemPointMaxProcess()
            @_dspItemPoint()
    ###
    アイテムスロットを空にする
    ###
    _resetItem:()->
        game.prev_item = game.item_set_now
        game.item_set_now = []
        @itemDsp()
        game.pause_scene.pause_item_use_layer.dspSetItemList()
        game.itemUseExe()
    _dspItemPoint:()->
        @item_gauge.scaleX = Math.floor(100 * (game.item_point / game.slot_setting.item_point_max)) / 100
        @item_gauge.x = @item_gauge.initX - Math.floor(@item_gauge.width * (1 - @item_gauge.scaleX) / 2)
    whiteOut:()->
        if game.debug.white_back is true
            if @isWhiteBack is true
                @removeChild(@white_back)
                @isWhiteBack = false
            else
                @addChild(@white_back)
                @isWhiteBack = true
class systemHtml extends appHtml
    constructor: (width, height) ->
        super width, height
        @class = []
        @text = ''
        @is_button = false
    setHtml: ()->
        tmp_cls = ''
        for val in @class
            tmp_cls += val + ' '
        if @is_button is true
            tmp_cls += 'button-pointer'
        @_element.innerHTML = '<div class="'+tmp_cls+'">'+@text+'</div>'
    setImageHtml:()->
        tmp_cls = ''
        for val in @class
            tmp_cls += val + ' '
        if @is_button is true
            tmp_cls += 'button-pointer'
        @_element.innerHTML = '<img src="images/html/'+@image_name+'.png" class="'+tmp_cls+'"></img>'
    changeNotButton:()->
        @is_button = false
        @setImageHtml()
    changeIsButton:()->
        @is_button = true
        @setImageHtml()
    addDomClass:(cls, isImg = false)->
        if (@class.indexOf(cls) == -1)
            @class.push(cls)
            @_setHtml(isImg)
    removeDomClass:(cls, isImg = false)->
        for val, key in @class
            if val is cls
                @class.splice(key, 1)
        @_setHtml(isImg)
    _setHtml:(isImg = false)->
        if isImg is true
            @setImageHtml()
        else
            @setHtml()
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
        @y = 80
        @text = 'ゲームに戻る'
        @class.push('pause-main-menu-button-white')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@cancelSe)
        game.pause_scene.buttonList.pause = true

###
ゲームを保存する
###
class saveGameButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 180, 45
        @y = 620
        @text = 'セーブ'
        @class.push('pause-main-menu-button-middle')
        @class.push('pause-main-menu-button-blue')
        @setHtml()
    touchendEvent:() ->
        if game.fever is false
            game.sePlay(@dicisionSe)
            game.pause_scene.setSaveConfirmMenu()

class returnTitleButtonHtml extends pauseMainMenuButtonHtml
    constructor:()->
        super 180, 45
        @x = 250
        @y = 620
        @text = 'タイトル'
        @class.push('pause-main-menu-button-middle')
        @setHtml()
    touchendEvent:() ->
        game.sePlay(@dicisionSe)
        game.pause_scene.setTitleConfirmMenu()

class buyItemButtonHtml extends pauseMainMenuButtonHtml
    constructor: () ->
        super 400, 45
        @y = 370
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
        @y = 490
        @text = '魔法'
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
        @y = 490
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
        @y = 490
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
        @y = 330
    touchendEvent:() ->
        game.pause_scene.removeSaveMenu()

class saveConfirmOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 80
        @y = 330
    touchendEvent:()->
        game.pause_scene.setSaveMenu()

###
タイトルへ戻るOKボタン
###
class titleConfirmOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 80
        @y = 330
    touchendEvent:() ->
        game.returnToTitle()

class recordOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 170
        @y = 480
    touchendEvent:() ->
        game.pause_scene.removeRecordSelectMenu()

class trophyOkButtonHtml extends baseOkButtonHtml
    constructor:()->
        super
        @x = 170
        @y = 480
    touchendEvent:() ->
        game.pause_scene.removeTrophySelectmenu()


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
        @x = 170
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
            @class.push('base-ok-button-sp')
        @text = '購入'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        @touchendEvent()

###
アイテム購入の購入ボタン
###
class itemBuyBuyButtonHtml extends baseByuButtonHtml
    constructor:()->
        super
        @y = 500
    touchendEvent:() ->
        game.pause_scene.pause_item_buy_select_layer.buyItem()
    setBuyImpossiblePositon:()->
        @x = -200
    setBuyPossiblePosition:()->
        @x = 70

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
        @y = 350
        @text = '続きから'
        @setHtml()
    touchendEvent:() ->
        game.loadGameStart()

class newGameButtonHtml extends titleMenuButtonHtml
    constructor: () ->
        super
        @y = 430
        @text = '初めから'
        @setHtml()
    touchendEvent:() ->
        game.newGameStart()

###
ダイアログを閉じるボタン
###
class dialogCloseButton extends systemHtml
    constructor:()->
        super 30, 30
        @image_name = 'close'
        @is_button = true
        @x = 400
        @y = 100
        @setImageHtml()
        @cancelSe = game.soundload('cancel')

class itemBuyDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 70
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeItemBuyMenu()

class itemUseDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 70
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeItemUseMenu()

class memberSetDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 70
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeMemberSetMenu()

class recordDialogCloseButton extends dialogCloseButton
    constructor:()->
        super
        @y = 70
    ontouchend: () ->
        game.sePlay(@cancelSe)
        game.pause_scene.removeRecordMenu()

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
        @text = 'おすすめ'
        @setHtml()
    ontouchend: (e) ->
        game.sePlay(@dicisionSe)
        game.member_set_now = game.slot_setting.getRoleAbleMemberList()
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
        super 340, 200
        @x = 60
        @y = 180
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
        super 100, 20
        @x = 220
        @y = 80
        @text = '魔法'
        @setHtml()

class memberItemBuyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 220
        @y = 310
        @text = '部員'
        @setHtml()

class trophyItemBuyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 200
        @y = 530
        @text = 'トロフィー'
        @setHtml()

class useSetDiscription extends titleDiscription
    constructor:()->
        super
        @x = 180
        @y = 170
        @text = 'セット中'
        @setHtml()

class useHaveDiscription extends titleDiscription
    constructor:()->
        super
        @x = 170
        @y = 370
        @text = '所持リスト'
        @setHtml()

class recordDiscription extends titleDiscription
    constructor:()->
        super 100, 200
        @x = 200
        @y = 80
        @text = '楽曲'
        @setHtml()

class trophyDiscription extends titleDiscription
    constructor:()->
        super
        @x = 170
        @y = 520
        @text = 'トロフィー'
        @setHtml()

class speedDiscription extends titleDiscription
    constructor:()->
        super
        @x = 80
        @y = 530
        @text = '移動速度とジャンプ力'
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
        super 250, 20
        @class.push('head-title-discription')
        if game.isSumaho()
            @class.push('head-title-discription-sp')


class itemUseDiscription extends longTitleDiscription
    constructor:()->
        super
        @x = 120
        @y = 80
        @text = '魔法をセットする'
        @setHtml()

class memberSetDiscription extends longTitleDiscription
    constructor:()->
        super
        @x = 120
        @y = 80
        @text = '部員を編成する'
        @setHtml()
class imageHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
        @is_button = true

###
アイテム画像のベース
@param kind 種別
###
class baseItemHtml extends systemHtml
    constructor: (kind)->
        super 100, 100
        @image_name = 'test_image'
        @setImageHtml()
        @item_kind = kind
        @is_button = true
        @scaleX = 0.7
        @scaleY = 0.7
        @positionY = 0
        @positionX = 0
        @positoin_kind = @item_kind
        @dicisionSe = game.soundload('dicision')
    setPosition:()->
        if @positoin_kind <= 4
            @y = @positionY
            @x = 80 * (@positoin_kind - 1) + 70 + @positionX
        else
            @y = @positionY + 80
            @x = 80 * (@positoin_kind - 5) + 30 + @positionX
    dispItemBuySelectDialog:(kind)->
        game.pause_scene.setItemBuySelectMenu(kind)
    dispItemUseSelectDialog:(kind)->
        game.pause_scene.setItemUseSelectMenu(kind)
    dispMemberUseSelectDialog:(kind)->
        game.pause_scene.setMemberUseSelectMenu(kind)

###
アイテム
###
class itemHtml extends baseItemHtml
    constructor:(kind)->
        super kind
        @image_name = 'item_'+kind
        @setImageHtml()

class buyItemHtml extends itemHtml
    constructor:(kind)->
        super kind
        @positionY = 110
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemBuySelectDialog(@item_kind)

class useItemHtml extends itemHtml
    constructor:(kind)->
        super kind
        @positionY = 330
        @is_exist = false
    ontouchend:()->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemUseSelectDialog(@item_kind)

class setItemHtml extends baseItemHtml
    constructor:(position)->
        super position
        @kind = 0
        @positionY = 180
        @positionX = 120
        @positoin_kind = position - 1
        @_setImage(0)
    setItemKind:(kind)->
        @kind = kind
        @_setImage(kind)
        if kind != 0
            @changeIsButton()
        else
            @changeNotButton()
    _setImage:(kind)->
        @image_name = 'item_'+kind
        @setImageHtml()
    ontouchend: ()->
        if @kind != 0
            game.sePlay(@dicisionSe)
            game.pause_scene.setItemUseSelectMenu(@kind)

class speedHtml extends baseItemHtml
    constructor:(kind)->
        super kind
        @image_name = 'speed_'+kind
        @setImageHtml()
        @positionY = 560
        @positionX = 45

###
部員
###
class memberHtml extends baseItemHtml
    constructor:(kind)->
        super kind
        @image_name = 'item_'+kind
        @setImageHtml()
        @positoin_kind = @item_kind - 10

class buyMemberHtml extends memberHtml
    constructor:(kind)->
        super kind
        @positionY = 340
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemBuySelectDialog(@item_kind)

class useMemberHtml extends memberHtml
    constructor:(kind)->
        super kind
        @positionY = 350
        @is_exist = false
    ontouchend:()->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispMemberUseSelectDialog(@item_kind)

class setMemberHtml extends baseItemHtml
    constructor:(position)->
        super position
        @kind = 0
        @disabled = false
        @positionY = 180
        @positionX = 120
        @positoin_kind = position - 1
        @_setImage(10)
    setItemKind:(kind)->
        @kind = kind
        @_setImage(kind)
        if kind != 10
            @changeIsButton()
        else
            @changeNotButton()
    _setImage:(kind)->
        @image_name = 'item_'+kind
        @setImageHtml()
    ontouchend: ()->
        if @kind != 10 and @disabled is false
            game.sePlay(@dicisionSe)
            game.pause_scene.setMemberUseSelectMenu(@kind)

class selectItemImage extends imageHtml
    constructor:()->
        super 100, 100
        @x = 200
        @y = 180
        @is_button = false
    setImage:(image)->
        @image_name = image
        @setImageHtml()

class baseRecordItemHtml extends systemHtml
    constructor: (position, kind)->
        super 100, 100
        @position = position
        @kind = kind
        @is_button = true
        @scaleX = 0.65
        @scaleY = 0.65
        @positionY = 0
        @positionX = 0
        @dicisionSe = game.soundload('dicision')
    setPosition:()->
        @y = @positionY + (Math.floor(@position / 5) + 1) * 75
        @x = 75 * (@position % 5) + @positionX

class recordItemHtml extends baseRecordItemHtml
    constructor: (position, kind)->
        super position, kind
        @image_name = 'bgm_' + kind
        @setImageHtml()
        @positionY = 40
        @positionX = 35
    ontouchend: ()->
        game.sePlay(@dicisionSe)
        game.pause_scene.setRecordSelectMenu(@kind)
class trophyItemHtml extends baseRecordItemHtml
    constructor: (position, kind)->
        super position, kind
        @image_name = 'item_' + kind
        @setImageHtml()
        @positionY = 480
        @positionX = 75
        @is_exist = true
    ontouchend: ()->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            game.pause_scene.setTrophySelectMenu(@kind)
class buyTrophyItemHtml extends baseRecordItemHtml
    constructor: (position, kind)->
        super position, kind
        @image_name = 'item_' + kind
        @setImageHtml()
        @positionY = 480
        @positionX = 75
        @item_kind = kind
        @is_exist = true
    ontouchend: () ->
        if @is_exist is true
            game.sePlay(@dicisionSe)
            @dispItemBuySelectDialog(@item_kind)
    dispItemBuySelectDialog:(kind)->
        game.pause_scene.setItemBuySelectMenu(kind)
class text extends appLabel
    constructor: () ->
        super
###
所持金
###
class moneyText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 22
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 0
        @y = 7
        @zandaka_text = '残高'
        @yen_text = '円'
        @setValue()
    ###
    所持金の文字列を設定する
    @param number val 所持金
    ###
    setValue: ()->
        @text = @zandaka_text + game.toJPUnit(game.money) + @yen_text
        @setXposition()
    ###
    X座標の位置を設定
    ###
    setXposition: () ->
        @x = game.width - @_boundWidth - 7
    setPositionPause:()->
        @x = 100
        @y = 210

class betText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 22
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 37
        @y = 7
        @kakekin_text = '掛金'
        @yen_text = '円'
        @text = @kakekin_text + game.toJPUnit(game.bet) + @yen_text
    setValue: () ->
        @text = @kakekin_text + game.toJPUnit(game.bet) + @yen_text
        game.main_scene.gp_system.low_bet_button.setXposition()
    setPositionPause:()->
        @x = 140
        @y = 270

class comboText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 37
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 195
        @y = 75
    setValue: () ->
        @text = game.combo
        @setXposition()
    setXposition: () ->
        unit = game.main_scene.gp_system.combo_unit_text
        @x = game.width / 2 - (@_boundWidth + unit._boundWidth + 5) / 2
        if 3 <= game.max_set_item_num
            @x += 50
        unit.x = @x + @_boundWidth + 5
class comboUnitText extends text
    constructor: () ->
        super
        @text = 'combo'
        @color = 'black'
        @font = "22px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 217
        @y = 90
###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #開始後いきなりメイン画面
        @force_main_flg = true
        #開始後いきなりポーズ画面
        @force_pause_flg = false

        #ゲーム開始時ロードをしない
        @not_load_flg = false
        #テストロードに切り替え
        @test_load_flg = false
        #テストロード用の値
        @test_load_val = {
            'money':9876543210,
            'bet':10000,
            'combo':0,
            'max_combo':200,
            'tension':500,
            'past_fever_num':0,
            'item_point':100,
            'next_add_member_key':0,
            'now_muse_num':0,
            'max_set_item_num':3,
            'item_have_now':[3,4,5,12,21,22,23],
            'item_set_now':[5,7,8],
            'member_set_now':[12],
            'prev_fever_muse':[11,12,13,14,15,16,17,19,31],
            'prev_item':[],
            'left_lille':[],
            'middle_lille':[],
            'right_lille':[]
        }

        #デバッグ用リールにすりかえる
        @lille_flg = false

        #デバッグ用リール配列
        @lille_array = [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]
        ###
        @lille_array = [
            [11, 11, 11, 11, 11, 11, 11, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [12, 12, 12, 12, 12, 12, 12, 12, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [13, 13, 13, 13, 13, 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]
        ###

        #画面が白一色で覆われる、ｃキーで切り替え可能
        @white_back = false
        #ゲームのサイズが等倍
        @toubai = false

        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = false
        #アイテムが降ってくる頻度を上げる
        #@item_fall_early_flg = false
        #アイテムを取った時のテンション増減値を固定する
        @fix_tention_item_catch_flg = false
        #アイテムを落とした時のテンション増減値を固定する
        @fix_tention_item_fall_flg = false
        #スロットが当たった時のテンション増減値を固定する
        @fix_tention_slot_hit_flg = false
        #スロットに必ずμ’ｓが追加される
        #@force_insert_muse = false
        #スロットが必ず当たる
        @force_slot_hit = false
        #スロットが2回に1回当たる
        @half_slot_hit = false
        #スロットが強制的に当たるときに必ずフィーバーになる
        @force_fever = false

        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = 0
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @force_pause_flg is true
            @force_main_flg = true
###
スロットのリールの並びや掛け金に対する当選額
テンションによるリールの変化確率など
ゲームバランスに作用する固定値の設定
###
class slotSetting extends appNode
    constructor: () ->
        super
        #リールの並び
        @lille_array_0 = [
            [1,2,1,2,1,3,5,1,2,3,5,1,2,1,3,4,1,2,1,4],
            [2,4,1,1,3,2,4,1,3,2,5,1,3,2,4,1,3,1,5,1],
            [1,5,2,3,1,4,1,3,1,4,5,2,3,1,4,2,3,1,2,1]
        ]
        @lille_array_1 = [
            [1,3,1,3,1,2,5,1,3,2,5,1,3,1,2,4,1,3,1,4],
            [3,4,1,1,2,3,4,1,2,3,5,1,2,3,4,1,2,1,5,1],
            [1,5,3,2,1,4,1,2,1,4,5,3,2,1,4,3,2,1,3,1]
        ]
        @lille_array_2 = [
            [1,4,1,4,1,2,5,1,4,2,5,1,4,1,2,3,1,4,1,3],
            [4,3,1,1,2,4,3,1,2,4,5,1,2,4,3,1,2,1,5,1],
            [1,5,4,2,1,3,1,2,1,3,5,4,2,1,3,4,2,1,4,1]
        ]
        #リールの目に対する当選額の倍率
        @bairitu = {
            1:10, 2:10, 3:20, 4:30, 5:40,
            11:40, 12:40, 13:40, 14:40, 15:40, 16:40, 17:40, 18:40, 19:40
        }
        ###
        カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
        11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
        ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
        31:ほのりん、32:ことぱな、33:にこのぞ、34:ことうみ、35:まきりん、36:のぞえり、37:にこまき、38:うみえり
        direction:キャラクターの向き、left or right
        カットインの画像サイズ、頭の位置で570px
        頭の上に余白がある場合の高さ計算式：(570/(元画像高さ-元画像頭のY座標))*元画像高さ
        ###
        @muse_material_list = {
            11:{
                'cut_in':[
                    {'name':'11_0', 'width':360, 'height':570, 'direction':'left'},
                    {'name':'11_1', 'width':730, 'height':662, 'direction':'left'},
                    {'name':'11_2', 'width':563, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'yumenaki', 'time':107, 'title':'夢なき夢は夢じゃない', 'unit':'高坂穂乃果', 'image':'bgm_11'}
                ],
                'voice':['11_0', '11_1', '11_2']
            },
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':510, 'height':728, 'direction':'left'},
                    {'name':'12_1', 'width':640, 'height':648, 'direction':'right'},
                    {'name':'12_2', 'width':388, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'blueberry', 'time':98, 'title':'ぶる～べりぃとれいん', 'unit':'南ことり', 'image':'bgm_12'}
                ],
                'voice':['12_0', '12_1', '12_2']
            },
            13:{
                'cut_in':[
                    {'name':'13_0', 'width':570, 'height':634, 'direction':'left'},
                    {'name':'13_1', 'width':408, 'height':570, 'direction':'left'},
                    {'name':'13_2', 'width':412, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'reason', 'time':94, 'title':'勇気のReason', 'unit':'園田海未', 'image':'bgm_13'}
                ],
                'voice':['13_0', '13_1', '13_2']
            },
            14:{
                'cut_in':[
                    {'name':'14_0', 'width':476, 'height':648, 'direction':'left'},
                    {'name':'14_1', 'width':650, 'height':570, 'direction':'right'},
                    {'name':'14_2', 'width':750, 'height':660, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'daring', 'time':91, 'title':'Darling！！', 'unit':'西木野真姫', 'image':'bgm_14'}
                ],
                'voice':['14_0', '14_1', '14_2']
            },
            15:{
                'cut_in':[
                    {'name':'15_0', 'width':502, 'height':570, 'direction':'right'},
                    {'name':'15_1', 'width':601, 'height':638, 'direction':'left'},
                    {'name':'15_2', 'width':563, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'rinrinrin', 'time':128, 'title':'恋のシグナルRin rin rin！', 'unit':'星空凛', 'image':'bgm_15'}
                ],
                'voice':['15_0', '15_1', '15_2']
            },
            16:{
                'cut_in':[
                    {'name':'16_0', 'width':438, 'height':570, 'direction':'right'},
                    {'name':'16_1', 'width':580, 'height':644, 'direction':'left'},
                    {'name':'16_2', 'width':450, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'nawatobi', 'time':164, 'title':'なわとび', 'unit':'小泉花陽', 'image':'bgm_16'}
                ],
                'voice':['16_0', '16_1', '16_2']
            },
            17:{
                'cut_in':[
                    {'name':'17_0', 'width':465, 'height':705, 'direction':'left'},
                    {'name':'17_1', 'width':361, 'height':570, 'direction':'left'},
                    {'name':'17_2', 'width':378, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'mahoutukai', 'time':105, 'title':'まほうつかいはじめました', 'unit':'矢澤にこ', 'image':'bgm_17'}
                ],
                'voice':['17_0', '17_1', '17_2']
            },
            18:{
                'cut_in':[
                    {'name':'18_0', 'width':599, 'height':606, 'direction':'right'},
                    {'name':'18_1', 'width':380, 'height':675, 'direction':'left'},
                    {'name':'18_2', 'width':433, 'height':602, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'junai', 'time':127, 'title':'純愛レンズ', 'unit':'東條希', 'image':'bgm_18'}
                ],
                'voice':['18_0', '18_1', '18_2']
            },
            19:{
                'cut_in':[
                    {'name':'19_0', 'width':460, 'height':570, 'direction':'left'},
                    {'name':'19_1', 'width':670, 'height':650, 'direction':'right'},
                    {'name':'19_2', 'width':797, 'height':595, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'arihureta', 'time':93, 'title':'ありふれた悲しみの果て', 'unit':'絢瀬絵里', 'image':'bgm_19'}
                ],
                'voice':['19_0', '19_1', '19_2']
            },
            20:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'タイトル', 'unit':'ユニット', 'image':'test_image2'}
                ]
            },
            21:{
                'bgm':[
                    {'name':'hello_hoshi', 'time':93, 'title':'Hello，星を数えて ', 'unit':'1年生<br>（星空凛、西木野真姫、小泉花陽）', 'image':'bgm_21'}
                ]
            },
            22:{
                'bgm':[
                    {'name':'future_style', 'time':94, 'title':'Future style', 'unit':'2年生<br>（高坂穂乃果、南ことり、園田海未）', 'image':'bgm_22'}
                ]
            },
            23:{
                'bgm':[
                    {'name':'hatena_heart', 'time':84, 'title':'？←HEARTBEAT', 'unit':'3年生<br>（絢瀬絵里、東條希、矢澤にこ）', 'image':'bgm_23'}
                ]
            },
            24:{
                'bgm':[
                    {'name':'sweet_holiday', 'time':114, 'title':'sweet＆sweet holiday', 'unit':'Printemps<br>(高坂穂乃果、南ことり、小泉花陽)', 'image':'bgm_24'}
                ]
            },
            25:{
                'bgm':[
                    {'name':'anone_ganbare', 'time':100, 'title':'あ・の・ね・が・ん・ば・れ', 'unit':'lily white<br>(園田海未、星空凛、東條希)', 'image':'bgm_25'}
                ]
            },
            26:{
                'bgm':[
                    {'name':'love_novels', 'time':98, 'title':'ラブノベルス', 'unit':'BiBi<br>(絢瀬絵里、西木野真姫、矢澤にこ)', 'image':'bgm_26'}
                ]
            },
            27:{
                'bgm':[
                    {'name':'listen_to_my_heart', 'time':137, 'title':'Listen to my heart！！', 'unit':'にこりんぱな<br>(矢澤にこ、星空凛、小泉花陽)', 'image':'bgm_27'}
                ]
            },
            28:{
                'bgm':[
                    {'name':'soldier_game', 'time':90, 'title':'soldier game', 'unit':'<br>園田海未、西木野真姫、絢瀬絵里', 'image':'bgm_28'}
                ]
            },
            31:{
                'bgm':[
                    {'name':'mermaid2', 'time':122, 'title':'Mermaid festa vol．2', 'unit':'高坂穂乃果、星空凛', 'image':'bgm_31'}
                ]
            },
            32:{
                'bgm':[
                    {'name':'kokuhaku', 'time':98, 'title':'告白日和、です！', 'unit':'南ことり、小泉花陽', 'image':'bgm_32'}
                ]
            },
            33:{
                'bgm':[
                    {'name':'otomesiki', 'time':100, 'title':'乙女式れんあい塾', 'unit':'矢澤にこ、東條希', 'image':'bgm_33'}
                ]
            },
            34:{
                'bgm':[
                    {'name':'anemone_heart', 'time':100, 'title':'Anemone heart', 'unit':'南ことり、園田海未', 'image':'bgm_34'}
                ]
            },
            35:{
                'bgm':[
                    {'name':'beat_in_angel', 'time':105, 'title':'Beat in Angel', 'unit':'西木野真姫、星空凛', 'image':'bgm_35'}
                ]
            },
            36:{
                'bgm':[
                    {'name':'garasu', 'time':103, 'title':'硝子の花園', 'unit':'東條希、絢瀬絵里', 'image':'bgm_36'}
                ]
            },
            37:{
                'bgm':[
                    {'name':'magnetic', 'time':111, 'title':'ずるいよMagnetic today', 'unit':'矢澤にこ、西木野真姫', 'image':'bgm_37'}
                ]
            },
            38:{
                'bgm':[
                    {'name':'storm', 'time':116, 'title':'Storm in Lover', 'unit':'園田海未、絢瀬絵里', 'image':'bgm_38'}
                ]
            }
        }

        @bgm_list = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 36, 37, 38]

        ###
        アイテムのリスト
        ###
        @item_list = {
            0:{
                'name':'アイテム',
                'image':'test_image',
                'discription':'アイテムの説明',
                'price':100, #値段
                'durationSec':30, #持続時間(秒)
                'conditoin':'出現条件',
                'condFunc':()-> #出現条件の関数 true:出す、false:隠す
                    return true
            },
            1:{
                'name':'チーズケーキ鍋',
                'image':'item_1',
                'discription':'チーズケーキしか降ってこなくなる<br>爆弾は降ってこなくなる',
                'price':1000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(2)
            },
            2:{
                'name':'くすくす大明神',
                'image':'item_2',
                'discription':'コンボ数に関わらず<br>たくさんのコインが降ってくるようになる',
                'price':10000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(4)
            },
            3:{
                'name':'ぴょんぴょこぴょんぴょん',
                'image':'item_3',
                'discription':'ジャンプ力が上がる',
                'price':50000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(3)
            },
            4:{
                'name':'テンション上がるにゃー！',
                'image':'item_4',
                'discription':'移動速度が上がる',
                'price':100000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(1)
            },
            5:{
                'name':'チョットマッテテー',
                'image':'item_5',
                'discription':'おやつが降ってくる速度が<br>ちょっとだけ遅くなる',
                'price':1000000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(6)
            },
            6:{
                'name':'認められないわぁ',
                'image':'item_6',
                'discription':'アイテムを落としてもコンボが減らず<br>テンションも下がらないようになる',
                'price':5000000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(9)
            },
            7:{
                'name':'完っ全にフルハウスね',
                'image':'item_7',
                'discription':'3回に1回の確率で<br>CHANCE!!状態になる',
                'price':10000000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(5)
            },
            8:{
                'name':'ファイトだよっ',
                'image':'item_8',
                'discription':'CHANCE!!でスロットが揃う時に<br>FEVER!!が出やすくなる',
                'price':100000000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(7)
            },
            9:{
                'name':'ラブアローシュート',
                'image':'item_9',
                'discription':'おやつが近くに落ちてくる',
                'price':1000000000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(8)
            },
            11:{
                'name':'高坂穂乃果',
                'image':'item_11',
                'discription':'スロットに穂乃果が挿入されるようになる。',
                'price':0,
                'conditoin':'穂乃果でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(11)
            },
            12:{
                'name':'南ことり',
                'image':'item_12',
                'discription':'スロットにことりが挿入されるようになる。',
                'price':0,
                'conditoin':'ことりでスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(12)
            },
            13:{
                'name':'園田海未',
                'image':'item_13',
                'discription':'スロットに海未が挿入されるようになる。',
                'price':0,
                'conditoin':'海未でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(13)
            },
            14:{
                'name':'西木野真姫',
                'image':'item_14',
                'discription':'スロットに真姫が挿入されるようになる。',
                'price':0,
                'conditoin':'真姫でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(14)
            },
            15:{
                'name':'星空凛',
                'image':'item_15',
                'discription':'スロットに凛が挿入されるようになる。',
                'price':0,
                'conditoin':'凛でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(15)
            },
            16:{
                'name':'小泉花陽',
                'image':'item_16',
                'discription':'スロットに花陽が挿入されるようになる。',
                'price':0,
                'conditoin':'花陽でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(16)
            },
            17:{
                'name':'矢澤にこ',
                'image':'item_17',
                'discription':'スロットににこが挿入されるようになる。',
                'price':0,
                'conditoin':'にこでスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(17)
            },
            18:{
                'name':'東條希',
                'image':'item_18',
                'discription':'スロットに希が挿入されるようになる。',
                'price':0,
                'conditoin':'希でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(18)
            },
            19:{
                'name':'絢瀬絵里',
                'image':'item_19',
                'discription':'スロットに絵里が挿入されるようになる。',
                'price':0,
                'conditoin':'絵里でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(19)
            },
            21:{
                'name':'ブロンズことり',
                'image':'item_21',
                'discription':'移動速度とジャンプ力がアップする',
                'price':1000000,
                'conditoin':'100コンボ達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(21)
            },
            22:{
                'name':'シルバーことり',
                'image':'item_22',
                'discription':'魔法のスロットが1つ増える',
                'price':100000000,
                'conditoin':'ソロ楽曲9曲を全て達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(22)
            },
            23:{
                'name':'ゴールドことり',
                'image':'item_23',
                'discription':'移動速度とジャンプ力がアップする<br>魔法のスロットが1つ増える',
                'price':10000000000,
                'conditoin':'200コンボ達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(23)
            },
            24:{
                'name':'プラチナことり',
                'image':'item_24',
                'discription':'エンディングが見れる',
                'price':1000000000000,
                'conditoin':'楽曲を20曲以上達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(24)
            }
        }

        #アイテムの並び順
        #@item_sort_list = [1->1, 2->2, 3->3, 4->4, 6->5, 8->6, 7->7, 5->8, 9->9]

        #μ’ｓメンバーアイテムの値段、フィーバーになった順に
        @member_item_price = [1000, 5000, 10000, 50000, 100000, 500000, 1000000, 5000000, 10000000]

        #テンションの最大値
        @tension_max = 500
        #trueならスロットが強制で当たる
        @isForceSlotHit = false
        #スロットが強制で当たる確率
        @slotHitRate = 0
        #アイテムポイントの最大値
        @item_point_max_init = 500
        @item_point_max = 500
        #アイテムポイントが全回復するまでの秒数
        @item_point_recovery_sec = 60
        #アイテムポイントが増える／減るのにかかる値(ポイント／フレーム)
        #0はアイテムがセットされていない時に増える値、１～は各アイテムをセットしている時に減る値
        @item_point_value = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0]
        #単位時間で減少するアイテムポイント
        @item_decrease_point = 0
        #掛け金が増えると当選金額の割合が減る補正
        @prize_div = 1
        @item_gravity = 0
        #ランダムでの結果と部員の編成を加味した最終的な挿入するμ’ｓメンバーの数値
        @add_muse_num = 0
        #おすすめで前回編成した部員のキー
        @prev_osusume_role = 0

        #セーブする変数
        @prev_muse = [] #過去にスロットに入ったμ’ｓ番号(TODO 使ってない？不要か検証してから消す)
        @now_muse_num = 0 #現在ランダムに選択されてスロットに入るμ’ｓ番号

    setItemPointValue:()->
        @item_point_value[0] = Math.floor(@item_point_max * 1000 / (@item_point_recovery_sec * game.fps)) / 1000
        for i in [1..9]
            @item_point_value[i] = Math.floor(@item_point_max_init * 1000 / (@item_list[i].durationSec * game.fps)) / 1000

    ###
    単位時間で減少するアイテムポイントの値を決定する
    ###
    setItemDecreasePoint:()->
        point = 0
        for key, val of game.item_set_now
            if val != undefined
                point += @item_point_value[val]
        @item_decrease_point = point

    ###
    アイテムポイントの最大値を決定する
    ###
    setItemPointMax:()->
        @item_point_max = @item_point_max_init * game.max_set_item_num
        @setItemPointValue()
        sys = game.main_scene.gp_system
        sys.item_gauge_back.setWidth()
        sys.item_gauge.setWidth()

    ###
    落下アイテムの加速度
    掛け金が多いほど速くする
    ###
    setGravity:()->
        if game.bet < 10
            val = 0.35
            @prize_div = 1
        else if game.bet < 50
            val = 0.40
            @prize_div = 1
        else if game.bet < 100
            val = 0.44
            @prize_div = 1
        else if game.bet < 500
            val = 0.48
            @prize_div = 1
        else if game.bet < 1000
            val = 0.5
            @prize_div = 0.9
        else if game.bet < 5000
            val = 0.53
            @prize_div = 0.9
        else if game.bet < 10000 #1万
            val = 0.55
            @prize_div = 0.9
        else if game.bet < 50000
            val = 0.58
            @prize_div = 0.9
        else if game.bet < 100000
            val = 0.61
            @prize_div = 0.8
        else if game.bet < 500000
            val = 0.64
            @prize_div = 0.8
        else if game.bet < 1000000 #100万
            val = 0.67
            @prize_div = 0.8
        else if game.bet < 5000000
            val = 0.7
            @prize_div = 0.8
        else if game.bet < 10000000
            val = 0.73
            @prize_div = 0.7
        else if game.bet < 50000000
            val = 0.76
            @prize_div = 0.7
        else if game.bet < 100000000 #１億
            val = 0.8
            @prize_div = 0.7
        else if game.bet < 500000000
            val = 0.9
            @prize_div = 0.7
        else if game.bet < 1000000000
            val = 1
            @prize_div = 0.6
        else if game.bet < 5000000000
            val = 1.2
            @prize_div = 0.6
        else if game.bet < 10000000000 #100億
            val = 1.4
            @prize_div = 0.6
        else if game.bet < 50000000000
            val = 1.6
            @prize_div = 0.6
        else if game.bet < 100000000000
            val = 1.8
            @prize_div = 0.5
        else if game.bet < 500000000000
            val = 2
            @prize_div = 0.5
        else if game.bet < 1000000000000 #1兆
            val = 2.5
            @prize_div = 0.5
        else
            val = 3
            @prize_div = 0.5
        div = 1
        val = Math.floor(val * div * 100) / 100
        if 100 < game.combo
            div = Math.floor((game.combo - 100) / 20) / 10
            if div < 0
                div = 0
            if 3 < div
                div = 3
            val += div
        if game.isItemSet(5)
            val = Math.floor(val * 0.7 * 100) / 100
        @item_gravity = val
        return val

    ###
    テンションからスロットにμ’sが入るかどうかを返す
    初期値5％、テンションMAXで20％
    過去のフィーバー回数が少ないほど上方補正かける 0回:+12,1回:+8,2回:+4
    @return boolean
    ###
    isAddMuse:()->
        result = false
        rate = Math.floor((game.tension / @tension_max) * 15) + 5
        if game.past_fever_num <= 2
            rate += (3 - game.past_fever_num) * 4
        random = Math.floor(Math.random() * 100)
        if random < rate
            result = true
        if game.debug.force_insert_muse is true
            result = true
        if game.fever is true
            result = false
        return result

    ###
    挿入するμ’sメンバーを決める
    過去に挿入されたメンバーは挿入しない
    ###
    setMuseMember:(force)->
        full = [11,12,13,14,15,16,17,18,19]
        remain = []
        if game.arrIndexOf(game.prev_fever_muse, full)
            @now_muse_num = 0
        else
            for key, val of full
                if game.prev_fever_muse.indexOf(val) is -1
                    remain.push(full[key])
            random = Math.floor(Math.random() * remain.length)
            member = remain[random]
            @now_muse_num = member
            if @prev_muse.indexOf(member) is -1
                @prev_muse.push(member)
        game.pause_scene.pause_member_set_layer.dispSetMemberList()


    ###
    挿入するμ’sメンバーの人数を決める
    ###
    setMuseNum:()->
        num = Math.floor(game.combo / 100) + 1
        return num

    ###
    スロットを強制的に当たりにするかどうかを決める
    コンボ数 * 0.1 ％
    テンションMAXで+20補正
    過去のフィーバー回数が少ないほど上方補正かける 0回:+9,1回:+6,2回:+3
    最大値は30％
    フィーバー中は強制的に当たり
    @return boolean true:当たり
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor((game.combo * 0.1) + ((game.tension / @tension_max) * 20))
        if game.past_fever_num <= 2
            rate += ((3 - game.past_fever_num)) * 3
        if rate > 30 || game.isItemSet(8) || game.main_scene.gp_back_panorama.now_back_effect_flg is true
            rate = 30
        if game.debug.half_slot_hit is true
            rate = 50
        @slotHitRate = rate
        random = Math.floor(Math.random() * 100)
        if random < rate || game.fever is true || game.debug.force_slot_hit is true
            result = true
        @isForceSlotHit = result
        return result

    ###
    スロットが回っている時に降ってくる掛け金の戻り分の額を計算
    ###
    getReturnMoneyFallValue:()->
        up = game.combo
        if game.isItemSet(2) && game.combo < 200
            up = 200
        return Math.floor(game.bet * up * 0.03)

    ###
    スロットの当選金額を計算
    @param eye 当たったスロットの目
    ###
    calcPrizeMoney: (eye) ->
        ret_money = Math.floor(game.bet * @bairitu[eye] * @prize_div)
        if game.fever is true
            time = @muse_material_list[game.fever_hit_eye]['bgm'][0]['time']
            div = Math.floor(time / 90)
            if div < 1
                div = 1
            ret_money = Math.floor(ret_money / div)
        if game.main_scene.gp_back_panorama.now_back_effect_flg is true
            ret_money *= 2
        if ret_money > 10000000000
            ret_money = 10000000000
        return ret_money

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (game.item_kind + 2) * @_getTensionCorrect()
        if game.main_scene.gp_stage_front.player.isAir is true
            @_upItemPointIfPlayerIsAir()
        if val >= 1
            val = Math.round(val)
        else
            val = 1
        if game.debug.fix_tention_item_catch_flg is true
            val = game.debug.fix_tention_item_catch_val
        if game.fever is true
            val = 0
        return val

    ###
    空中でアイテムを取った時にアイテムポイントを回復する
    高い位置で取った時ほど大幅に回復させる
    ###
    _upItemPointIfPlayerIsAir:()->
        playerY = game.main_scene.gp_stage_front.player.y
        if playerY < game.height * 0.4
            val = 80
        else if playerY < game.height * 0.5
            val = 60
        else if playerY < game.height * 0.6
            val = 40
        else
            val = 20
        game.main_scene.gp_system.upItemPoint(val)

    ###
    所持金と掛け金の比でテンションの増値に補正を加える
    ###
    _getTensionCorrect:()->
        quo = Math.round(game.money / game.bet)
        val = 1
        if quo <= 10
            val = 4
        else if quo <= 30
            val = 3
        else if quo <= 60
            val = 2
        else if quo <= 200
            val = 1.5
        else if quo <= 600
            val = 1
        else if quo <= 2000
            val = 0.75
        else
            val = 0.5
        return  val

    ###
    アイテムを落とした時のテンションゲージの増減値を決める
    ###
    setTensionItemFall:()->
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        else
            if game.isItemSet(6) || game.fever is true
                val = 0
            else
                val = @tension_max * @_getTensionDownCorrect()
        return val

    setTensionMissItem:()->
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        else
            val = Math.ceil(@tension_max * (@_getTensionDownCorrect() - 0.2))
        return val

    _getTensionDownCorrect:()->
        val = -0.1
        return val

    ###
    スロットが当たったのテンションゲージの増減値を決める
    @param number hit_eye     当たった目の番号
    ###
    setTensionSlotHit:(hit_eye)->
        val = @_getTensionCorrect() * @tension_max * 0.1
        if val > @tension_max * 0.5
            val = @tension_max * 0.5
        else if val < @tension_max * 0.05
            val = @tension_max * 0.05
        val = Math.round(val)
        if game.debug.fix_tention_slot_hit_flg is true
            val = game.debug.fix_tention_slot_hit_flg
        if game.fever is true
            val = 0
        return val

    ###
    テンションの状態でスロットの内容を変更する
    ミスアイテムの頻度を決める
    @param number tension 変化前のテンション
    @param number val     テンションの増減値
    ###
    changeLilleForTension:(tension, val)->
        if game.debug.lille_flg is false
            slot = game.main_scene.gp_slot
            stage = game.main_scene.gp_stage_front
            before = tension
            after = tension + val
            tension_33 = Math.floor(@tension_max * 0.33)
            tension_66 = Math.floor(@tension_max * 0.66)
            if before > 0 && after <= 0
                slot.slotLilleChange(@lille_array_0, true)
            else if before > tension_33 && after < tension_33
                slot.slotLilleChange(@lille_array_0, false)
                stage.missItemFallSycle = 4
                stage.missItemFallSycleNow = 0
            else if before < tension_66 && after > tension_66
                slot.slotLilleChange(@lille_array_2, false)
                stage.missItemFallSycle = 2
                stage.missItemFallSycleNow = 0
            else if (before < tension_33 || before > tension_66) && (after > tension_33 && after < tension_66)
                slot.slotLilleChange(@lille_array_1, false)
                stage.missItemFallSycle = 1
                stage.missItemFallSycleNow = 0

    ###
    落下するアイテムの種類を決める
    @return 0から4のどれか
    ###
    getCatchItemFrame:()->
        val = 0
        rate = Math.round(Math.random() * 100)
        if rate < 20
            val = 0
        else if rate < 40
            val = 1
        else if rate < 60
            val = 2
        else if rate < 80
            val = 3
        else
            val = 4
        if game.isItemSet(1)
            val = 4
        game.item_kind = val
        return val
    ###
    スロットの強制当たりが有効な時間を決める
    エフェクトが画面にイン、アウトする時間が合計0.6秒あるので
    実際はこれの返り値に+0.6追加される
    ###
    setChanceTime:()->
        if @slotHitRate <= 10
            fixTime = 2
            randomTime = 5
        else if @slotHitRate <= 20
            fixTime = 1.5
            randomTime = 10
        else
            fixTime = 1
            randomTime = 15
        fixTime += Math.floor((1 - @item_gravity) * 10) / 10
        ret = fixTime + Math.floor(Math.random() * randomTime) / 10
        return ret
    ###
    スロットの揃った目が全てμ’sなら役を判定して返します
    メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    @return role
    ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:ほのりん、32:ことぱな、33:にこのぞ、34:ことうみ、35:まきりん、36:のぞえり、37:にこまき、38:うみえり
    ###
    getHitRole:(left, middle, right)->
        role = 20
        lille = [left, middle, right]
        items = game.getDeduplicationList(lille)
        items = game.sortAsc(items)
        items = items.join(',')
        switch items #重複除外、昇順、カンマ区切りの文字列になる
            when '14,15,16' then role = 21
            when '11,12,13' then role = 22
            when '17,18,19' then role = 23
            when '11,12,16' then role = 24
            when '13,15,18' then role = 25
            when '14,17,19' then role = 26
            when '15,16,17' then role = 27
            when '13,14,19' then role = 28
            when '11,15'    then role = 31
            when '12,16'    then role = 32
            when '17,18'    then role = 33
            when '12,13'    then role = 34
            when '14,15'    then role = 35
            when '18,19'    then role = 36
            when '14,17'    then role = 37
            when '13,19'    then role = 38
            else role = 20
        return role

    ###
    アイテムの出現条件を返す
    @param num アイテムの番号
    @return boolean
    ###
    itemConditinon:(num)->
        rslt = false
        if num < 10
            rslt = true
        else if num < 20
            if game.prev_fever_muse.indexOf(parseInt(num)) != -1
                rslt = true
        else if num is 21
            if 100 <= game.max_combo
                rslt = true
        else if num is 22
            if 9 <= game.countSoloMusic()
                rslt = true
        else if num is 23
            if 200 <= game.max_combo
                rslt = true
        else if num is 24
            if 20 <= game.countFullMusic()
                rslt = true
        return rslt

    ###
    μ’ｓメンバーの値段を決める
    ###
    setMemberItemPrice:()->
        cnt = 0
        list = game.getDeduplicationList(game.prev_fever_muse)
        for key, val of list
            if 11 <= val && val <= 19
                if 0 == @item_list[val].price
                    @item_list[val].price = @member_item_price[cnt]
                cnt++
    ###
    現在セットされているメンバーから次にスロットに挿入するμ’ｓメンバーを決めて返します
    ###
    getAddMuseNum:()->
        member = game.member_set_now
        max = game.max_set_member_num
        if member.length is 0
            ret = @now_muse_num
        else
            if game.next_add_member_key is member.length && game.next_add_member_key != max && @now_muse_num != 0
                ret = @now_muse_num
            else
                if @now_muse_num is 0
                    if game.next_add_member_key is member.length
                        game.next_add_member_key = 0
                else
                    if game.next_add_member_key is member.length + 1 || game.next_add_member_key is max
                        game.next_add_member_key = 0
                if member[game.next_add_member_key] is undefined
                    game.next_add_member_key = 0
                ret = member[game.next_add_member_key]
            game.next_add_member_key += 1
        @add_muse_num = ret
        return ret

    ###
    チャンスの時に強制的にフィーバーにする
    ###
    isForceFever:()->
        tension_rate = Math.floor((game.tension * 100)/ @tension_max)
        if game.isItemSet(8)
            rate = 20
        else if tension_rate is 100
            rate = 16
        else if 80 <= tension_rate
            rate = 12
        else if 60 <= tension_rate
            rate = 8
        else
            rate = 4
        result = false
        random = Math.floor(Math.random() * 100)
        if game.debug.force_fever is true || random <= rate
            result = true
        return result

    ###
    現在所持している部員から作成可能な役を作って返します
    過去にフィーバーになった役は除外します
    @return array role
    メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    ユニット(役):21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:ほのりん、32:ことぱな、33:にこのぞ、34:ことうみ、35:まきりん、36:のぞえり、37:にこまき、38:うみえり
    ###
    getRoleAbleMemberList:()->
        role = []
        allRoles = []
        roleCnt = 0
        returnRoles = {
            21:[14,15,16], 22:[11,12,13], 23:[17,18,19], 24:[11,12,16], 25:[13,15,18], 26:[14,17,19], 27:[15,16,17], 28:[13,14,19],
            31:[11,15], 32:[12,16], 33:[17,18], 34:[12,13], 35:[14,15], 36:[18,19], 37:[14,17], 38:[13,19]
        }
        for roleNum, member of returnRoles
            if game.arrIndexOf(game.item_have_now, member) && game.prev_fever_muse.indexOf(parseInt(roleNum)) is -1
                roleCnt++
                if @prev_osusume_role is 0 || @prev_osusume_role.indexOf(parseInt(roleNum)) is -1
                    allRoles.push(roleNum)
        if 0 < allRoles.length
            random = Math.floor(Math.random() * allRoles.length)
            role = returnRoles[allRoles[random]]
        if 1 < roleCnt
            @prev_osusume_role = allRoles[random]
        else
            @prev_osusume_role = 0
        return role

    betChange:(up)->
        val = 1
        bet = game.bet
        if up is true
            if bet < 10
                val = 1
            else if bet < 100
                val = 10
            else if bet < 1000
                val = 100
            else if bet < 10000
                val = 1000
            else if bet < 100000
                val = 10000
            else if bet < 1000000
                val = 100000
            else if bet < 10000000
                val = 1000000
            else if bet < 100000000
                val = 10000000
            else if bet < 1000000000
                val = 100000000
            else if bet < 10000000000
                val = 1000000000
            else if bet < 10000000000
                val = 1000000000
            else if bet < 10000000000
                val = 1000000000
            else
                val = 10000000000
        else
            if bet <= 10
                val = -1
            else if bet <= 100
                val = -10
            else if bet <= 1000
                val = -100
            else if bet <= 10000
                val = -1000
            else if bet <= 100000
                val = -10000
            else if bet <= 1000000
                val = -100000
            else if bet <= 10000000
                val = -1000000
            else if bet <= 100000000
                val = -10000000
            else if bet <= 1000000000
                val = -100000000
            else if bet <= 10000000000
                val = -1000000000
            else if bet <= 100000000000
                val = -10000000000
            else if bet <= 1000000000000
                val = -100000000000
            else
                val = -1000000000000
        game.bet += val
        if game.bet < 1
            game.bet = 1
        else if game.bet > game.money
            game.bet -= val
        else if game.bet > 100000000000
            game.bet = 100000000000

    ###
    掛け金が所持金を上回った時に掛け金を減らす
    ###
    betDown:()->
        digit = Math.pow(10, (String(game.money).length - 1))
        val = Math.floor(game.money / digit) * digit / 100
        if val < 1
            val = 1
        return val
###
テストコード用
###
class Test extends appNode
    constructor: () ->
        super
        @test_exe_flg = false #テスト実行フラグ、trueだとゲーム呼び出し時にテスト関数を走らせる
    ###
    ここにゲーム呼び出し時に実行するテストを書く
    ###
    testExe:()->
        #@testGetHitRole()
        #@testSetGravity()
        #@viewItemList()
        #@testCutin()
        #@preLoadMulti()
        #@addMuse()
        #@moneyFormat()
        #@itemCatchTension()
        #@chanceTime()
        #@forceFever()
        #@tensionUp()
        #@nextMuse()
        #@getRoleByMemberSetNow()
        #@getRoleAbleMemberList()
        #@betDown()

    #以下、テスト用関数

    testGetHitRole:()->
        result = game.slot_setting.getHitRole(11, 11, 12)
        console.log(result)

    testSetGravity:()->
        param = [1, 5, 10, 50, 100, 500, 1000, 2000, 8000, 9000, 10000, 20000, 80000, 90000, 100000, 200000, 800000, 900000, 1000000]
        for key, val of param
            console.log('****************')
            console.log('bet:'+val)
            game.bet = val
            result = game.slot_setting.setGravity()
            console.log('gravity:'+result)
            console.log('div:'+game.slot_setting.prize_div)
            console.log('prize:'+game.slot_setting.prize_div * val * 50)


    viewItemList:()->
        game.prev_fever_muse.push(15)
        game.prev_fever_muse.push(11)
        game.slot_setting.setMemberItemPrice()
        console.log(game.slot_setting.item_list)

    testCutin:()->
        for i in [1..100]
            game.main_scene.gp_effect.cutInSet()

    preLoadMulti:()->
        game.member_set_now = [17,18,19]
        game.musePreLoadByMemberSetNow()
        console.log(game.already_added_material)

    addMuse:()->
        game.member_set_now = []
        for i in [1..6]
            num = game.slot_setting.getAddMuseNum()
            console.log(num)

    moneyFormat:()->
        console.log(game.toJPUnit(12000012340000))

    itemCatchTension:()->
        game.past_fever_num = 0
        game.tension = 400
        val = game.slot_setting.setTensionItemCatch()
        console.log(val)

    chanceTime:()->
        val = game.slot_setting.setChanceTime()
        console.log(val)

    forceFever:()->
        game.combo = 200
        game.slot_setting.isForceFever()

    tensionUp:()->
        #game.money = 100000
        game.money = 300
        game.item_kind = 1
        #param = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000, 50000]
        param = [1, 2, 3, 5, 10, 30, 50, 100]
        console.log('所持金：'+game.money)
        console.log('おやつ：'+game.item_kind)
        console.log('*******************')
        for key, val of param
            game.bet = val
            console.log('掛け金：'+game.bet)
            result = game.slot_setting.setTensionItemCatch()
            console.log('アイテム取得：'+result)
            result = game.slot_setting.setTensionSlotHit(3)
            console.log('スロット当たり：'+result)
            result = game.slot_setting.setTensionItemFall()
            console.log('アイテム落下：'+result)
            result = game.slot_setting.setTensionMissItem()
            console.log('ニンニク：'+result)
            console.log('*******************')

    nextMuse:()->
        console.log(game.member_set_now)
        console.log(game.slot_setting.now_muse_num)
        for i in [1..6]
            num = game.slot_setting.getAddMuseNum()
            console.log(num)

    getRoleByMemberSetNow:()->
        console.log(game.member_set_now)
        console.log(game.slot_setting.now_muse_num)
        role = game.getRoleByMemberSetNow()
        console.log(role)

    getRoleAbleMemberList:()->
        console.log(game.item_have_now)
        role = game.slot_setting.getRoleAbleMemberList()
        console.log(role)

    betDown:()->
        game.money = 8549655214758
        console.log(game.money)
        val = game.slot_setting.betDown()
        console.log(val)
class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = '#93F0FF'
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false, 'white':false}
        #ソフトキーのリスト
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        #ジャイロセンサのリスト
        @gyroList = {'left':false, 'right':false}
        @bgm = game.soundload("bgm/bgm1")
        @initial()
    initial:()->
        @setGroup()
        if game.isSumaho()
            @_gyroMove()
    setGroup:()->
        @gp_back_panorama = new gpBackPanorama()
        @addChild(@gp_back_panorama)
        @gp_front_panorama = new gpFrontPanorama()
        @addChild(@gp_front_panorama)
        @gp_stage_back = new stageBack()
        @addChild(@gp_stage_back)
        @gp_slot = new gpSlot()
        @addChild(@gp_slot)
        @gp_effect = new gpEffect()
        @addChild(@gp_effect)
        @gp_stage_front = new stageFront()
        @addChild(@gp_stage_front)
        @gp_system = new gpSystem()
        @addChild(@gp_system)
        @gp_slot.x = 55
        @gp_slot.y = 130
    onenterframe: (e) ->
        @buttonPush()
        @tensionSetValueFever()
    ###ボタン操作、物理キーとソフトキー両方に対応###
    buttonPush:()->
        # 左
        if game.input.left is true || @buttonList.left is true || (@buttonList.right is false && @gyroList.left is true)
            if @keyList.left is false
                @keyList.left = true
                @gp_system.left_button.changePushColor()
        else
            if @keyList.left is true
                @keyList.left = false
                @gp_system.left_button.changePullColor()
        # 右
        if game.input.right is true || @buttonList.right is true || (@buttonList.left is false && @gyroList.right is true)
            if @keyList.right is false
                @keyList.right = true
                @gp_system.right_button.changePushColor()
        else
            if @keyList.right is true
                @keyList.right = false
                @gp_system.right_button.changePullColor()
        # 上
        if game.input.up is true || @buttonList.up is true
            if @keyList.up is false
                @keyList.up = true
                @gp_system.heigh_bet_button.changePushColor()
        else
            if @keyList.up is true
                @keyList.up = false
                @gp_system.heigh_bet_button.changePullColor()
        # 下
        if game.input.down is true || @buttonList.down is true
            if @keyList.down is false
                @keyList.down = true
                @gp_system.low_bet_button.changePushColor()
        else
            if @keyList.down is true
                @keyList.down = false
                @gp_system.low_bet_button.changePullColor()
        # ジャンプ
        if game.input.z is true || @buttonList.jump is true
            if @keyList.jump is false
                @keyList.jump = true
                @gp_system.jump_button.changePushColor()
        else
            if @keyList.jump is true
                @keyList.jump = false
                @gp_system.jump_button.changePullColor()
        #ポーズ
        if game.input.x is true || @buttonList.pause is true
            if @keyList.pause is false
                game.setPauseScene()
                @keyList.pause = true
        else
            if @keyList.pause is true
                @keyList.pause = false
        #画面ホワイトアウト
        if game.input.c is true
            if @keyList.white is false
                @gp_system.whiteOut()
                @keyList.white = true
        else
            if @keyList.white is true
                @keyList.white = false

    ###
    フィーバー中に一定時間でテンションが下がる
    テンションが0になったらフィーバーを解く
    ###
    tensionSetValueFever:()->
        if game.fever is true
            game.tensionSetValue(game.fever_down_tension)
            if game.tension <= 0
                game.autoMemberSetAfeterFever()
                game.main_scene.gp_slot.upperFrame.frame = 0
                game.pause_scene.pause_main_layer.save_game_button.makeAble()
                game.bgmStop(game.main_scene.gp_slot.fever_bgm)
                #game.bgmPlay(@bgm, true)
                @gp_system.changeBetChangeFlg(true)
                @gp_effect.feverEffectEnd()
                game.fever = false

    _gyroMove:()->
        window.addEventListener("deviceorientation",
            (evt)->
                x = evt.gamma
                if 15 < x
                    game.main_scene.gyroList.right = true
                else if x < -15
                    game.main_scene.gyroList.left = true
                else
                    game.main_scene.gyroList.right = false
                    game.main_scene.gyroList.left = false
            , false
        )
class pauseScene extends appScene
    constructor: () ->
        super
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @buttonList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @pause_back = new pauseBack()
        @pause_main_layer = new pauseMainLayer()
        @pause_save_confirm_layer = new pauseSaveConfirmLayer()
        @pause_save_layer = new pauseSaveLayer()
        @pause_title_confirm_layer = new pauseTitleConfirmLayer()
        @pause_item_buy_layer = new pauseItemBuyLayer()
        @pause_item_use_layer = new pauseItemUseLayer()
        @pause_member_set_layer = new pauseMemberSetLayer()
        @pause_item_buy_select_layer = new pauseItemBuySelectLayer()
        @pause_item_use_select_layer = new pauseItemUseSelectLayer()
        @pause_member_use_select_layer = new pauseMemberUseSelectLayer()
        @pause_record_layer = new pauseRecordLayer()
        @pause_record_select_layer = new pauseRecordSelectLayer()
        @pause_trophy_select_layer = new pauseTrophySelectLayer()
        @addChild(@pause_back)
        @addChild(@pause_main_layer)
        @isAblePopPause = true
    setSaveConfirmMenu: () ->
        @pause_save_confirm_layer = new pauseSaveConfirmLayer()
        @addChild(@pause_save_confirm_layer)
        @isAblePopPause = false
    setSaveMenu:()->
        @pause_save_layer = new pauseSaveLayer()
        @addChild(@pause_save_layer)
        game.saveGame()
    setTitleConfirmMenu:()->
        @pause_title_confirm_layer = new pauseTitleConfirmLayer()
        @addChild(@pause_title_confirm_layer)
        @isAblePopPause = false
    removeSaveConfirmMenu:()->
        @removeChild(@pause_save_confirm_layer)
        @pause_save_confirm_layer = null
        @isAblePopPause = true
    removeTitleConfirmMenu:()->
        @removeChild(@pause_title_confirm_layer)
        @pause_title_confirm_layer = null
        @isAblePopPause = true
    removeSaveMenu:()->
        @removeChild(@pause_save_layer)
        @removeChild(@pause_save_confirm_layer)
        @pause_save_layer = null
        @pause_save_confirm_layer = null
        @isAblePopPause = true
    setItemBuyMenu:()->
        @pause_item_buy_layer = new pauseItemBuyLayer()
        @addChild(@pause_item_buy_layer)
        @isAblePopPause = false
    removeItemBuyMenu:()->
        @removeChild(@pause_item_buy_layer)
        @isAblePopPause = true
        game.setItemSlot()
    setItemUseMenu:()->
        @pause_item_use_layer = new pauseItemUseLayer()
        @pause_item_use_layer.resetItemList()
        @pause_item_use_layer.dspSetItemList()
        @addChild(@pause_item_use_layer)
        @isAblePopPause = false
    removeItemUseMenu:()->
        @removeChild(@pause_item_use_layer)
        @pause_item_use_layer = null
        @isAblePopPause = true
    setMemberSetMenu:()->
        @pause_member_set_layer = new pauseMemberSetLayer()
        @pause_member_set_layer.resetItemList()
        @addChild(@pause_member_set_layer)
        @isAblePopPause = false
    removeMemberSetMenu:()->
        @removeChild(@pause_member_set_layer)
        @pause_member_set_layer = null
        game.musePreLoadByMemberSetNow()
        @isAblePopPause = true
    setItemBuySelectMenu:(kind)->
        @pause_item_buy_select_layer = new pauseItemBuySelectLayer()
        @addChild(@pause_item_buy_select_layer)
        @pause_item_buy_select_layer.setSelectItem(kind)
    removeItemBuySelectMenu:()->
        @removeChild(@pause_item_buy_select_layer)
        @pause_item_buy_select_layer = null
        game.itemUseExe()
    setItemUseSelectMenu:(kind)->
        @pause_item_use_select_layer = new pauseItemUseSelectLayer()
        @addChild(@pause_item_use_select_layer)
        @pause_item_use_select_layer.setSelectItem(kind)
    removeItemUseSelectMenu:()->
        @removeChild(@pause_item_use_select_layer)
        @pause_item_use_select_layer = null
        game.itemUseExe()
    setMemberUseSelectMenu:(kind)->
        @pause_member_use_select_layer = new pauseMemberUseSelectLayer()
        @addChild(@pause_member_use_select_layer)
        @pause_member_use_select_layer.setSelectItem(kind)
    removeMemberUseSelectMenu:()->
        @removeChild(@pause_member_use_select_layer)
        @pause_member_use_select_layer = null
    setRecordMenu:()->
        @pause_record_layer = new pauseRecordLayer()
        @addChild(@pause_record_layer)
        @isAblePopPause = false
    removeRecordMenu:()->
        @removeChild(@pause_record_layer)
        @pause_record_layer = null
        @isAblePopPause = true
    setRecordSelectMenu:(kind)->
        @pause_record_select_layer = new pauseRecordSelectLayer()
        @addChild(@pause_record_select_layer)
        @pause_record_select_layer.setSelectItem(kind)
    removeRecordSelectMenu:()->
        @removeChild(@pause_record_select_layer)
        @pause_record_select_layer = null
    setTrophySelectMenu:(kind)->
        @pause_trophy_select_layer = new pauseTrophySelectLayer()
        @addChild(@pause_trophy_select_layer)
        @pause_trophy_select_layer.setSelectItem(kind)
    removeTrophySelectmenu:()->
        @removeChild(@pause_trophy_select_layer)
        @pause_trophy_select_layer = null
    onenterframe: (e) ->
        @_pauseKeyPush()
    ###
    ポーズキーまたはポーズボタンを押した時の動作
    ###
    _pauseKeyPush:()->
        if game.input.x is true || @buttonList.pause is true
            if @keyList.pause is false
                if @isAblePopPause is true
                    game.popPauseScene()
                @keyList.pause = true
        else
            if @keyList.pause = true
                @keyList.pause = false

###
テスト用、空のシーン
###
class testScene extends appScene
    constructor: () ->
        super
class titleScene extends appScene
    constructor: () ->
        super
        @title_main_layer = new titleMainLayer()
        @addChild(@title_main_layer)
class backGround extends appSprite
    constructor: (w, h) ->
        super w, h
class Floor extends backGround
    constructor: (w, h) ->
        super w, h
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
class effect extends appSprite
    constructor: (w, h) ->
        super w, h
###
カットインの画像サイズ、頭の位置で760px
###
class cutIn extends effect
    constructor: (num = 0) ->
        @_callCutIn(num)
        super @cut_in['width'], @cut_in['height']
        @_setInit()

    onenterframe: (e) ->
        if @age - @set_age is @fast
            @vx = @_setVxSlow()
        if @age - @set_age is @slow
            @vx = @_setVxFast()
        @x += @vx
        if (@cut_in['direction'] is 'left' && @x < -@w) || (@cut_in['direction'] is 'left' is 'right' && @x > game.width)
            game.main_scene.gp_effect.removeChild(@)

    _callCutIn:(num)->
        setting = game.slot_setting
        if num is 0
            muse_num = setting.now_muse_num
        else
            muse_num = num
        cut_in_list = setting.muse_material_list[muse_num]['cut_in']
        cut_in_random = Math.floor(Math.random() * cut_in_list.length)
        @cut_in = cut_in_list[cut_in_random]
        @voices = setting.muse_material_list[muse_num]['voice']

    _setInit:()->
        @image = game.imageload('cut_in/'+@cut_in['name'])
        if @cut_in['direction'] is 'left'
            @x = game.width
        else
            @x = -@w
        @y = game.height - @h
        @vx = @_setVxFast()
        game.main_scene.gp_stage_front.setItemFallFrm(6)
        @set_age = @age
        @fast = 0.5 * game.fps
        @slow = 2 * game.fps + @fast
        @voice = @_setVoice()

    _setVxFast:()->
        val = Math.round(((game.width + @w) / 2) / (0.5 * game.fps))
        if @cut_in['direction'] is 'left'
            val *= -1
        return val

    _setVxSlow:()->
        if @voice != false
            game.sePlay(@voice)
        val = Math.round((game.width / 4) / (2 * game.fps))
        if @cut_in['direction'] is 'left'
            val *= -1
        return val

    _setVoice:()->
        if @voices.length > 0
            random = Math.floor(Math.random() * @voices.length)
            voice = game.soundload('voice/'+@voices[random])
        else
            voice = game.soundload('clear')
        return voice
###
演出
###
class performanceEffect extends effect
    constructor: (w, h) ->
        super w, h
###
チャンス
###
class chanceEffect extends performanceEffect
    constructor:()->
        super 237, 50
        @image = game.imageload("chance")
        @y = 290
        @x = game.width
        @existTime = 2
        @sound = game.soundload('clear')
    onenterframe: (e) ->
        if @age - @set_age is @fast_age
            game.sePlay(@sound)
            @vx = @_setVxSlow()
        if @age - @set_age is @slow_age
            @vx = @_setVxFast()
        @x += @vx
        if @x + @w < 0
            game.main_scene.gp_slot.endForceSlotHit()
            game.main_scene.gp_effect.removeChild(@)
    setInit:()->
        @existTime = game.slot_setting.setChanceTime()
        @x = game.width
        @vx = @_setVxFast()
        @set_age = @age
        @fast_age = Math.round(0.3 * game.fps)
        @slow_age = Math.round(@existTime * game.fps) + @fast_age
    _setVxFast:()->
        return Math.round(((game.width + @w) / 2) / (0.3 * game.fps)) * -1
    _setVxSlow:()->
        return Math.round(((game.width - @w) / 4) / (@existTime * game.fps)) * -1

###
フィーバー
###
class feverEffect extends performanceEffect
    constructor:()->
        super 190, 50
        @image = game.imageload("fever")
        @y = 290
        @x = (game.width - @w) / 2
        @frame = 0
class feverOverlay extends feverEffect
    constructor:()->
        super
        @frame = 1
        @opacity_frm = Math.floor(100 / game.fps) / 100
    setInit:()->
        @opacity = 0
    onenterframe: (e) ->
        @opacity += @opacity_frm
        if @opacity < 0
            @opacity = 0
            @opacity_frm *= -1
        if 1 < @opacity
            @opacity = 1
            @opacity_frm *= -1

###
キラキラ
###
class kirakiraEffect extends performanceEffect
    constructor:()->
        super 50, 50
        @image = game.imageload("kira")
        @flashPeriodFrm = game.fps #光ってる間の時間
        @setInit()
    setInit:()->
        @x = Math.floor(Math.random() * game.width)
        @y = Math.floor(Math.random() * game.height)
        @randomPeriodFrm = Math.floor(Math.random() * 3 * game.fps) #次に光るまでの時間
        @halfFrm = @randomPeriodFrm + Math.round(@flashPeriodFrm / 2)
        @totalFrm = @randomPeriodFrm + @flashPeriodFrm
        randomSize = Math.floor(Math.random() * 30) + 20
        @scaleV = Math.floor((randomSize / 50) * 200 / @flashPeriodFrm) / 100 #1フレーム当たりに変わるサイズ
        @opacityV = Math.floor((Math.random() * 50 + 50) * 2 / @flashPeriodFrm) / 100 #1フレームあたりに変わる透明度
        @scaleX = 0
        @scaleY = 0
        @opacity = 0
    onenterframe: (e) ->
        unitAge = @age % @totalFrm
        if unitAge < @randomPeriodFrm
        else if unitAge < @halfFrm
            @scaleX += @scaleV
            @scaleY += @scaleV
            @opacity += @opacityV
        else if unitAge < @totalFrm
            @scaleX -= @scaleV
            @scaleY -= @scaleV
            @opacity -= @opacityV
            if @scaleX < 0
                @scaleX = 0
            if @scaleY < 0
                @scaleY = 0
            if @opacity < 0
                @opacity = 0
        else if unitAge is 0
            @setInit()

###
背景のレイヤーに表示するエフェクト
###
class panoramaEffect extends backGround
    constructor:(w, h)->
        super w,h
        @x_init = 0
        @y_init = game.height - Math.floor(310 / 2)
    setInit:()->
        @age = 0
        @x = @x_init
        @y = @y_init
###
進撃のことり
###
class bigKotori extends panoramaEffect
    constructor:()->
        super 365, 360
        @image = game.imageload('big-kotori')
        @x_init = -@w
        @move_sec = 20
        @wait_sec = 20
        @v = Math.floor(@w * 10 / (@move_sec * game.fps)) / 10
        @wait_start_frm = @move_sec * game.fps
        @wait_end_frm = (@move_sec + @wait_sec) * game.fps
        @move_end_frm = (@move_sec * 2 + @wait_sec) * game.fps
    onenterframe:()->
        if 0 <= @age && @age < @wait_start_frm
            @x += @v
            @y -= @v
        else if @wait_end_frm <= @age && @age < @move_end_frm
            @x -= @v
            @y += @v
        else if @age is @move_end_frm
            game.main_scene.gp_back_panorama.endBigKotori()

###
アイテムを取った時、弾けるエフェクト
###
class itemCatchEffect extends performanceEffect
    constructor:(num, x, y)->
        super 50, 47
        @image = game.imageload('heart')
        view_sec = 1
        @vx = Math.floor((80 * 10) / (view_sec * game.fps)) / 10
        if num % 2 is 0
            @vx *= -1
        @opacityV = Math.floor(100 / (view_sec * game.fps)) / 100
        unit = Math.floor(((num - 1) / 2))
        @gravity = 0.9 + unit * 0.4
        vy_init = -10 - unit * 6
        scale_init = 0.2
        @scaleV = Math.floor(((1 - scale_init - (unit * 0.1)) * 100) / (view_sec * game.fps)) / 100
        @scaleX = scale_init
        @scaleY = scale_init
        @opacity = 1
        @x = x + 5
        @y = y
        @vy = vy_init
    onenterframe:()->
        @x += @vx
        @vy += @gravity
        @y += @vy
        @opacity -= @opacityV
        @scaleX += @scaleV
        @scaleY += @scaleV
        if @opacity < 0
            @remove()
    remove:()->
        game.main_scene.gp_effect.removeChild(@)

###
爆発
###
class explosionEffect extends performanceEffect
    constructor:()->
        super 100, 100
        @image = game.imageload('explosion')
        @explosion_se = game.soundload('explosion')
        @view_frm = Math.floor(0.6 * game.fps)
        @view_frm_half = Math.floor(@view_frm / 2)
        @vy = Math.floor(50 * 10 / @view_frm) / 10
        @opacityV = Math.floor(100 / (@view_frm_half)) / 100
        @scale_init = 0.2
        @scaleV = Math.floor(((1 - @scale_init) * 100) / @view_frm_half) / 100
    setInit:(x, y)->
        @x = x - 10
        @y = y - 30
        @scaleX = @scale_init
        @scaleY = @scale_init
        @opacity = 1
        @age = 0
        game.sePlay(@explosion_se)
    onenterframe:()->
        if @age <= @view_frm
            @y -= @vy
            if @age <= @view_frm_half
                @scaleX += @scaleV
                @scaleY += @scaleV
            else
                @opacity -= @opacityV
        if @opacity < 0
            @remove()
    remove:()->
        game.main_scene.gp_stage_front.removeChild(@)

class appObject extends appSprite
    ###
    制約
    ・objectは必ずstageに対して追加する
    ###
    constructor: (w, h) ->
        super w, h
        @gravity = 1.2 #物体に働く重力
        @friction = 1.7 #物体に働く摩擦
class Character extends appObject
    constructor: (w, h) ->
        super w, h
        # キャラクターの動作を操作するフラグ
        @moveFlg = {'left':false, 'right':false, 'jump':false}
        @jump_se = game.soundload('jump')
        @isAir = true; #空中判定
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
        @ax = 3 #x軸加速度
        @mx = 7 #x軸速度最大値
        @my = 19 #y軸初速度
        @ax_init = 3
        @ax_up = 5
        @ax_up2 = 7
        @ax_up3 = 9
        @mx_init = 7
        @mx_up = 11
        @mx_up2 = 15
        @mx_up3 = 19
        @my_init = 19
        @my_up = 22
        @my_up2 = 25
        @my_up3 = 28
        @friction_init = 1.7
        @friction_up = 3
        @friction_up2 = 4.5
        @friction_up3 = 6
    onenterframe: (e) ->
        @charMove()

    ###キャラクターの動き###
    charMove:()->
        vx = @vx
        vy = @vy
        if @isAir is true
            vy = @_speedHeight(vy)
            vx = @_speedWidthAir(vx)
        else
            vx = @_speedWidthFloor(vx)
            vy = @_separateFloor()
        @_moveExe(vx, vy)
        @_direction()
        @_animation()

    ###
    地面にいるキャラクターを地面から離す
    ジャンプボタンをおした時、足場から離れた時など
    ###
    _separateFloor:()->
        vy = 0
        if @moveFlg.jump is true
            @jumpSound()
            vy -= @my
            @isAir = true
        return vy

    jumpSound:()->

    ###
    地面にいるときの横向きの速度を決める
    @vx num x軸速度
    @return num
    ###
    _speedWidthFloor:(vx)->
        if @moveFlg.right is true && @stopAtRight() is true
            if vx < 0
                vx = 0
            else if vx < @mx
                vx += @ax
        else if @moveFlg.left is true && @stopAtLeft() is true
            if vx > 0
                vx = 0
            else if vx > @mx * -1
                vx -= @ax
        else
            if vx > 0
                vx -= @friction
                if vx < 0
                    vx = 0
            if vx < 0
                vx += @friction
                if vx > 0
                    vx = 0
        vx = @stopAtEnd(vx)
        return vx

    ###
    空中にいるときの横向きの速度を決める
    @vy num y軸速度
    @return num
    ###
    _speedWidthAir:(vx)->
        vx = @stopAtEnd(vx)
        return vx

    ###
    画面端では横向きの速度を0にする
    @param num vx ｘ軸速度
    ###
    stopAtEnd:(vx)->
        return vx

    ###
    画面右端で右に移動するのを許可しない
    ###
    stopAtRight:()->
        return true

    ###
    画面左端で左に移動するのを許可しない
    ###
    stopAtLeft:()->
        return true

    ###
    縦向きの速度を決める
    @vy num y軸速度
    @return num
    ###
    _speedHeight:(vy) ->
        vy += @gravity
        #上昇
        if vy < 0
            if @moveFlg.jump is false
                vy = 0
        #下降
        else
            if @_crossFloor() is true
                vy = 0
        return vy

    ###地面にめり込んでる時trueを返す###
    _crossFloor:()->
        flg = false
        if @vy > 0 && @y + @h > game.main_scene.gp_stage_front.floor
            flg = true
        return flg

    ###
    動きの実行
    @ｖx num x軸速度
    @vy num y軸速度
    ###
    _moveExe:(vx, vy)->
        velocityX = 0
        velocityY = 0
        if vx > 0
            velocityX = Math.floor(vx)
        else
            velocityX = Math.ceil(vx)
        if vy > 0
            velocityY = Math.floor(vy)
        else
            velocityY = Math.ceil(vy)
        @vx = vx
        @vy = vy
        @x += velocityX
        @y += velocityY
        if @isAir is true && @_crossFloor() is true
            @vy = 0
            @y = game.main_scene.gp_stage_front.floor - @h
            @isAir = false

    ###
    ボタンを押している方向を向く
    ###
    _direction:()->
        if @moveFlg.right is true && @scaleX < 0
            @scaleX *= -1
        else if @moveFlg.left is true && @scaleX > 0
            @scaleX *= -1

    ###
    アニメーションする
    ###
    _animation:()->
        if @isAir is false
            if @vx is 0
                @frame = 0
            else
                tmpAge = @age % 10
                if tmpAge <= 5
                    @frame = 1
                else
                    @frame = 2
        else
            @frame = 3

    setMxUp:()->
        if game.isItemHave(21) && game.isItemHave(23)
            @mx = @mx_up3
            @ax = @ax_up3
            @friction = @friction_up3
        else if game.isItemHave(21) || game.isItemHave(23)
            @mx = @mx_up2
            @ax = @ax_up2
            @friction = @friction_up2
        else
            @mx = @mx_up
            @ax = @ax_up
            @friction = @friction_up

    resetMxUp:()->
        if game.isItemHave(21) && game.isItemHave(23)
            @mx = @mx_up2
            @ax = @ax_up2
            @friction = @friction_up2
        else if game.isItemHave(21) || game.isItemHave(23)
            @mx = @mx_up
            @ax = @ax_up
            @friction = @friction_up
        else
            @mx = @mx_init
            @ax = @ax_init
            @friction = @friction_init

    setMyUp:()->
        if game.isItemHave(21) && game.isItemHave(23)
            @my = @my_up3
        else if game.isItemHave(21) || game.isItemHave(23)
            @my = @my_up2
        else
            @my = @my_up

    resetMyUp:()->
        if game.isItemHave(21) && game.isItemHave(23)
            @my = @my_up2
        else if game.isItemHave(21) || game.isItemHave(23)
            @my = @my_up
        else
            @my = @my_init

class Guest extends Character
    constructor: (w, h) ->
        super w, h
class Player extends Character
    constructor: (w, h) ->
        super w, h
        @addEventListener("enterframe", ()->
            @keyMove()
        )
    ###キーを押した時の動作###
    keyMove:()->
        # 左
        if game.main_scene.keyList.left is true
            if @moveFlg.left is false
                @moveFlg.left = true
        else
            if @moveFlg.left is true
                @moveFlg.left = false
        # 右
        if game.main_scene.keyList.right is true
            if @moveFlg.right is false
                @moveFlg.right = true
        else
            if @moveFlg.right is true
                @moveFlg.right = false
        # ジャンプ
        if game.main_scene.keyList.jump is true
            if @moveFlg.jump is false
                @moveFlg.jump = true
        else
            if @moveFlg.jump is true
                @moveFlg.jump = false

    ###
    画面端では横向きの速度を0にする
    @param num vx ｘ軸速度
    ###
    stopAtEnd:(vx)->
        if 0 != @vx
            if @x <= 0
                vx = 0
            if @x + @w >= game.width
                vx = 0
        return vx

    ###
    画面右端で右に移動するのを許可しない
    ###
    stopAtRight:()->
        flg = true
        if @x + @w >= game.width
            flg = false
        return flg

    ###
    画面左端で左に移動するのを許可しない
    ###
    stopAtLeft:()->
        flg = true
        if @x <= 0
            flg = false
        return flg

    jumpSound:()->
        game.sePlay(@jump_se)

class Bear extends Player
    constructor: () ->
        super 67, 65
        @image = game.imageload("chun")
        @x = 0
        @y = 0
class Item extends appObject
    constructor: (w, h) ->
        super w, h
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
###
キャッチする用のアイテム
###
class Catch extends Item
    constructor: (w, h) ->
        super w, h
        @miss_se = game.soundload('cancel')
    onenterframe: (e) ->
        @vy += @gravity
        @y += @vy
        @hitPlayer()
        @removeOnFloor()
    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            game.main_scene.gp_effect.setItemChatchEffect(@x, @y)
            game.main_scene.gp_stage_front.removeChild(@)
            game.combo += 1
            if game.combo > game.max_combo
                game.max_combo = game.combo
            game.main_scene.gp_system.combo_text.setValue()
            game.main_scene.gp_slot.slotStop()
            game.tensionSetValueItemCatch()

    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            game.sePlay(@miss_se)
            game.main_scene.gp_stage_front.removeChild(@)
            if game.isItemSet(6) is false
                game.combo = 0
            game.main_scene.gp_system.combo_text.setValue()
            game.tensionSetValueItemFall()

    ###
    座標と落下速度の設定
    ###
    setPosition:()->
        @y = @h * -1
        @x = @setPositoinX()
        @frame = game.slot_setting.getCatchItemFrame()
        @gravity = game.slot_setting.setGravity()

    ###
    X座標の位置の設定
    ###
    setPositoinX:()->
        ret_x = 0
        if game.debug.item_flg
            ret_x = game.main_scene.gp_stage_front.player.x
        else
            ret_x = Math.floor((game.width - @w) * Math.random())
        if game.isItemSet(9)
            ret_x = Math.floor(game.main_scene.gp_stage_front.player.x + (game.width * 0.5 * Math.random()) - (game.width * 0.25))
            if ret_x < 0
                ret_x = 0
            if ret_x > (game.width - @w)
                ret_x = game.width - @w
        return ret_x

###
マカロン
###
class MacaroonCatch extends Catch
    constructor: (w, h) ->
        super 37, 37
        @image = game.imageload("sweets")
        @frame = 1
        @scaleX = 1.5
        @scaleY = 1.5

class OnionCatch extends Catch
    constructor: (w, h) ->
        super 37, 37
        @image = game.imageload("sweets")
        @frame = 5
        @scaleX = 1.5
        @scaleY = 1.5
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            game.main_scene.gp_stage_front.setExplosionEffect(@x, @y)
            game.sePlay(@miss_se)
            game.main_scene.gp_stage_front.removeChild(@)
            game.tensionSetValueMissItemCatch()
            game.main_scene.gp_stage_front.player.vx = 0
            game.main_scene.gp_stage_front.player.vy = 0
    removeOnFloor:()->
        if @y > game.height + @h
            game.main_scene.gp_stage_front.removeChild(@)
    setPosition:()->
        @y = @h * -1
        @x = @setPositoinX()
        @gravity = game.slot_setting.setGravity()
###
降ってくるお金
@param boolean isHoming trueならコインがホーミングする
###
class Money extends Item
    constructor: (isHoming, width, height) ->
        super width, height
        @vx = 0
        @vy = 0
        @frame_init = 0
        @price = 1 #単価
        @gravity = 0.37
        @image = game.imageload("coin")
        @catch_se = game.soundload("medal")
        @isHoming = isHoming
        @_setGravity()

    onenterframe: (e) ->
        @homing()
        @_animation()
        @vy += @gravity
        @y += @vy
        @x += @vx
        @hitPlayer()
        @removeOnFloor()

    _setGravity:()->
        if @isHoming is true
            @gravity = 1.5
    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            game.sePlay(@catch_se)
            game.main_scene.gp_stage_back.removeChild(@)
            game.money += @price
            game.main_scene.gp_system.money_text.setValue()

    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            game.main_scene.gp_stage_back.removeChild(@)

    setPosition:()->
        @y = @h * -1
        @x = Math.floor((game.width - @w) * Math.random())

    ###
    ホーミングする
    ###
    homing:()->
        if @isHoming is true
            @vx = Math.round( (game.main_scene.gp_stage_front.player.x - @x) / ((game.main_scene.gp_stage_front.player.y - @y) / @vy) )

    _animation:()->
        tmp_frm = @age % 24
        switch tmp_frm
            when 0
                @scaleX *= -1
                @frame = @frame_init
            when 3
                @frame = @frame_init + 1
            when 6
                @frame = @frame_init + 2
            when 9
                @frame = @frame_init + 3
            when 12
                @scaleX *= -1
                @frame = @frame_init + 3
            when 15
                @frame = @frame_init + 2
            when 18
                @frame = @frame_init + 1
            when 21
                @frame = @frame_init



###
1円
@param boolean isHoming trueならコインがホーミングする
###
class OneMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 1
        @frame = 0
        @frame_init = 0

###
10円
@param boolean isHoming trueならコインがホーミングする
###
class TenMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 10
        @frame = 0
        @frame_init = 0

###
100円
@param boolean isHoming trueならコインがホーミングする
###
class HundredMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 100
        @frame = 4
        @frame_init = 4

###
1000円
@param boolean isHoming trueならコインがホーミングする
###
class ThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 1000
        @frame = 4
        @frame_init = 4

###
一万円
@param boolean isHoming trueならコインがホーミングする
###
class TenThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 10000
        @frame = 8
        @frame_init = 8

###
10万円
@param boolean isHoming trueならコインがホーミングする
###
class HundredThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 26, 30
        @price = 100000
        @frame = 8
        @frame_init = 8

###
100万円
@param boolean isHoming trueならコインがホーミングする
###
class OneMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 1000000
        @frame = 0
        @frame_init = 0

###
1000万円
@param boolean isHoming trueならコインがホーミングする
###
class TenMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 10000000
        @frame = 0
        @frame_init = 0

###
1億円
@param boolean isHoming trueならコインがホーミングする
###
class OneHundredMillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 100000000
        @frame = 4
        @frame_init = 4

###
10億円
@param boolean isHoming trueならコインがホーミングする
###
class BillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 1000000000
        @frame = 4
        @frame_init = 4

###
100億円
@param boolean isHoming trueならコインがホーミングする
###
class TenBillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 10000000000
        @frame = 8
        @frame_init = 8

###
1000億円
@param boolean isHoming trueならコインがホーミングする
###
class OneHundredBillionMoney extends Money
    constructor: (isHoming) ->
        super isHoming, 30, 30
        @image = game.imageload("coin_pla")
        @price = 100000000000
        @frame = 8
        @frame_init = 8
class Slot extends appSprite
    constructor: (w, h) ->
        super w, h
class Frame extends Slot
    constructor: (w, h) ->
        super w, h

class UnderFrame extends Frame
    constructor: (w,h) ->
        super 369, 123
        @image = @drawRect('white')

class UpperFrame extends Frame
    constructor: (w,h) ->
        super 381, 135
        @image = game.imageload("frame")
        @x = -6
        @y = -6
class Lille extends Slot
    constructor: (w, h) ->
        super 123, 123
        @image = game.imageload("lille")
        @lotate_se = game.soundload('select')
        @lilleArray = [] #リールの並び
        @isRotation = false #trueならリールが回転中
        @nowEye = 0 #リールの現在の目
    onenterframe: (e) ->
        if @isRotation is true
            @eyeIncriment()
            #@soundLotateSe()
    ###
    回転中にリールの目を１つ進める
    ###
    eyeIncriment: () ->
        @nowEye += 1
        if @lilleArray[@nowEye] is undefined
            @nowEye = 0
        @frameChange()

    soundLotateSe:()->

    frameChange:()->
        @frame = @lilleArray[@nowEye]

    rotationStop: ()->
        @isRotation = false

    ###
    初回リールの位置をランダムに決める
    ###
    eyeInit: () ->
        @nowEye = Math.floor(Math.random() * @lilleArray.length)
        @eyeIncriment()

class LeftLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.arrayCopy(game.slot_setting.lille_array_0[0])
        @eyeInit()
        @x = 0

class MiddleLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.arrayCopy(game.slot_setting.lille_array_0[1])
        @eyeInit()
        @x = 123

class RightLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.arrayCopy(game.slot_setting.lille_array_0[2])
        @eyeInit()
        @x = 246
    soundLotateSe:()->
        if @age % 2 is 0
            game.sePlay(@lotate_se)
class System extends appSprite
    constructor: (w, h) ->
        super w, h
class Button extends System
    constructor: (w, h) ->
        super w, h
    touchendEvent:() ->

###
ポーズボタン
###
class pauseButton extends Button
    constructor: () ->
        super 36, 36
        @image = game.imageload("pause")
        @x = 430
        @y = 76
    ontouchend: (e)->
        game.setPauseScene()

###
コントローラボタン
###
class controllerButton extends Button
    constructor: () ->
        super 60, 60
        @color = "#888"
        @pushColor = "#333"
        @opacity = 0.4
        @x = 0
        @y = 650
    changePushColor: () ->
        @image = @drawLeftTriangle(@pushColor)
    changePullColor: () ->
        @image = @drawLeftTriangle(@color)

###
左ボタン
###
class leftButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @x = 30
    ontouchstart: () ->
        game.main_scene.buttonList.left = true
    ontouchend: () ->
        game.main_scene.buttonList.left = false

class largeLeftButton extends Button
    constructor: () ->
        super 150 ,100
        @x = 0
        @y = game.height - @height
    ontouchstart: () ->
        game.main_scene.buttonList.left = true
    ontouchend: () ->
        game.main_scene.buttonList.left = false

###
右ボタン
###
class rightButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @scaleX = -1
        @x = game.width - @w - 40
    ontouchstart: () ->
        game.main_scene.buttonList.right = true
    ontouchend: () ->
        game.main_scene.buttonList.right = false

class largeRightButton extends Button
    constructor: () ->
        super 150 ,100
        @x = game.width - @width
        @y = game.height - @height
    ontouchstart: () ->
        game.main_scene.buttonList.right = true
    ontouchend: () ->
        game.main_scene.buttonList.right = false

###
ジャンプボタン
###
class jumpButton extends controllerButton
    constructor: () ->
        super
        @image = @drawCircle(@color)
        @x = (game.width - @w) / 2
    ontouchstart: () ->
        game.main_scene.buttonList.jump = true
    ontouchend: () ->
        game.main_scene.buttonList.jump = false
    changePushColor: () ->
        @image = @drawCircle(@pushColor)
    changePullColor: () ->
        @image = @drawCircle(@color)

class largeJumpButton extends Button
    constructor: () ->
        super game.width, 400
        @x = 0
        @y = 230
    ontouchstart: () ->
        game.main_scene.buttonList.jump = true
    ontouchend: () ->
        game.main_scene.buttonList.jump = false

###
掛け金変更ボタン
###
class betButton extends Button
    constructor: (width, height) ->
        super width, height
        @color = "black"
        @pushColor = "white"
        @y = 7
    changePushColor: () ->
        @image = @drawUpTriangle(@pushColor)
    changePullColor: () ->
        @image = @drawUpTriangle(@color)

###
掛け金を増やすボタン
###
class heighBetButton extends betButton
    constructor: () ->
        super 22, 22
        @image = @drawUpTriangle(@color)
        @x = 7
    ontouchstart: () ->
        game.main_scene.buttonList.up = true
    ontouchend: () ->
        game.main_scene.buttonList.up = false

class heighBetButtonPause extends betButton
    constructor: () ->
        super 33, 33
        @image = @drawUpTriangle(@color)
        @x = 90
        @y = 270
    ontouchend: () ->
        game.pause_scene.pause_main_layer.betSetting(true)

###
掛け金を減らすボタン
###
class lowBetButton extends betButton
    constructor: () ->
        super 22, 22
        @image = @drawUpTriangle(@color)
        @scaleY = -1
        @x = 121
    setXposition: ()->
        @x = game.main_scene.gp_system.bet_text._boundWidth + @w + 20
    ontouchstart: () ->
        game.main_scene.buttonList.down = true
    ontouchend: () ->
        game.main_scene.buttonList.down = false

class lowBetButtonPause extends betButton
    constructor: () ->
        super 33, 33
        @image = @drawUpTriangle(@color)
        @scaleY = -1
        @x = 90
        @y = 270
    ontouchend: () ->
        game.pause_scene.pause_main_layer.betSetting(false)
    setXposition:()->
        @x = 110 + game.pause_scene.pause_main_layer.bet_text._boundWidth + @w + 20

class Dialog extends System
    constructor: (w, h) ->
        super w, h
    ###
    ダイアログの描画
    ###
    drawDialog: () ->
        return @drawStrokeRect('#aaaaaa', '#ffffff', 5)
class pauseBack extends Dialog
    constructor: (w, h) ->
        super game.width, game.height
        @image = @drawRect('#000000')
        @opacity = 0.8

class whiteBack extends Dialog
    constructor: (w, h) ->
        super game.width, game.height
        @image = @drawRect('#FFFFFF')
        @opacity = 1
class Param extends System
    constructor: (w, h) ->
        super w, h

class TensionGaugeBack extends Param
    constructor: (w, h) ->
        super 457, 19
        @image = @drawRect('#FFFFFF')
        @x = 11
        @y = 46

class TensionGauge extends Param
    constructor: (w, h) ->
        super 450, 11
        @image = @drawRect('#6EB7DB')
        @x = 15
        @y = 50
        @setValue()

    setValue:()->
        tension = 0
        if game.tension != 0
            tension = game.tension / game.slot_setting.tension_max
        @scaleX = tension
        @x = 15 - ((@w - tension * @w) / 2)
        if tension < 0.25
            @image = @drawRect('#6EB7DB')
        else if tension < 0.5
            @image = @drawRect('#B2CF3E')
        else if tension < 0.75
            @image = @drawRect('#F3C759')
        else if tension < 1
            @image = @drawRect('#EDA184')
        else
            @image = @drawRect('#F4D2DE')

class ItemSlot extends Param
    constructor:()->
        super 55, 55
        @image = game.imageload("items")
        @frame = 0
        @x = 5
        @y = 70
    setPositoin:(num)->
        @x = (num - 1) * 55 + 5

class ItemGaugeBack extends Param
    constructor:()->
        super 50, 8
        @image = @drawRect('#333')
        @x = 8
        @y = 112
    setWidth:()->
        @width = 50 * game.max_set_item_num

class ItemGauge extends Param
    constructor:()->
        super 51, 8
        @image = @drawRect('#A6E39D')
        @initX = 7
        @x = @initX
        @y = 112
    setWidth:()->
        @width = 51 * game.max_set_item_num