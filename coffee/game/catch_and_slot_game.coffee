class catchAndSlotGame extends appGame
    constructor:(w, h)->
        super w, h

#TODO フィーバー中はセーブ出来ないようにする
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
        @imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira', 'big-kotori'
                    'heart', 'explosion', 'items', 'coin_pla']
        #音声リスト
        @soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear', 'explosion', 'bgm/bgm1']

        @keybind(90, 'z')
        @keybind(88, 'x')
        @preloadAll()

        #ゲーム中どこからでもアクセスのある数値
        @money_init = 100 #ゲーム開始時の所持金
        @fever = false #trueならフィーバー中
        @fever_down_tension = 0
        @item_kind = 0 #落下アイテムの種類（フレーム）
        @fever_hit_eye = 0 #どの目で当たって今フィーバーになっているか
        @now_item = 0 #現在セット中のアイテム（１つめ）
        @already_added_material = [] #ゲームを開いてから現在までにロードしたμ’ｓの画像や楽曲の素材の番号

        #セーブする変数(slot_settingにもあるので注意)
        @money = 0 #現在の所持金
        @bet = 1 #現在の掛け金
        @combo = 0 #現在のコンボ
        @tension = 0 #現在のテンション(500がマックス)
        @item_point = 500 #アイテムのポイント（500がマックス）
        @past_fever_num = 0 #過去にフィーバーになった回数
        @next_add_member_key = 0 #メンバーがセットされている場合、次に挿入されるメンバーの配列のキー
        @item_have_now = [] #現在所持しているアイテム
        @item_set_now = [] #現在セットされているアイテム
        @member_set_now = [] #現在セットされているメンバー
        @prev_fever_muse = [] #過去にフィーバーになったμ’ｓメンバー（ユニット番号も含む）

        @money = @money_init

    onload:() ->
        @title_scene = new titleScene()
        @main_scene = new mainScene()
        @pause_scene = new pauseScene()
        @loadGame()
        #テスト
        if @test.test_exe_flg is true
            @test_scene = new testScene()
            @pushScene(@test_scene)
            @test.testExe()
        else
            if @debug.force_main_flg is true
                @bgmPlay(@main_scene.bgm, true)
                @pushScene(@main_scene)
                if @debug.force_pause_flg is true
                    @pushScene(@pause_scene)
            else
                @pushScene(@title_scene)

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
        roles = game.arrayCopy(@member_set_now)
        tmp = @member_set_now
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
        @tension += val
        if @tension < 0
            @tension = 0
        else if @tension > @slot_setting.tension_max
            @tension = @slot_setting.tension_max
        @main_scene.gp_system.tension_gauge.setValue()

    ###
    現在アイテムがセットされているかを確認する
    ###
    isItemSet:(kind)->
        rslt = false
        if game.item_set_now.indexOf(kind) != -1
            rslt = true
        return rslt

    ###
    アイテムの効果を発動する
    ###
    itemUseExe:()->
        if @isItemSet(1)
            @main_scene.gp_stage_front.player.setMxUp()
        else
            @main_scene.gp_stage_front.player.resetMxUp()
        if @isItemSet(3)
            @main_scene.gp_stage_front.player.setMyUp()
        else
            @main_scene.gp_stage_front.player.resetMyUp()

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
        @nowPlayBgmPause()
    ###
    ポーズシーンをポップする
    ###
    popPauseScene:()->
        @pause_scene.buttonList.pause = false
        @main_scene.keyList.pause = true
        @popScene(@pause_scene)
        @nowPlayBgmRestart()

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
    ロードするデータの空の値
    ###
    _defaultLoadData:(key)->
        data = {
            'money'    : 0,
            'bet'      : 0,
            'combo'    : 0,
            'tension'  : 0,
            'past_fever_num' : 0,
            'item_point' : 0,
            'prev_muse': '[]',
            'now_muse_num': 0,
            'next_add_member_key': 0,
            'left_lille': '[]',
            'middle_lille': '[]',
            'right_lille': '[]',
            'item_have_now':'[]',
            'item_set_now':'[]',
            'member_set_now':'[]',
            'prev_fever_muse':'[]'
        }
        ret = null
        if data[key] is undefined
            console.error(key+'のデータのロードに失敗しました。')
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
            'tension'  : @tension,
            'past_fever_num' : @past_fever_num,
            'item_point' : @item_point,
            'prev_muse': JSON.stringify(@slot_setting.prev_muse),
            'now_muse_num': @slot_setting.now_muse_num,
            'next_add_member_key': @next_add_member_key,
            'left_lille': JSON.stringify(@main_scene.gp_slot.left_lille.lilleArray),
            'middle_lille': JSON.stringify(@main_scene.gp_slot.middle_lille.lilleArray),
            'right_lille': JSON.stringify(@main_scene.gp_slot.right_lille.lilleArray),
            'item_have_now':JSON.stringify(@item_have_now),
            'item_set_now':JSON.stringify(@item_set_now),
            'member_set_now':JSON.stringify(@member_set_now),
            'prev_fever_muse':JSON.stringify(@prev_fever_muse)
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
            @tension = @_loadStorage('tension', 'num')
            @past_fever_num = @_loadStorage('past_fever_num', 'num')
            @item_point = @_loadStorage('item_point', 'num')
            @next_add_member_key = @_loadStorage('next_add_member_key', 'num')
            @slot_setting.prev_muse = @_loadStorage('prev_muse', 'json')
            @slot_setting.now_muse_num = @_loadStorage('now_muse_num', 'num')
            @main_scene.gp_slot.left_lille.lilleArray = @_loadStorage('left_lille', 'json')
            @main_scene.gp_slot.middle_lille.lilleArray = @_loadStorage('middle_lille', 'json')
            @main_scene.gp_slot.right_lille.lilleArray = @_loadStorage('right_lille', 'json')
            @item_have_now = @_loadStorage('item_have_now', 'json')
            @item_set_now = @_loadStorage('item_set_now', 'json')
            @member_set_now = @_loadStorage('member_set_now', 'json')
            @prev_fever_muse = @_loadStorage('prev_fever_muse', 'json')
    ###
    ローカルストレージから指定のキーの値を取り出して返す
    @param string key ロードするデータのキー
    @param string type ロードするデータのタイプ（型） num json
    ###
    _loadStorage:(key, type)->
        ret = null
        val = @local_storage.getItem(key)
        if val is null
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
        data = @debug.test_load_val
        @money = data.money
        @bet = data.bet
        @combo = data.combo
        @tension = data.tension
        @past_fever_num = data.past_fever_num
        @item_point = data.item_point
        @next_add_member_key = data.next_add_member_key
        @slot_setting.prev_muse = data.prev_muse
        @slot_setting.now_muse_num = data.now_muse_num
        @item_have_now = data.item_have_now
        @item_set_now = data.item_set_now
        @prev_fever_muse = data.prev_fever_muse
        @member_set_now = data.member_set_now

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
        sys.tension_gauge.setValue()
        sys.itemDsp()
        @pause_scene.pause_item_buy_layer.resetItemList()
        @pause_scene.pause_item_use_layer.dspSetItemList()
        @pause_scene.pause_member_set_layer.dispSetMemberList()
        @slot_setting.setMemberItemPrice()
        @slot_setting.setItemPointValue()
        @musePreLoadByMemberSetNow()
        @itemUseExe()