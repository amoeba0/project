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
        @imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira']
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

        @money = @money_init

    onload:() ->
        @title_scene = new titleScene()
        @main_scene = new mainScene()
        @pause_scene = new pauseScene()
        if @debug.force_main_flg is true
            @pushScene(@main_scene)
            if @debug.force_pause_flg is true
                @pushScene(@pause_scene)
        else
            @pushScene(@title_scene)

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
        ls = window.localStorage
        money = ls.getItem('money')
        if money != null
            @money = money
            @bet = ls.getItem('bet')
            @combo = ls.getItem('combo')
            @tension = ls.getItem('tension')
            @past_fever_num = ls.getItem('past_fever_num')
            @slot_setting.prev_muse = JSON.parse(ls.getItem('prev_muse'))