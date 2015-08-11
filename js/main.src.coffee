enchant()
window.onload = ->
    #グローバル変数にはwindow.をつけて宣言する
    window.game = new LoveliveGame()
    game.start()
class appDomLayer extends DomLayer
    constructor: () ->
        super

class appGame extends Game
    constructor:(w, h)->
        super w, h
        #ミュート（消音）フラグ
        @scale = 1
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
    効果音を鳴らす
    ###
    sePlay:(se)->
        se.clone().play()

    ###
    BGMをならす
    ###
    bgmPlay:(bgm, bgm_loop)->
        if bgm != undefined
            bgm.play()
            if bgm_loop is true
                bgm._element.loop = true
                #bgm.src.loop = true

    ###
    BGMを止める
    ###
    bgmStop:(bgm)->
        if bgm != undefined
            bgm.stop()

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
class pauseMainLayer extends appDomLayer
    constructor: () ->
        super
        @return_game_button = new returnGameButtonHtml()
        @addChild(@return_game_button)
        @save_game_button = new saveGameButtonHtml()
        @addChild(@save_game_button)

class pauseSaveLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @ok_button = new saveOkButtonHtml()
        @addChild(@ok_button)
class titleMainLayer extends appDomLayer
    constructor: () ->
        super

class catchAndSlotGame extends appGame
    constructor:(w, h)->
        super w, h

class LoveliveGame extends catchAndSlotGame
    constructor:()->
        super @width, @height
        @debug = new Debug()
        @slot_setting = new slotSetting()
        @width = 480
        @height = 720
        @fps = 24
        #画像リスト
        @imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause']
        #音声リスト
        @soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear']

        @keybind(90, 'z')
        @keybind(88, 'x')
        @preloadAll()
        #一人目のμ’ｓメンバーを決めて素材をロードする
        @slot_setting.setMuseMember()
        @musePreLoad()

        #ゲーム中どこからでもアクセスのある数値
        @money_init = 100 #ゲーム開始時の所持金
        @fever = false #trueならフィーバー中
        @fever_down_tension = 0
        @item_kind = 0 #落下アイテムの種類（フレーム）
        @fever_hit_eye = 0 #どの目で当たって今フィーバーになっているか

        #セーブする変数(slot_settingにもあるので注意)
        @money = 0 #現在の所持金
        @bet = 1 #現在の掛け金
        @combo = 0 #現在のコンボ
        @tension = 0 #現在のテンション(500がマックス)
        @past_fever_num = 0 #過去にフィーバーになった回数

    onload:() ->
        @gameInit()
        @main_scene = new mainScene()
        @pushScene(@main_scene)
        @pause_scene = new pauseScene()
        if @debug.force_pause_flg is true
            @pushScene(@pause_scene)

    ###
    スロットにμ’ｓを挿入するときに必要なカットイン画像や音楽を予めロードしておく
    ###
    musePreLoad:()->
        muse_num = @slot_setting.now_muse_num
        if @slot_setting.muse_material_list[muse_num] != undefined
            material = @slot_setting.muse_material_list[muse_num]
            for key, val of material['cut_in']
                @load('images/cut_in/'+val.name + '.png')
            if material['voice'].length > 0
                for key, val of material['voice']
                    @load('sounds/voice/'+val+'.mp3')
            @load('sounds/bgm/'+material['bgm'][0]['name']+'.mp3')

    ###
    ゲーム開始時の初期数値調整
    ###
    gameInit:() ->
        @money = @money_init

    ###
    テンションゲージを増減する
    @param number val 増減値
    ###
    tensionSetValue:(val)->
        @slot_setting.changeLilleForTension(@tension, val)
        @tension += val
        if @tension < 0
            @tension = 0
        else if @tension > @slot_setting.tension_max
            @tension = @slot_setting.tension_max
        @main_scene.gp_system.tension_gauge.setValue()

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
        val = @slot_setting.setTensionItemFall()
        @tensionSetValue(val)

    ###
    スロットが当たった時にテンションゲージを増減する
    @param number prize_money 当選金額
    @param number hit_eye     当たった目の番号
    ###
    tensionSetValueSlotHit:(prize_money, hit_eye)->
        val = @slot_setting.setTensionSlotHit(prize_money, hit_eye)
        @tensionSetValue(val)
    setPauseScene:()->
        @pushScene(@pause_scene)
class gpEffect extends appGroup
    constructor: () ->
        super
    cutInSet:()->
        setting = game.slot_setting
        if setting.muse_material_list[setting.now_muse_num] != undefined
            @cut_in = new cutIn()
            @addChild(@cut_in)
            game.main_scene.gp_stage_front.missItemFallSycleNow = 0
class gpPanorama extends appGroup
    constructor: () ->
        super
        @back_panorama = new BackPanorama()
        @addChild(@back_panorama)
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
                game.sePlay(@lille_stop_se)
                @left_lille.isRotation = false
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
                @isStopping = false
                @slotHitTest()

    ###
    左のスロットが当たった目を記憶する
    ###
    saveLeftSlotEye:()->
        @leftSlotEye = @left_lille.lilleArray[@left_lille.nowEye]

    ###
    確率でスロットを強制的に当たりにする
    ###
    forceHit:(target)->
        if game.slot_setting.getIsForceSlotHit() is true
            tmp_eye = @_searchEye(target)
            if tmp_eye != 0
                target.nowEye = tmp_eye
                target.frameChange()

    _searchEye:(target)->
        result = 0
        for key, val of target.lilleArray
            if result is 0 && val is @leftSlotEye
                result = key
        return result


    ###
    スロットの当選判定
    ###
    slotHitTest: () ->
        if @left_lille.lilleArray[@left_lille.nowEye] is @middle_lille.lilleArray[@middle_lille.nowEye] is @right_lille.lilleArray[@right_lille.nowEye]
            game.sePlay(@slot_hit_se)
            hit_eye = @left_lille.lilleArray[@left_lille.nowEye]
            prize_money = game.slot_setting.calcPrizeMoney(@middle_lille.lilleArray[@middle_lille.nowEye])
            game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            game.tensionSetValueSlotHit(prize_money, hit_eye)
            @_feverStart(hit_eye)
        else
            if game.slot_setting.isAddMuse() is true
                member = game.slot_setting.now_muse_num
                @slotAddMuse(member, 1)

    ###
    フィーバーを開始する
    ###
    _feverStart:(hit_eye)->
        if hit_eye > 10 && game.fever is false
            game.fever = true
            game.past_fever_num += 1
            game.slot_setting.setMuseMember()
            game.musePreLoad()
            game.fever_hit_eye = hit_eye
            @_feverBgmStart(hit_eye)

    ###
    フィーバー中のBGMを開始する
    ###
    _feverBgmStart:(hit_eye)->
        bgms = game.slot_setting.muse_material_list[hit_eye]['bgm']
        random = Math.floor(Math.random() * bgms.length)
        bgm = bgms[random]
        @feverSec = bgm['time']
        @fever_bgm = game.soundload('bgm/'+bgm['name'])
        game.fever_down_tension = Math.round(game.slot_setting.tension_max * 100 / (@feverSec * game.fps)) / 100
        game.fever_down_tension *= -1
        game.bgmPlay(@fever_bgm, false)



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
    リールにμ’sの誰かを挿入
    スロットが止まってハズレだったときに確率で実行
    @param number num メンバーの指定
    @param number cnt 人数の指定
    ###
    slotAddMuse:(num, cnt)->
        @left_lille.lilleArray = @_slotAddMuseUnit(num, cnt, @left_lille)
        @middle_lille.lilleArray = @_slotAddMuseUnit(num, cnt, @middle_lille)
        @right_lille.lilleArray = @_slotAddMuseUnit(num, cnt, @right_lille)
        game.main_scene.gp_effect.cutInSet()

    ###
    リールにμ’sの誰かを挿入(単体)
    @param number num   メンバーの指定
    @param number cnt   人数の指定
    @param array  lille リール
    ###
    _slotAddMuseUnit:(num, cnt, lille)->
        arr = []
        for i in [1..cnt]
            for key, val of lille.lilleArray
                if val < 10
                    arr.push(key)
            if arr.length > 0
                random_key = Math.floor(arr.length * Math.random())
                add_num = arr[random_key]
                lille.lilleArray[add_num] = num
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
            if @itemFallSec != @itemFallSecInit
                @setItemFallFrm(@itemFallSecInit)
        if @missItemFallSycleNow is @missItemFallSycle && @age % @itemFallFrm is @itemFallFrm / 2
            @_missCatchFall()
            @missItemFallSycleNow = 0

    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        if game.money >= game.bet
            @catchItems.push(new MacaroonCatch())
            @addChild(@catchItems[@nowCatchItemsNum])
            @catchItems[@nowCatchItemsNum].setPosition()
            @nowCatchItemsNum += 1
            game.money -= game.bet
            if game.bet > game.money
                game.bet = game.money
            game.main_scene.gp_system.money_text.setValue()
            game.main_scene.gp_slot.slotStart()

    _missCatchFall:()->
        if game.money >= game.bet
            @catchMissItems.push(new OnionCatch())
            @addChild(@catchMissItems[@nowCatchMissItemsNum])
            @catchMissItems[@nowCatchMissItemsNum].setPosition()
            @nowCatchMissItemsNum += 1


###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsInstance = [] #スロット当選金のインスタンスを格納
        @prizeMoneyItemsNum = {1:0,10:0,100:0,1000:0,10000:0,100000:0} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 4 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
        @oneSetMoney = 1 #1フレームに設置するコインの数

        @returnMoneyItemsInstance = [] #掛け金の戻り分のインスタンスを格納
        @returnMoneyItemsNum = {1:0,10:0,100:0,1000:0,10000:0,100000:0} #掛け金の戻り分を降らせる各コイン数の内訳
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
        if value < 1000000
            @prizeMoneyFallIntervalFrm = 4
        else if value < 10000000
            @prizeMoneyFallIntervalFrm = 2
        else
            @prizeMoneyFallIntervalFrm = 1
        @prizeMoneyItemsNum = @_calcMoneyItemsNum(value, true)
        @prizeMoneyItemsInstance = @_setMoneyItemsInstance(@prizeMoneyItemsNum, true)
        if @prizeMoneyItemsNum[100000] > 1000
            @oneSetMoney = Math.floor(@prizeMoneyItemsNum[100000] / 1000)
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
        ret_data = {1:0,10:0,100:0,1000:0,10000:0,100000:0}
        if value <= 20 #全部1円
            ret_data[1] = value
            ret_data[10] = 0
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
        else if value < 100 #1円と10円と端数
            ret_data[1] = game.getDigitNum(value, 1) + 10
            ret_data[10] = game.getDigitNum(value, 2) - 1
            ret_data[100] = 0
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
        else if value < 1000 #10円と100円と端数
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2) + 10
            ret_data[100] = game.getDigitNum(value, 3) - 1
            ret_data[1000] = 0
            ret_data[10000] = 0
            ret_data[100000] = 0
        else if value < 10000 #1000円と100円と端数
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3) + 10
            ret_data[1000] = game.getDigitNum(value, 4) - 1
            ret_data[10000] = 0
            ret_data[100000] = 0
        else if value < 100000
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3)
            ret_data[1000] = game.getDigitNum(value, 4) + 10
            ret_data[10000] = game.getDigitNum(value, 5) - 1
            ret_data[100000] = 0
        else
            ret_data[1] = game.getDigitNum(value, 1)
            ret_data[10] = game.getDigitNum(value, 2)
            ret_data[100] = game.getDigitNum(value, 3)
            ret_data[1000] = game.getDigitNum(value, 4)
            ret_data[10000] = game.getDigitNum(value, 5)
            ret_data[100000] = Math.floor(value/100000)
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
        else
            val = Math.floor(val / 100000) * 100000
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
        @keyList = {'up':false, 'down':false}
    onenterframe: (e) ->
        @_betSetting()
    ###
    キーの上下を押して掛け金を設定する
    TODO スロットの当選金額落下中は変更できないようにする
    ###
    _betSetting: ()->
        if game.fever is false
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
            else
                val = 100000
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
            else
                val = -100000
        game.bet += val
        if game.bet < 1
            game.bet = 1
        else if game.bet > game.money
            game.bet = game.money
        else if game.bet > 10000000
            game.bet = 10000000
        @bet_text.setValue()

class systemHtml extends appHtml
    constructor: (width, height) ->
        super width, height
        @class = []
        @text = ''
    setHtml: ()->
        tmp_cls = ''
        for val in @class
            tmp_cls += val + ' '
        @_element.innerHTML = '<div class="'+tmp_cls+'">'+@text+'</div>'
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
        game.popScene(game.pause_scene)

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
class dialogHtml extends systemHtml
    constructor: (width, height) ->
        super width, height
class baseDialogHtml extends dialogHtml
    constructor: () ->
        super 375, 375
        @class = ['base-dialog']
class saveDialogHtml extends baseDialogHtml
    constructor: () ->
        super
        @text = '保存しました。'
        @class.push('base-dialog-save')
        @x = 60
        @y = 150
        @setHtml()
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
        @text = @zandaka_text + game.money + @yen_text
        @setXposition()
    ###
    X座標の位置を設定
    ###
    setXposition: () ->
        @x = game.width - @_boundWidth - 7

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
        @text = @kakekin_text + game.bet + @yen_text
    setValue: () ->
        @text = @kakekin_text + game.bet + @yen_text
        game.main_scene.gp_system.low_bet_button.setXposition()

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

        #全てのデバッグフラグをONにする
        @all_debug_flg = false

        #開始後いきなりポーズ画面
        @force_pause_flg = false

        #デバッグ用リールにすりかえる
        @lille_flg = false
        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = false
        #アイテムが降ってくる頻度を上げる
        @item_fall_early_flg = false
        #アイテムを取った時のテンション増減値を固定する
        @fix_tention_item_catch_flg = false
        #アイテムを落とした時のテンション増減値を固定する
        @fix_tention_item_fall_flg = false
        #スロットが当たった時のテンション増減値を固定する
        @fix_tention_slot_hit_flg = false
        #スロットに必ずμ’ｓが追加される
        @force_insert_muse = false
        #スロットが必ず当たる
        @force_slot_hit = false
        #デバッグ用リール配列
        @lille_array = [
            [16, 15],
            [15],
            [15]
        ]
        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = -50
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @all_debug_flg is true
            @lille_flg = true
            @item_flg = true
            @item_fall_early_flg = true
            @fix_tention_item_catch_flg = true
            @fix_tention_item_fall_flg = true
            @fix_tention_slot_hit_flg = true
            @force_insert_muse = true
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
            1:5, 2:30, 3:40, 4:50, 5:300,
            11:100, 12:100, 13:100, 14:100, 15:100, 16:100, 17:100, 18:100, 19:100
        }
        ###
        カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
        11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
        direction:キャラクターの向き、left or right
        カットインの画像サイズ、頭の位置で570px
        ###
        @muse_material_list = {
            11:{
                'cut_in':[
                    {'name':'11_0', 'width':360, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'yumenaki', 'time':107}
                ],
                'voice':['11_0', '11_1']
            },
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':510, 'height':728, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'blueberry', 'time':98}
                ],
                'voice':['12_0', '12_1']
            },
            13:{
                'cut_in':[
                    {'name':'13_0', 'width':570, 'height':634, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'reason', 'time':94}
                ],
                'voice':['13_0', '13_1']
            },
            14:{
                'cut_in':[
                    {'name':'14_0', 'width':476, 'height':648, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'daring', 'time':91}
                ],
                'voice':['14_0', '14_1']
            },
            15:{
                'cut_in':[
                    {'name':'15_0', 'width':502, 'height':570, 'direction':'right'},
                    {'name':'15_1', 'width':601, 'height':638, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'rinrinrin', 'time':128}
                ],
                'voice':['15_0', '15_1']
            },
            16:{
                'cut_in':[
                    {'name':'16_0', 'width':438, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'nawatobi', 'time':164}
                ],
                'voice':['16_0', '16_1']
            },
            17:{
                'cut_in':[
                    {'name':'17_0', 'width':465, 'height':705, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'mahoutukai', 'time':105}
                ],
                'voice':['17_0', '17_1']
            },
            18:{
                'cut_in':[
                    {'name':'18_0', 'width':599, 'height':606, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'junai', 'time':127}
                ],
                'voice':['18_0', '18_1']
            },
            19:{
                'cut_in':[
                    {'name':'19_0', 'width':460, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'arihureta', 'time':93}
                ],
                'voice':['19_0', '19_1']
            }
        }
        #テンションの最大値
        @tension_max = 500
        #現在スロットに入るμ’ｓ番号
        @now_muse_num = 0

        #セーブする変数
        @prev_muse = [] #過去にスロットに入ったμ’ｓ番号

    ###
    落下アイテムの加速度
    掛け金が多いほど速くする、10000円で速すぎて取れないレベルまで上げる
    ###
    setGravity:()->
        if game.bet < 5
            val = 0.5
        else if game.bet < 10
            val = 0.6
        else if game.bet < 50
            val = 0.7
        else if game.bet < 100
            val = 0.8
        else if game.bet < 500
            val = 0.9
        else if game.bet < 1000
            val = 1
        else if game.bet < 10000
            val = 1 + Math.floor(game.bet / 500) / 10
        else if game.bet < 100000
            val = 3 + Math.floor(game.bet / 5000) / 10
        else
            val = 5
        div = 1 + Math.floor(3 * game.tension / @tension_max) / 10
        val = Math.floor(val * div * 10) / 10
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
        if @prev_muse.length >= 9
            @prev_muse = []
        for key, val of full
            if @prev_muse.indexOf(val) is -1
                remain.push(full[key])
        random = Math.floor(Math.random() * remain.length)
        member = remain[random]
        #member = 16
        @now_muse_num = member
        if @prev_muse.indexOf(member) is -1
            @prev_muse.push(member)

    ###
    挿入するμ’sメンバーの人数を決める
    ###
    setMuseNum:()->
        num = Math.floor(game.combo / 100) + 1
        return num

    ###
    スロットを強制的に当たりにするかどうかを決める
    コンボ数 * 0.1 ％
    テンションMAXで2倍補正
    過去のフィーバー回数が少ないほど上方補正かける 0回:+15,1回:+10,2回:+5
    フィーバー中は強制的に当たり
    @return boolean true:当たり
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor(game.combo * 0.1 * ((game.tension / @tension_max) + 1))
        if game.past_fever_num <= 2
            rate += (3 - game.past_fever_num) * 5
        if rate > 100
            rate = 100
        random = Math.floor(Math.random() * 100)
        if random < rate || game.fever is true || game.debug.force_slot_hit is true
            result = true
        return result

    ###
    スロットが回っている時に降ってくる掛け金の戻り分の額を計算
    ###
    getReturnMoneyFallValue:()->
        return Math.floor(game.bet * game.combo * 0.05)

    ###
    スロットの当選金額を計算
    @param eye 当たったスロットの目
    ###
    calcPrizeMoney: (eye) ->
        ret_money = game.bet * @bairitu[eye]
        if game.fever is true
            time = @muse_material_list[game.fever_hit_eye]['bgm'][0]['time']
            div = Math.floor(time / 30)
            if div < 1
                div = 1
            ret_money = ret_money / div
        if ret_money > 10000000000
            ret_money = 10000000000
        return ret_money

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (@tension_max - game.tension) * 0.005 * (game.item_kind + 1)
        if game.main_scene.gp_stage_front.player.isAir is true
            val *= 1.5
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
    アイテムを落とした時のテンションゲージの増減値を決める
    ###
    setTensionItemFall:()->
        val = game.tension * 0.2
        if val < @tension_max * 0.1
            val = @tension_max * 0.1
        val *= -1
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        #TODO スロットにμ’ｓがいれば1つ消す
        return val

    ###
    スロットが当たったのテンションゲージの増減値を決める
    @param number prize_money 当選金額
    @param number hit_eye     当たった目の番号
    ###
    setTensionSlotHit:(prize_money, hit_eye)->
        hit_rate = prize_money / game.money
        if game.money < 100
            correct = 0.02
        else if game.money < 1000
            correct = 0.04
        else if game.money < 10000
            correct = 0.06
        else if game.money < 100000
            correct = 0.08
        else
            correct = 0.1
        val = hit_rate * correct * @tension_max
        if val > @tension_max * 0.5
            val = @tension_max * 0.5
        else if val < @tension_max * 0.1
            val = @tension_max * 0.1
        val = Math.round(val)
        if game.debug.fix_tention_slot_hit_flg is true
            val = game.debug.fix_tention_slot_hit_flg
        if hit_eye > 10
            val = @tension_max
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
        if game.bet < 10
            rate_0 = 60
            rate_1 = 80
            rate_2 = 90
            rate_3 = 95
        else if game.bet < 100
            rate_0 = 20
            rate_1 = 60
            rate_2 = 80
            rate_3 = 90
        else if game.bet < 1000
            rate_0 = 10
            rate_1 = 30
            rate_2 = 60
            rate_3 = 80
        else if game.bet < 5000
            rate_0 = 5
            rate_1 = 20
            rate_2 = 40
            rate_3 = 70
        else
            rate_0 = 2
            rate_1 = 10
            rate_2 = 30
            rate_3 = 50
        if rate < rate_0
            val = 0
        else if rate < rate_1
            val = 1
        else if rate < rate_2
            val = 2
        else if rate < rate_3
            val = 3
        else
            val = 4
        game.item_kind = val
        return val
class mainScene extends appScene
    constructor:()->
        super
        @backgroundColor = '#93F0FF'
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false, 'pause':false}
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_panorama = new gpPanorama()
        @addChild(@gp_panorama)
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
        if game.input.left is true
            if @keyList.left is false
                @keyList.left = true
        else
            if @keyList.left is true
                @keyList.left = false
        # 右
        if game.input.right is true
            if @keyList.right is false
                @keyList.right = true
        else
            if @keyList.right is true
                @keyList.right = false
        # 上
        if game.input.up is true
            if @keyList.up is false
                @keyList.up = true
        else
            if @keyList.up is true
                @keyList.up = false
        # 下
        if game.input.down is true
            if @keyList.down is false
                @keyList.down = true
        else
            if @keyList.down is true
                @keyList.down = false
        # ジャンプ
        if game.input.z is true
            if @keyList.jump is false
                @keyList.jump = true
        else
            if @keyList.jump is true
                @keyList.jump = false
        #ポーズ
        if game.input.x is true
            if @keyList.pause is false
                game.setPauseScene()
                @keyList.pause = true
        else
            if @keyList.pause = true
                @keyList.pause = false

    ###
    フィーバー中に一定時間でテンションが下がる
    テンションが0になったらフィーバーを解く
    ###
    tensionSetValueFever:()->
        if game.fever is true
            game.tensionSetValue(game.fever_down_tension)
            if game.tension <= 0
                game.bgmStop(game.main_scene.gp_slot.fever_bgm)
                game.fever = false
class pauseScene extends appScene
    constructor: () ->
        super
        @pause_back = new pauseBack()
        @addChild(@pause_back)
        @pause_main_layer = new pauseMainLayer()
        @addChild(@pause_main_layer)
        @pause_save_layer = new pauseSaveLayer()
    setSaveMenu: () ->
        @addChild(@pause_save_layer)
        @_exeGameSave()
    removeSaveMenu:()->
        @removeChild(@pause_save_layer)
    ###
    データ保存の実行
    ###
    _exeGameSave:()->
        saveData = {
            'money'    : game.money,
            'bet'      : game.bet,
            'combo'    : game.combo,
            'tension'  : game.tension,
            'past_fever_num' : game.past_fever_num
            'prev_muse': JSON.stringify(game.slot_setting.prev_muse)
        }
        for key, val of saveData
            window.localStorage.setItem(key, val)
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
        @y = game.height - @h
class effect extends appSprite
    constructor: (w, h) ->
        super w, h
###
カットインの画像サイズ、頭の位置で760px
###
class cutIn extends effect
    constructor: () ->
        @_callCutIn()
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
    
    _callCutIn:()->
        setting = game.slot_setting
        muse_num = setting.now_muse_num
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
            game.main_scene.gp_stage_front.removeChild(@)
            game.combo += 1
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
            game.sePlay(@miss_se)
            game.main_scene.gp_stage_front.removeChild(@)
            game.tensionSetValueMissItemCatch()
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
    constructor: (isHoming) ->
        super 26, 30
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
        super isHoming
        @price = 1
        @frame = 0
        @frame_init = 0

###
10円
@param boolean isHoming trueならコインがホーミングする
###
class TenMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10
        @frame = 0
        @frame_init = 0

###
100円
@param boolean isHoming trueならコインがホーミングする
###
class HundredMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 100
        @frame = 4
        @frame_init = 4

###
1000円
@param boolean isHoming trueならコインがホーミングする
###
class ThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 1000
        @frame = 4
        @frame_init = 4

###
一万円
@param boolean isHoming trueならコインがホーミングする
###
class TenThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 10000
        @frame = 8
        @frame_init = 8

###
10万円
@param boolean isHoming trueならコインがホーミングする
###
class HundredThousandMoney extends Money
    constructor: (isHoming) ->
        super isHoming
        @price = 100000
        @frame = 8
        @frame_init = 8
class Slot extends appSprite
    constructor: (w, h) ->
        super w, h
    ###
    枠の無い長方形
    @param color 色
    ###
    drawRect: (color) ->
        surface = new Surface(@w, @h)
        surface.context.fillStyle = color
        surface.context.fillRect(0, 0, @w, @h, 10)
        surface.context.fill()
        return surface
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
            @soundLotateSe()
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
        super 50, 50
        @color = "#aaa"
        @opacity = 0.4
        @x = 0
        @y = 660

###
左ボタン
###
class leftButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @x = 30

###
右ボタン
###
class rightButton extends controllerButton
    constructor: () ->
        super
        @image = @drawLeftTriangle(@color)
        @scaleX = -1
        @x = game.width - @w - 30

###
ジャンプボタン
###
class jumpButton extends controllerButton
    constructor: () ->
        super
        @image = @drawCircle(@color)
        @x = (game.width - @w) / 2

###
掛け金変更ボタン
###
class betButton extends Button
    constructor: () ->
        super 22, 22
        @color = "black"
        @y = 7

###
掛け金を増やすボタン
###
class heighBetButton extends betButton
    constructor: () ->
        super
        @image = @drawUpTriangle(@color)
        @x = 7

###
掛け金を減らすボタン
###
class lowBetButton extends betButton
    constructor: () ->
        super
        @image = @drawUpTriangle(@color)
        @scaleY = -1
        @x = 121
    setXposition: ()->
        @x = game.main_scene.gp_system.bet_text._boundWidth + @w + 20
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