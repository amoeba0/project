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
        @imgList = ['chara1', 'icon1', 'lille', 'under_frame']
        #音声リスト
        @sondList = []
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false}
        @keybind(90, 'z')
        @preloadAll()

        #ゲーム中どこからでもアクセスのある数値
        @money_init = 10000 #ゲーム開始時の所持金
        @money = 0 #現在の所持金
        @bet = 55 #現在の掛け金

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
        # ジャンプ
        if @input.z is true
            if @keyList.jump is false
                @keyList.jump = true
        else
            if @keyList.jump is true
                @keyList.jump = false
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
        @catchItems = [] #キャッチアイテムのコンストラクタを格納
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
            game.main_scene.gp_system.money_text.setValue()
            game.main_scene.gp_slot.slotStart()

###
ステージ背面
コインがある
###
class stageBack extends gpStage
    constructor: () ->
        super
        @prizeMoneyItemsConstructor = [] #スロット当選金のコンストラクタを格納
        @prizeMoneyItemsNum = {1:0,10:0,100:0,1000:0} #当選金を降らせる各コイン数の内訳
        @nowPrizeMoneyItemsNum = 0
        @prizeMoneyFallIntervalFrm = 6 #スロットの当選金を降らせる間隔（フレーム）
        @prizeMoneyFallPeriodSec = 5 #スロットの当選金額が振っている時間（秒）
        @isFallPrizeMoney = false #スロットの当選金が振っている間はtrue
    ###
    スロットの当選金額を降らせる
    @param value number 金額
    ###
    fallPrizeMoneyStart:(value) ->
        @_calcPrizeMoneyItemsNum(value)
        @_setPrizeMoneyItemsConstructor()
        console.log(@prizeMoneyItemsConstructor)

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
    当選金コインのコンストラクタを設置
    ###
    _setPrizeMoneyItemsConstructor:()->
        @prizeMoneyItemsConstructor = []
        if @prizeMoneyItemsNum[1] > 0
            for i in [1..@prizeMoneyItemsNum[1]]
                @prizeMoneyItemsConstructor.push(new OneHomingMoney)
        if @prizeMoneyItemsNum[10] > 0
            for i in [1..@prizeMoneyItemsNum[10]]
                @prizeMoneyItemsConstructor.push(new TenHomingMoney)
        if @prizeMoneyItemsNum[100] > 0
            for i in [1..@prizeMoneyItemsNum[100]]
                @prizeMoneyItemsConstructor.push(new HundredHomingMoney)
        if @prizeMoneyItemsNum[1000] > 0
            for i in [1..@prizeMoneyItemsNum[1000]]
                @prizeMoneyItemsConstructor.push(new ThousandHomingMoney)
class gpSystem extends appGroup
    constructor: () ->
        super
        @money_text = new moneyText()
        @addChild(@money_text)
        @bet_text = new betText()
        @addChild(@bet_text)

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
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
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
        @font = @font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
        @x = 10
        @y = 10
        @kakekin_text = '掛金'
        @yen_text = '円'
        @setValue()
    setValue: () ->
        @text = @kakekin_text + game.bet + @yen_text
###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super
        #デバッグ用リールにすりかえる
        @lille_flg = true
        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = true
        #アイテムが降ってくる頻度を上げる
        @item_fall_early_flg = true
        #デバッグ用リール配列
        @lille_array = [
            [2,3],
            [3,2],
            [2,3]
        ]
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
        super 96, 96
        @image = game.imageload("chara1")
        @x = 0
        @y = 0
class Item extends appObject
    constructor: (w, h) ->
        super w, h
        @vx = 0 #x軸速度
        @vy = 0 #y軸速度
    ###
    地面に落ちたら消す
    ###
    removeOnFloor:()->
        if @y > game.height + @h
            @parentNode.removeChild(@)
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
            console.log('hit!')
            game.main_scene.gp_slot.slotStop()
    ###
    座標と落下速度の設定
    ###
    setPosition:(gravity)->
        @y = @h * -1
        @x = @_setPositoinX()
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
        super 48, 48
        @image = game.imageload("icon1")
        @frame = 1
###
降ってくるお金
###
class Money extends Item
    constructor: (w, h) ->
        super w, h
        @price = 1 #単価
        super 48, 48
        @image = game.imageload("icon1")

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
            game.money += @price
            game.main_scene.gp_system.money_text.setValue()

###
ホーミングする
###
class HomingMoney extends Money
    constructor: (w, h) ->
        super w, h

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