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
        @w = w
        @h = h
class catchAndSlotGame extends appGame
    constructor:(w, h)->
        super w, h

class LoveliveGame extends catchAndSlotGame
    constructor:()->
        super @width, @height
        @slot_setting = new slotSetting()
        @debug = new Debug()
        @width = 640
        @height = 960
        @fps = 24
        #画像リスト
        @imgList = ['chun', 'sweets','icon1', 'lille', 'under_frame']
        #音声リスト
        @sondList = []
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false}
        @keybind(90, 'z')
        @preloadAll()

        #ゲーム中どこからでもアクセスのある数値
        @money_init = 1000 #ゲーム開始時の所持金
        @money = 0 #現在の所持金
        @bet = 10 #現在の掛け金
        @combo = 0 #現在のコンボ
        @tension = 0 #現在のテンション(500がマックス)
        @item_kind = 0 #落下アイテムの種類（フレーム）

    onload:() ->
        @gameInit()
        @main_scene = new mainScene()
        @pushScene(@main_scene)

    ###
    ゲーム開始時の初期数値調整
    ###
    gameInit:() ->
        @money = @money_init

    onenterframe: (e) ->
        @buttonPush()

    ###ボタン操作、物理キーとソフトキー両方に対応###
    buttonPush:()->
        # 左
        if @input.left is true
            if @keyList.left is false
                @keyList.left = true
        else
            if @keyList.left is true
                @keyList.left = false
        # 右
        if @input.right is true
            if @keyList.right is false
                @keyList.right = true
        else
            if @keyList.right is true
                @keyList.right = false
        # 上
        if @input.up is true
            if @keyList.up is false
                @keyList.up = true
        else
            if @keyList.up is true
                @keyList.up = false
        # 下
        if @input.down is true
            if @keyList.down is false
                @keyList.down = true
        else
            if @keyList.down is true
                @keyList.down = false
        # ジャンプ
        if @input.z is true
            if @keyList.jump is false
                @keyList.jump = true
        else
            if @keyList.jump is true
                @keyList.jump = false

    ###
    テンションゲージを増減する
    @param number val 増減値
    ###
    _tensionSetValue:(val)->
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
        @_tensionSetValue(val)
    ###
    アイテムを落とした時にテンションゲージを増減する
    ###
    tensionSetValueItemFall:()->
        val = @slot_setting.setTensionItemFall()
        @_tensionSetValue(val)

    ###
    スロットが当たった時にテンションゲージを増減する
    @param number prize_money 当選金額
    ###
    tensionSetValueSlotHit:(prize_money)->
        val = @slot_setting.setTensionSlotHit(prize_money)
        @_tensionSetValue(val)

class gpPanorama extends appGroup
    constructor: () ->
        super
class gpSlot extends appGroup
    constructor: () ->
        super
        @debugSlot()
        @underFrame = new UnderFrame()
        @addChild(@underFrame)
        @isStopping = false #スロット停止中
        @stopIntervalFrame = 9 #スロットが連続で止まる間隔（フレーム）
        @slotIntervalFrameRandom = 0
        @stopStartAge = 0 #スロットの停止が開始したフレーム
        @slotSet()
    onenterframe: (e) ->
        @slotStopping()

    ###
    スロットが一定の時間差で連続で停止する
    ###
    slotStopping: ()->
        if @isStopping is true
            if @age is @stopStartAge
                @left_lille.isRotation = false
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame + @slotIntervalFrameRandom
                @middle_lille.isRotation = false
                @setIntervalFrame()
            if @age is @stopStartAge + @stopIntervalFrame * 2 + @slotIntervalFrameRandom
                @right_lille.isRotation = false
                @isStopping = false
                @slotHitTest()

    ###
    スロットの当選判定
    ###
    slotHitTest: () ->
        if @left_lille.lilleArray[@left_lille.nowEye] is @middle_lille.lilleArray[@middle_lille.nowEye] is @right_lille.lilleArray[@right_lille.nowEye]
            prize_money = @_calcPrizeMoney()
            game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money)
            game.tensionSetValueSlotHit(prize_money)

    ###
    スロットの当選金額を計算
    ###
    _calcPrizeMoney: () ->
        ret_money = 0
        eye = @middle_lille.lilleArray[@middle_lille.nowEye]
        ret_money = game.bet * game.slot_setting.bairitu[eye]
        return ret_money

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
            game.slot_setting.lille_array = game.debug.lille_array
class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 900 #床の位置

###
ステージ前面
プレイヤーや落下アイテムがある
###
class stageFront extends gpStage
    constructor: () ->
        super
        @itemFallSec = 5 #アイテムを降らせる周期（秒）
        @catchItems = [] #キャッチアイテムのインスタンスを格納
        @nowCatchItemsNum = 0
        @initial()
    initial:()->
        @setPlayer()
    onenterframe: () ->
        @_stageCycle()
    setPlayer:()->
        @player = new Bear()
        @player.y = @floor
        @addChild(@player)
    ###
    一定周期でステージに発生するイベント
    ###
    _stageCycle:()->
        if game.debug.item_fall_early_flg is true
            @itemFallSec = 3
        if @age % (game.fps * @itemFallSec) is 0
            @_catchFall()
    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        if (game.money >= game.bet)
            @catchItems.push(new MacaroonCatch())
            @addChild(@catchItems[@nowCatchItemsNum])
            @catchItems[@nowCatchItemsNum].setPosition(1)
            @nowCatchItemsNum += 1
            game.money -= game.bet
            if game.bet > game.money
                game.bet = game.money
            game.main_scene.gp_system.money_text.setValue()
            game.main_scene.gp_slot.slotStart()

###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsInstance = [] #スロット当選金のインスタンスを格納
        @prizeMoneyItemsNum = {1:0,10:0,100:0,1000:0} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 4 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
    onenterframe: () ->
        @_moneyFall()
    ###
    スロットの当選金を降らせる
    @param value number 金額
    ###
    fallPrizeMoneyStart:(value) ->
        @_calcPrizeMoneyItemsNum(value)
        @_setPrizeMoneyItemsInstance()
        @prizeMoneyFallPeriodSec = Math.ceil(@prizeMoneyItemsInstance.length * @prizeMoneyFallIntervalFrm)
        console.log(@prizeMoneyFallPeriodSec)
        @isFallPrizeMoney = true

    ###
    スロットの当選金を降らせる
    ###
    _moneyFall:()->
        if @isFallPrizeMoney is true && @age % @prizeMoneyFallIntervalFrm is 0
            @addChild(@prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum])
            @prizeMoneyItemsInstance[@nowPrizeMoneyItemsNum].setPosition()
            @nowPrizeMoneyItemsNum += 1
            if @nowPrizeMoneyItemsNum is @prizeMoneyItemsInstance.length
                @nowPrizeMoneyItemsNum = 0
                @isFallPrizeMoney = false
    ###
    当選金の内訳のコイン枚数を計算する
    @param value number 金額
    ###
    _calcPrizeMoneyItemsNum:(value)->
        if value <= 20 #全部1円
            @prizeMoneyItemsNum[1] = value
            @prizeMoneyItemsNum[10] = 0
            @prizeMoneyItemsNum[100] = 0
            @prizeMoneyItemsNum[1000] = 0
        else if value < 100 #1円と10円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1) + 10
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2) - 1
            @prizeMoneyItemsNum[100] = 0
            @prizeMoneyItemsNum[1000] = 0
        else if value < 1000 #10円と100円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1)
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2) + 10
            @prizeMoneyItemsNum[100] = game.getDigitNum(value, 3) - 1
            @prizeMoneyItemsNum[1000] = 0
        else if value < 10000 #1000円と100円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1)
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2)
            @prizeMoneyItemsNum[100] = game.getDigitNum(value, 3) + 10
            @prizeMoneyItemsNum[1000] = game.getDigitNum(value, 4) - 1
        else #全部1000円と端数
            @prizeMoneyItemsNum[1] = game.getDigitNum(value, 1)
            @prizeMoneyItemsNum[10] = game.getDigitNum(value, 2)
            @prizeMoneyItemsNum[100] = game.getDigitNum(value, 3)
            @prizeMoneyItemsNum[1000] = Math.floor(value/1000)

    ###
    当選金コインのインスタンスを設置
    ###
    _setPrizeMoneyItemsInstance:()->
        @prizeMoneyItemsInstance = []
        if @prizeMoneyItemsNum[1] > 0
            for i in [1..@prizeMoneyItemsNum[1]]
                @prizeMoneyItemsInstance.push(new OneHomingMoney)
        if @prizeMoneyItemsNum[10] > 0
            for i in [1..@prizeMoneyItemsNum[10]]
                @prizeMoneyItemsInstance.push(new TenHomingMoney)
        if @prizeMoneyItemsNum[100] > 0
            for i in [1..@prizeMoneyItemsNum[100]]
                @prizeMoneyItemsInstance.push(new HundredHomingMoney)
        if @prizeMoneyItemsNum[1000] > 0
            for i in [1..@prizeMoneyItemsNum[1000]]
                @prizeMoneyItemsInstance.push(new ThousandHomingMoney)
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
        @keyList = {'up':false, 'down':false}
    onenterframe: (e) ->
        @_betSetting()
    ###
    キーの上下を押して掛け金を設定する
    ###
    _betSetting: ()->
        if game.keyList['up'] is true
            if @keyList['up'] is false
                console.log('up')
                @_getBetSettingValue(true)
                @keyList['up'] = true
        else
            if @keyList['up'] is true
                @keyList['up'] = false
        if game.keyList['down'] is true
            if @keyList['down'] is false
                console.log('down')
                @_getBetSettingValue(false)
                @keyList['down'] = true
        else
            if @keyList['down'] is true
                @keyList['down'] = false

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
        @bet_text.setValue()

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
        @font_size = 30
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 0
        @y = 10
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
        @x = game.width - @_boundWidth - 10

class betText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 30
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 10
        @y = 10
        @kakekin_text = '掛金'
        @yen_text = '円'
        @setValue()
    setValue: () ->
        @text = @kakekin_text + game.bet + @yen_text

class comboText extends text
    constructor: () ->
        super
        @text = 0
        @color = 'black'
        @font_size = 50
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 260
        @y = 100
    setValue: () ->
        @text = game.combo
        @setXposition()
    setXposition: () ->
        unit = game.main_scene.gp_system.combo_unit_text
        @x = game.width / 2 - (@_boundWidth + unit._boundWidth + 6) / 2
        unit.x = @x + @_boundWidth + 6

class comboUnitText extends text
    constructor: () ->
        super
        @text = 'combo'
        @color = 'black'
        @font = "30px 'Consolas', 'Monaco', 'ＭＳ ゴシック'"
        @x = 290
        @y = 120
###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #全てのデバッグフラグをONにする
        @all_debug_flg = false

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
        #デバッグ用リール配列
        @lille_array = [
            [7,1],
            [1,7],
            [7,1]
        ]
        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = -1
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @all_debug_flg is true
            @lille_flg = true
            @item_flg = true
            @item_fall_early_flg = true
            @fix_tention_item_catch_flg = true
            @fix_tention_item_fall_flg = true
            @fix_tention_slot_hit_flg = true
###
スロットのリールの並びや掛け金に対する当選額
テンションによるリールの変化確率など
ゲームバランスに作用する固定値の設定
###
class slotSetting extends appNode
    constructor: () ->
        super
        #リールの並び
        @lille_array = [
            [1,2,3,4,2,3,5,2,1,3,4,5,2,5,7,1,2,3,4,5,1,7],
            [3,5,2,5,4,2,3,4,7,2,1,5,4,3,5,2,3,7,1,4,5,3],
            [2,4,1,5,1,4,2,7,2,4,3,1,7,2,3,7,1,5,3,2,4,5]
        ]
        #リールの目に対する当選額の倍率
        @bairitu = {
            2:10, 3:30, 4:50, 5:100, 6:100, 1:300, 7:600,
            11:1000, 12:1000, 13:1000, 14:1000, 15:1000, 16:1000, 17:1000, 18:1000, 19:1000
        }
        #テンションの最大値
        @tension_max = 500

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (@tension_max - game.tension) * 0.01 * (game.item_kind + 1)
        if val >= 1
            val = Math.round(val)
        else
            val = 1
        if game.debug.fix_tention_item_catch_flg is true
            val = game.debug.fix_tention_item_catch_val
        #console.log(val)
        return val
    ###
    アイテムを落とした時のテンションゲージの増減値を決める
    ###
    setTensionItemFall:()->
        bet_rate = game.bet / game.money
        if game.money < 100
            correct = 0.2
        else if game.money < 1000
            correct = 0.4
        else if game.money < 10000
            correct = 0.6
        else if game.money < 100000
            correct = 0.8
        else
            correct = 1
        val = bet_rate * correct * @tension_max
        if val > @tension_max
            val = @tension_max
        else if val < @tension_max * 0.05
            val = @tension_max * 0.05
        val = Math.round(val)
        val *= -1
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        #console.log(val)
        return val
    ###
    スロットが当たったのテンションゲージの増減値を決める
    @param number prize_money 当選金額
    ###
    setTensionSlotHit:(prize_money)->
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
        #console.log(val)
        return val

    ###
    落下するアイテムの種類を決める
    @return 0から4のどれか
    ###
    getCatchItemFrame:()->
        val = 0
        rate = Math.round(Math.random() * 100)
        if game.bet < 100
            rate_0 = 60
            rate_1 = 80
            rate_2 = 90
            rate_3 = 95
        else if game.bet < 1000
            rate_0 = 20
            rate_1 = 60
            rate_2 = 80
            rate_3 = 90
        else if game.bet < 10000
            rate_0 = 10
            rate_1 = 30
            rate_2 = 60
            rate_3 = 80
        else if game.bet < 100000
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
        @backgroundColor = 'rgb(153,204,255)';
        @initial()
    initial:()->
        @setGroup()
    setGroup:()->
        @gp_stage_back = new stageBack()
        @addChild(@gp_stage_back)
        @gp_slot = new gpSlot()
        @addChild(@gp_slot)
        @gp_stage_front = new stageFront()
        @addChild(@gp_stage_front)
        @gp_system = new gpSystem()
        @addChild(@gp_system)
        @gp_slot.x = 150
        @gp_slot.y = 200
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
    ###
    制約
    ・objectは必ずstageに対して追加する
    ###
    constructor: (w, h) ->
        super w, h
        @gravity = 1.6 #物体に働く重力
        @friction = 2.3 #物体に働く摩擦
class Character extends appObject
    constructor: (w, h) ->
        super w, h
        # キャラクターの動作を操作するフラグ
        @moveFlg = {'left':false, 'right':false, 'jump':false}
        @isAir = true; #空中判定
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
        @ax = 4 #x軸加速度
        @mx = 9 #x軸速度最大値
        @my = 25 #y軸初速度
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
            vy -= @my
            @isAir = true
        return vy

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
        if @vy > 0 && @y + @h > @parentNode.floor
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
            @y = @parentNode.floor - @h
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
        if game.keyList.left is true
            if @moveFlg.left is false
                @moveFlg.left = true
        else
            if @moveFlg.left is true
                @moveFlg.left = false
        # 右
        if game.keyList.right is true
            if @moveFlg.right is false
                @moveFlg.right = true
        else
            if @moveFlg.right is true
                @moveFlg.right = false
        # ジャンプ
        if game.keyList.jump is true
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

class Bear extends Player
    constructor: () ->
        super 90, 87
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
    onenterframe: (e) ->
        @vy += @gravity
        @y += @vy
        @hitPlayer()
        @removeOnFloor()
    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if @parentNode.player.intersect(@)
            @parentNode.removeChild(@)
            game.combo += 1
            game.main_scene.gp_system.combo_text.setValue()
            game.main_scene.gp_slot.slotStop()
            game.tensionSetValueItemCatch()

    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            @parentNode.removeChild(@)
            game.combo = 0
            game.main_scene.gp_system.combo_text.setValue()
            game.tensionSetValueItemFall()

    ###
    座標と落下速度の設定
    ###
    setPosition:(gravity)->
        @y = @h * -1
        @x = @_setPositoinX()
        @frame = game.slot_setting.getCatchItemFrame()
        @gravity = gravity

    ###
    X座標の位置の設定
    ###
    _setPositoinX:()->
        ret_x = 0
        if game.debug.item_flg
            ret_x = @parentNode.player.x
        else
            ret_x = Math.floor((game.width - @w) * Math.random())
        return ret_x

###
マカロン
###
class MacaroonCatch extends Catch
    constructor: (w, h) ->
        super 50, 50
        @image = game.imageload("sweets")
        @frame = 1
        @scaleX = 1.5
        @scaleY = 1.5
###
降ってくるお金
###
class Money extends Item
    constructor: (w, h) ->
        super 48, 48
        @scaleX = 0.5
        @scaleY = 0.5
        @price = 1 #単価
        @gravity = 2
        @image = game.imageload("icon1")

    onenterframe: (e) ->
        @vy += @gravity
        @y += @vy
        @x += @vx
        @hitPlayer()
        @removeOnFloor()

    ###
    プレイヤーに当たった時
    ###
    hitPlayer:()->
        if game.main_scene.gp_stage_front.player.intersect(@)
            @parentNode.removeChild(@)
            game.money += @price
            game.main_scene.gp_system.money_text.setValue()

    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            @parentNode.removeChild(@)

    setPosition:()->
        @y = @h * -1
        @x = Math.floor((game.width - @w) * Math.random())

###
ホーミングする
###
class HomingMoney extends Money
    constructor: (w, h) ->
        super w, h
        @addEventListener('enterframe', ()->
            @vx = Math.round( (game.main_scene.gp_stage_front.player.x - @x) / ((game.main_scene.gp_stage_front.player.y - @y) / @vy) )
        )
###
1円
###
class OneHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 1
        @frame = 2

###
10円
###
class TenHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 10
        @frame = 7

###
100円
###
class HundredHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 100
        @frame = 5

###
1000円
###
class ThousandHomingMoney extends HomingMoney
    constructor: (w, h) ->
        super w, h
        @price = 1000
        @frame = 4
class Slot extends appSprite
    constructor: (w, h) ->
        super w, h
        @scaleX = 1.5
        @scaleY = 1.5
class Frame extends Slot
    constructor: (w, h) ->
        super w, h

class UnderFrame extends Frame
    constructor: (w,h) ->
        super 330, 110
        @image = game.imageload("under_frame")

class UpperFrame extends Frame
    constructor: (w,h) ->
        super w, h
class Lille extends Slot
    constructor: (w, h) ->
        super 110, 110
        @image = game.imageload("lille")
        @lilleArray = [] #リールの並び
        @isRotation = false #trueならリールが回転中
        @nowEye = 0 #リールの現在の目
    onenterframe: (e) ->
        if @isRotation is true
            @eyeIncriment()
    ###
    回転中にリールの目を１つ進める
    ###
    eyeIncriment: () ->
        @nowEye += 1
        if @lilleArray[@nowEye] is undefined
            @nowEye = 0
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
        @lilleArray = game.slot_setting.lille_array[0]
        @eyeInit()
        @x = -55

class MiddleLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.slot_setting.lille_array[1]
        @eyeInit()
        @x = 110

class RightLille extends Lille
    constructor: () ->
        super
        @lilleArray = game.slot_setting.lille_array[2]
        @eyeInit()
        @x = 274
class System extends appSprite
    constructor: (w, h) ->
        super w, h
class Button extends System
    constructor: (w, h) ->
        super w, h
class Param extends System
    constructor: (w, h) ->
        super w, h
    drawRect: (color) ->
        surface = new Surface(@w, @h)
        surface.context.fillStyle = color
        surface.context.fillRect(0, 0, @w, @h, 10)
        surface.context.fill()
        return surface

class TensionGaugeBack extends Param
    constructor: (w, h) ->
        super 610, 25
        @image = @drawRect('#FFFFFF')
        @x = 15
        @y = 75

class TensionGauge extends Param
    constructor: (w, h) ->
        super 600, 15
        @image = @drawRect('#6EB7DB')
        @x = 20
        @y = 80
        @setValue()

    setValue:()->
        tension = 0
        if game.tension != 0
            tension = game.tension / game.slot_setting.tension_max
        @scaleX = tension
        @x = 20 - ((@w - tension * @w) / 2)
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