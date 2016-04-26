###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #開始後いきなりメイン画面
        @force_main_flg = true
        #開始後いきなりポーズ画面
        @force_pause_flg = false
        #開始後いきなりオープニング
        @foece_story_flg = false

        #ゲーム開始時ロードをしない
        @not_load_flg = false
        #テストロードに切り替え
        @test_load_flg = false
        #テストロード用の値
        @test_load_val = {
            'money':98765432100,
            'bet':10000,
            'combo':0,
            'max_combo':200,
            'tension':0,
            'past_fever_num':0,
            'item_point':500,
            'next_add_member_key':0,
            'now_muse_num':0,
            'max_set_item_num':1,
            'now_speed':1,
            'item_have_now':[3,4,5,12,13,14,15,21,22,23,24],
            'item_set_now':[3],
            'member_set_now':[12,13],
            'prev_fever_muse':[12,13,14,15,16,17,18,19],
            'prev_item':[],
            'left_lille':[],
            'middle_lille':[],
            'right_lille':[]
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
        #自動セーブしない
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
        #@force_insert_muse = false
        #スロットが必ず当たる
        @force_slot_hit = false
        #スロットが2回に1回当たる
        @half_slot_hit = false
        #スロットが強制的に当たるときに必ずフィーバーになる
        @force_fever = false

        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = 0
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @force_pause_flg is true
            @force_main_flg = true