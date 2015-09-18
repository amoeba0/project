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
        @fps = 24
        #画像リスト
        @imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira', 'big-kotori', 'heart', 'explosion']
        #音声リスト
        @soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear', 'explosion']

        @keybind(90, 'z')
        @keybind(88, 'x')
        @preloadAll()

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
        @item_have_now = []

        @money = @money_init

    onload:() ->
        @title_scene = new titleScene()
        @main_scene = new mainScene()
        @pause_scene = new pauseScene()
        #テスト
        if @test.test_exe_flg is true
            @test_scene = new testScene()
            @pushScene(@test_scene)
            @test.testExe()
        else
            @loadGame()
            if @debug.force_main_flg is true
                @pushScene(@main_scene)
                if @debug.force_pause_flg is true
                    @pushScene(@pause_scene)
            else
                @pushScene(@title_scene)
            #一人目のμ’ｓメンバーを決めて素材をロードする
            if @slot_setting.now_muse_num is 0
                @slot_setting.setMuseMember()
            @musePreLoad()

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
        val = @slot_setting.setTensionMissItem()
        @tensionSetValue(val)

    ###
    スロットが当たった時にテンションゲージを増減する
    @param number prize_money 当選金額
    @param number hit_eye     当たった目の番号
    ###
    tensionSetValueSlotHit:(prize_money, hit_eye)->
        val = @slot_setting.setTensionSlotHit(prize_money, hit_eye)
        @tensionSetValue(val)
    ###
    ポーズシーンをセットする
    ###
    setPauseScene:()->
        @pause_scene.keyList.pause = true
        @pushScene(@pause_scene)
    ###
    ポーズシーンをポップする
    ###
    popPauseScene:()->
        @pause_scene.buttonList.pause = false
        @main_scene.keyList.pause = true
        @popScene(@pause_scene)

    ###
    ゲームをロードする
    ###
    loadGame:()->
        if @debug.not_load_flg is false
            if @debug.test_load_flg is false
                @_loadGameProduct()
            else
                @_loadGameTest()
            @_gameInitSetting()
    ###
    ゲームをセーブする、ブラウザのローカルストレージへ
    ###
    saveGame:()->
        saveData = {
            'money'    : @money,
            'bet'      : @bet,
            'combo'    : @combo,
            'tension'  : @tension,
            'past_fever_num' : @past_fever_num,
            'prev_muse': JSON.stringify(@slot_setting.prev_muse),
            'now_muse_num': @slot_setting.now_muse_num,
            'left_lille': JSON.stringify(@main_scene.gp_slot.left_lille.lilleArray),
            'middle_lille': JSON.stringify(@main_scene.gp_slot.middle_lille.lilleArray),
            'right_lille': JSON.stringify(@main_scene.gp_slot.right_lille.lilleArray),
            'item_have_now':JSON.stringify(@item_have_now)
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
            @bet = @_loadNumber('bet')
            @combo = @_loadNumber('combo')
            @tension = @_loadNumber('tension')
            @past_fever_num = @_loadNumber('past_fever_num')
            @slot_setting.prev_muse = JSON.parse(@local_storage.getItem('prev_muse'))
            @slot_setting.now_muse_num = @_loadNumber('now_muse_num')
            @main_scene.gp_slot.left_lille.lilleArray = JSON.parse(@local_storage.getItem('left_lille'))
            @main_scene.gp_slot.middle_lille.lilleArray = JSON.parse(@local_storage.getItem('middle_lille'))
            @main_scene.gp_slot.right_lille.lilleArray = JSON.parse(@local_storage.getItem('right_lille'))
            @item_have_now = JSON.parse(@local_storage.getItem('item_have_now'))
    ###
    ローカルストレージから指定のキーの値を取り出して数値に変換する
    ###
    _loadNumber:(key)->
        val = @local_storage.getItem(key)
        return parseInt(val)

    ###
    ゲームのロードテスト用、デバッグの決まった値
    ###
    _loadGameTest:()->
        data = @debug.test_load_val
        @money = data.money
        @bet = data.bet
        @combo = data.combo
        @tension = data.tension
        @past_fever_num = data.past_fever_num
        @slot_setting.prev_muse = data.prev_muse
        @item_have_now = data.item_have_now

    ###
    ゲームロード後の画面表示等の初期値設定
    ###
    _gameInitSetting:()->
        sys = @main_scene.gp_system
        sys.money_text.setValue()
        sys.bet_text.setValue()
        sys.combo_text.setValue()
        sys.tension_gauge.setValue()
        @pause_scene.pause_item_buy_layer.resetItemList()