###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #開始後いきなりメイン画面
        @force_main_flg = false
        #開始後いきなりポーズ画面
        @force_pause_flg = false
        #開始後いきなりヘルプ
        @force_help_flg = false
        #開始後表示するヘルプの番号
        @force_hep_num = 7
        #開始後いきなりオープニング
        @foece_story_flg = false
        #デバッグで流すストーリーのエピソード
        @test_stroy_episode = 1
        #フィーバーのBGMを一括ロードせずに、フィーバー直前に都度ロードする
        @bgm_load_every_time = false

        #ゲーム開始時ロードをしない シークレットウィンドウでテストする時はtrueにする
        @not_load_flg = false
        #テストロードに切り替え
        @test_load_flg = false
        #テストロード用の値
        @test_load_val = {
            'money':Math.pow(10, 24),
            'bet':Math.pow(10, 22),
            'combo':20,
            'max_combo':200,
            'tension':200,
            'past_fever_num':3,
            'item_point':1500,
            'next_add_member_key':0,
            'now_muse_num':0,
            'max_set_item_num':3,
            'now_speed':3,
            'item_have_now':[1,2,3,4,5,6,7,8,9,21,22,23,24],
            'item_set_now':[3,4,8],
            'member_set_now':[],
            'prev_fever_muse':[],
            'prev_item':[],
            'left_lille':[],
            'middle_lille':[],
            'right_lille':[],
            'retry':0,
            'kaisetu_watched':0,
            'help_read':[]
        }

        #デバッグ用リールにすりかえる
        @lille_flg = false

        #デバッグ用リール配列
        @lille_array = [
            [11,4,13,4,1,2,5,12,4,2,5,15,4,1,2,3,1,4,1,3],
            [4,3,13,15,2,4,3,1,2,4,5,12,2,4,3,1,2,11,5,1],
            [15,5,4,2,1,3,1,2,11,3,5,4,2,1,3,4,2,12,4,13]
        ]
        ###
        @lille_array = [
            [11, 11, 11, 11, 11, 11, 11, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [12, 12, 12, 12, 12, 12, 12, 12, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [13, 13, 13, 13, 13, 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]
        ###

        #画面が白一色で覆われる、ｃキーで切り替え可能
        @white_back = false
        #ゲームのサイズが等倍
        @toubai = false
        #自動セーブしない シークレットウィンドウでテストする時はtrueにする
        @not_auto_save = false

        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = false
        #アイテムが降ってくる頻度を上げる
        #@item_fall_early_flg = false
        #アイテムを取った時のテンション増減値を固定する
        @fix_tention_item_catch_flg = false
        #アイテムを落とした時のテンション増減値を固定する
        @fix_tention_item_fall_flg = false
        #スロットが当たった時のテンション増減値を固定する
        @fix_tention_slot_hit_flg = false
        #スロットに必ずμ’ｓが追加される
        @force_insert_muse = false
        #スロットが必ず当たる
        @force_slot_hit = false
        #スロットが2回に1回当たる
        @half_slot_hit = false
        #スロットが強制的に当たるときに必ずフィーバーになる
        @force_fever = false
        #ミスアイテムが降らない
        @not_miss_item_flg = false
        #フィーバー時間が短い
        @short_fever = false
        #フィーバー終了時にメニュー画面が開かない
        @not_fever_end_menu = false

        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 1
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = 0
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 1

        if @force_help_flg is true
            @force_pause_flg = true

        if @force_pause_flg is true
            @force_main_flg = true