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
                @bgmPlay(@main_scene.bgm, true)
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
        @bgmPlay(@main_scene.bgm, true)
        @pushScene(@main_scene)

    ###
    最初からゲーム開始
    ###
    newGameStart:()->
        @main_scene = new mainScene()
        @pause_scene = new pauseScene()
        @_loadGameInit()
        @_gameInitSetting()
        @bgmPlay(@main_scene.bgm, true)
        @pushScene(@main_scene)

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
        max = @pause_scene.pause_member_set_layer.max_set_member_num
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
        @_loadGameFix(@debug.test_load_val)

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