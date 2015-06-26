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
        @money_init = 10000 #ゲーム開始時の所持金
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
