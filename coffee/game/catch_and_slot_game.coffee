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
        @loadingScene = new preloadScene()
        @width = 480
        @height = 720
        if @debug.toubai
            @scale = 1
        else
            @scale = @getWindowScale()
        @loadingScene = new preloadScene(@width, @height, @debug.toubai)
        @fps = 24
        #画像リスト
        @imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira', 'big-kotori'
                    'heart', 'explosion', 'items', 'coin_pla', 'title', 'discription']
        #音声リスト
        @soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear', 'explosion', 'bgm_maid', 'syan']

        #フィーバーのBGMを一括ロードせずに、フィーバー直前に都度ロードする
        @bgmLoadEveryTime = false
        if @isSumaho　|| @debug.bgmLoadEveryTime
            @bgmLoadEveryTime = true

        @keybind(90, 'z')
        @keybind(88, 'x')
        @keybind(67, 'c')
        @preloadAll()

        #ゲーム中どこからでもアクセスのある数値
        @cut_in_set = 2 #カットインに使うフォルダ番号
        @money_init = 100 #ゲーム開始時の所持金
        @fever = false #trueならフィーバー中
        @fever_down_tension = 0
        @item_kind = 0 #落下アイテムの種類（フレーム）
        @fever_hit_eye = 0 #どの目で当たって今フィーバーになっているか
        @now_item = 0 #現在セット中のアイテム（１つめ）
        @already_added_material = [] #ゲームを開いてから現在までにロードしたμ’ｓの画像や楽曲の素材の番号
        @limit_set_item_num = 3
        @max_set_member_num = 3
        @next_auto_set_member = [] #ソロ楽曲全達成後にフィーバー後自動的に部員に設定されるリスト
        @now_play_fever_bgm = null
        @now_play_fever_bgm_time = 0

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
        @now_speed = 1 #現在の移動速度とジャンプ力
        @auto_bet = 1 #自動的に掛け金を上げる
        @retry = false #リトライ中
        @kaisetu_watched = false #画面説明を見た
        @help_read = [] #読んだヘルプ

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
            'now_speed':1,
            'item_have_now':[],
            'item_set_now':[],
            'member_set_now':[],
            'prev_fever_muse':[],
            'prev_item':[],
            'auto_bet':1,
            'retry':0,
            'kaisetu_watched':0,
            'help_read':[],
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
            @startStoryIfNoData()
            if @debug.force_main_flg is true
                @main_scene = new mainScene()
                @pause_scene = new pauseScene()
                @loadGame()
                @bgmPlayOnTension()
                @pushScene(@main_scene)
                if @debug.force_pause_flg is true
                    @setPauseScene()
                    if @debug.force_help_flg is true
                        @pause_scene.helpDsp(@debug.force_hep_num)
            else if @debug.foece_story_flg is true
                @startTestStory()

    resetMainScene:()->
        @popScene(@main_scene)
        @main_scene = new mainScene()
        @pushScene(@main_scene)

    ###
    タイトルへ戻る
    ###
    returnToTitle:()->
        @bgmStop(@main_scene.bgm)
        @popScene(@pause_scene)
        @popScene(@main_scene)

    ###
    続きからゲーム開始
    ###
    loadGameStart:()->
        @main_scene = new mainScene()
        @loadGame()
        @bgmPlayOnTension()
        @pushScene(@main_scene)
        @retry = false

    ###
    最初からゲーム開始
    ###
    newGameStart:()->
        @main_scene = new mainScene()
        @_loadGameInit()
        @_gameInitSetting()
        @bgmPlayOnTension()
        @pushScene(@main_scene)

    bgmPlayOnTension:()->
        @bgmPlay(@main_scene.bgm, true)

    ###
    現在セットされているメンバーをもとに素材をロードします
    ###
    musePreLoadByMemberSetNow:()->
        roles = @getRoleByMemberSetNow()
        @_beforeLoadForRoles(roles)
        @musePreLoadMulti(roles)
        @musePreLoad()

    _beforeLoadForRoles:(roles)->
        if game.isSumaho() is true
            bgms = []
            bgms.push(@_getFeverBgmName(game.slot_setting.now_muse_num))
            for i, role of roles
                bgms.push(@_getFeverBgmName(role))
            game.spBeforeLoad(bgms)

    _getFeverBgmName:(role)->
        material = game.slot_setting.muse_material_list
        if material[role] is undefined
            role = 20
        bgm = material[role]['bgm'][0]
        return 'sounds/bgm/' + bgm['name'] + '.mp3'

    ###
    現在セットされているメンバーをもとに組み合わせ可能な役の一覧を全て取得します
    ###
    getRoleByMemberSetNow:()->
        max = @max_set_member_num
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
            #if @already_added_material.indexOf(val) == -1
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
            if material['cut_in'+@cut_in_set] != undefined && material['cut_in'+@cut_in_set].length > 0
                for key, val of material['cut_in'+@cut_in_set]
                    @appLoad('images/cut_in'+@cut_in_set+'/'+val.name + '.png')
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
        if @isItemSet(3) and 0 < val
            val = Math.floor(val * 1.3)
        @slot_setting.changeLilleForTension(@tension, val)
        prev_tension = @tension
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

    speedItemHave:()->
        if @isItemHave(21) && @isItemHave(23)
            rslt = 3
        else if @isItemHave(21) || @isItemHave(23)
            rslt = 2
        else
            rslt = 1
        return rslt

    ###
    アイテムの効果を発動する
    ###
    itemUseExe:()->
        if @isItemSet(3)
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
        load_member = []
        @member_set_now = []
        @member_set_now = @slot_setting.getRoleAbleMemberList()
        if @member_set_now.length is 0
            @slot_setting.setMuseMember()
            load_member.push(@slot_setting.now_muse_num)
        else
            @slot_setting.now_muse_num = 0
            load_member = @member_set_now
        @musePreLoadMulti(load_member)

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
        if @fever is false
            @sePlay(@main_scene.gp_stage_front.dicision_se)
            @pause_scene = new pauseScene()
            @pause_scene.keyList.pause = true
            @pushScene(@pause_scene)
            @pause_scene.pause_item_buy_layer.resetItemList()
            @pause_scene.pause_main_layer.statusDsp()
            @pause_scene.pause_main_layer.bet_checkbox.setCheck()
            if @fever is false
                #@nowPlayBgmPause()
                @nowPlayBgmStop()
            else
                @_remainFeverBgm()

    #フィーバー中ならBGMの曲と位置を記憶
    _remainFeverBgm:()->
        @now_play_fever_bgm = @nowPlayBgm
        @nowPlayBgmPause()

    ###
    ポーズシーンをポップする
    ###
    popPauseScene:()->
        @sePlay(@main_scene.gp_stage_front.cancel_se)
        @pause_scene.buttonList.pause = false
        @main_scene.keyList.pause = true
        @main_scene.gp_system.bet_text.setValue()
        @main_scene.offNotItemFallFlg()
        @popScene(@pause_scene)

    setLoadScene:()->
        @load_scene = new loadScene()
        @pushScene(@load_scene)

    popLoadScene:()->
        @popScene(@load_scene)
        if @fever is false
            @nowPlayBgmRestart(true)
        else
            @_restartFeverBgm()

    setKaisetuScene:()->
        @kaisetu_scene = new kaisetuScene()
        @pushScene(@kaisetu_scene)

    popKaisetuScene:()->
        @popScene(@kaisetu_scene)
        @setLoadScene()

    #フィーバー中なら覚えたBGMの曲と位置から再開
    _restartFeverBgm:()->
        @bgmPlay(@now_play_fever_bgm)

    ###
    ストーリー素材ロード終了時に実行
    ###
    multiLoadEnd:()->
        @story_scene.startSceneExe()

    ###
    以前セーブしたデータが無ければタイトル直後にオープニングを流す
    ###
    startStoryIfNoData:()->
        money = @local_storage.getItem('money')
        if money is null
            @startOpStory()

    ###
    オープニング開始
    ###
    startOpStory:()->
        @_pushStory()
        @story_scene.opStart()

    start2ndStory:()->
        @_pushStory()
        @story_scene.story2ndStart()

    start3rdStory:()->
        @_pushStory()
        @story_scene.story3rdStart()

    start4thStory:()->
        @_pushStory()
        @story_scene.story4thStart()

    ###
    エンディング開始
    ###
    startEdStory:()->
        @_pushStory()
        @story_scene.edStart()

    startTestStory:()->
        switch @debug.test_stroy_episode
            when 1 then @startOpStory()
            when 2 then @start2ndStory()
            when 3 then @start3rdStory()
            when 4 then @start4thStory()
            when 5 then @startEdStory()
            else
                @_pushStory()
                @story_scene.testStart()

    ###
    ストーリー開始
    ###
    _pushStory:()->
        @story_scene = new stolyScene()
        @story_pause_scene = new storyPauseScene()
        @pushScene(@story_scene)

    ###
    ストーリー終了
    ###
    endStory:()->
        @story_scene.bgmStop()
        @popScene(@story_scene)

    ###
    ストーリー一時停止
    ###
    storyPause:()->
        @pushScene(@story_pause_scene)
        @nowPlayBgmPause()

    storyPauseEnd:()->
        @popScene(@story_pause_scene)
        @nowPlayBgmRestart()

    ###
    ゲームをロードする
    ###
    loadGame:()->
        if @debug.test_load_flg is true
            @_loadGameTest()
        else if @debug.not_load_flg is true
            @_loadGameInit()
        else
            @_loadGameProduct()
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
            'now_speed':0,
            'left_lille': [],
            'middle_lille': [],
            'right_lille': [],
            'item_have_now':[],
            'item_set_now':[],
            'member_set_now':[],
            'prev_fever_muse':[],
            'help_read':[],
            'max_set_item_num':0,
            'prev_item':[],
            'auto_bet':0,
            'retry':0,
            'kaisetu_watched':0
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
        @local_storage.clear()
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
            'help_read':JSON.stringify(@help_read),
            'max_set_item_num':@max_set_item_num,
            'prev_item':JSON.stringify(@prev_item),
            'now_speed': @now_speed,
            'auto_bet':@auto_bet,
            'retry':@retry,
            'kaisetu_watched':@kaisetu_watched
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
            @help_read = @_loadStorage('help_read', 'json')
            @max_set_item_num = @_loadStorage('max_set_item_num', 'num')
            @prev_item = @_loadStorage('prev_item', 'json')
            @now_speed = @_loadStorage('now_speed', 'num')
            @auto_bet = @_loadStorage('auto_bet', 'num')
            @retry = @_loadStorage('retry', 'num')
            @kaisetu_watched = @_loadStorage('kaisetu_watched', 'num')
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
        load_val = @debug.test_load_val
        load_val.left_lille = @arrayCopy(@slot_setting.lille_array_0[0])
        load_val.middle_lille = @arrayCopy(@slot_setting.lille_array_0[1])
        load_val.right_lille = @arrayCopy(@slot_setting.lille_array_0[2])
        @_loadGameFix(load_val)

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
        @help_read = @_loadGameFixUnit(data, 'help_read')
        @slot_setting.now_muse_num = @_loadGameFixUnit(data, 'now_muse_num')
        @main_scene.gp_slot.left_lille.lilleArray = @_loadGameFixUnit(data, 'left_lille')
        @main_scene.gp_slot.middle_lille.lilleArray = @_loadGameFixUnit(data, 'middle_lille')
        @main_scene.gp_slot.right_lille.lilleArray = @_loadGameFixUnit(data, 'right_lille')
        @prev_item = @_loadGameFixUnit(data, 'prev_item')
        @now_speed = @_loadGameFixUnit(data, 'now_speed')
        @auto_bet = @_loadGameFixUnit(data, 'auto_bet')
        @retry = @_loadGameFixUnit(data, 'retry')
        @kaisetu_watched = @_loadGameFixUnit(data, 'kaisetu_watched')

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
        #if @slot_setting.now_muse_num is 0
        #    @slot_setting.setMuseMember()
        if @member_set_now.length is 0
            @autoMemberSetBeforeFever()
        #@musePreLoad()
        sys = @main_scene.gp_system
        sys.money_text.setValue()
        sys.bet_text.setValue()
        sys.combo_text.setValue()
        sys.combo_text.setXposition()
        sys.tension_gauge.setValue()
        sys.itemDsp()
        @slot_setting.setMemberItemPrice()
        @slot_setting.setItemPointMax()
        @slot_setting.setItemDecreasePoint()
        @musePreLoadByMemberSetNow()
        @itemUseExe()
        @main_scene.gp_system.whiteOut()
        @main_scene.setTension05()
        if @retry is true
            @main_scene.gp_system.changeBetChangeFlg(false)
    _mainSeneResetSetting:()->
        sys = @main_scene.gp_system
        sys.money_text.setValue()
        sys.bet_text.setValue()
        sys.combo_text.setValue()
        sys.combo_text.setXposition()
        sys.tension_gauge.setValue()
        sys.itemDsp()

    feverEnd:()->
        @fever = false
        @main_scene.gp_system.changeBetChangeFlg(true)
        @slot_setting.betUpExe()
        if @debug.not_auto_save is false
            @saveGame()
        @resetMainScene()
        @_mainSeneResetSetting()
        @bgmPlay(@main_scene.bgm, true)
        if @debug.not_fever_end_menu is false
            @setPauseScene()
            @pause_scene.helpDspAuto()