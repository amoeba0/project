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