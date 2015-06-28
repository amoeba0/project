class catchAndSlotGame extends appGame
    constructor:(w, h)->
        super w, h

class LoveliveGame extends catchAndSlotGame
    constructor:()->
        super @width, @height
        @debug = new Debug()
        @slot_setting = new slotSetting()
        @width = 640
        @height = 960
        @fps = 24
        #画像リスト
        @imgList = ['chun', 'sweets', 'lille', 'under_frame', 'okujou', 'sky', 'coin']
        #音声リスト
        @soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear', 'zenkai_no_lovelive']
        #キーのリスト、物理キーとソフトキー両方に対応
        @keyList = {'left':false, 'right':false, 'jump':false, 'up':false, 'down':false}
        @keybind(90, 'z')
        @preloadAll()
        #一人目のμ’ｓメンバーを決めて素材をロードする
        @slot_setting.setMuseMember()
        @musePreLoad()

        #ゲーム中どこからでもアクセスのある数値
        @money_init = 100 #ゲーム開始時の所持金
        @money = 0 #現在の所持金
        @bet = 1 #現在の掛け金
        @combo = 0 #現在のコンボ
        @tension = 0 #現在のテンション(500がマックス)
        @fever = false #trueならフィーバー中
        @fever_down_tension = 0
        @item_kind = 0 #落下アイテムの種類（フレーム）

    onload:() ->
        @gameInit()
        @main_scene = new mainScene()
        @pushScene(@main_scene)

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

    ###
    ゲーム開始時の初期数値調整
    ###
    gameInit:() ->
        @money = @money_init

    onenterframe: (e) ->
        @buttonPush()
        @tensionSetValueFever()

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
        @_tensionSetValue(val)
    ###
    アイテムを落とした時にテンションゲージを増減する
    ###
    tensionSetValueItemFall:()->
        val = @slot_setting.setTensionItemFall()
        @_tensionSetValue(val)

    ###
    はずれのアイテムを取った時にテンションゲージを増減する
    ###
    tensionSetValueMissItemCatch:()->
        val = @slot_setting.setTensionItemFall()
        @_tensionSetValue(val)

    ###
    フィーバー中に一定時間でテンションが下がる
    テンションが0になったらフィーバーを解く
    ###
    tensionSetValueFever:()->
        if @fever is true
            @_tensionSetValue(@fever_down_tension)
            if @tension <= 0
                @bgmStop(@main_scene.gp_slot.fever_bgm)
                @fever = false

    ###
    スロットが当たった時にテンションゲージを増減する
    @param number prize_money 当選金額
    @param number hit_eye     当たった目の番号
    ###
    tensionSetValueSlotHit:(prize_money, hit_eye)->
        val = @slot_setting.setTensionSlotHit(prize_money, hit_eye)
        @_tensionSetValue(val)
