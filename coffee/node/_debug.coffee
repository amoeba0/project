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

        #ゲーム開始時ロードをしない
        @not_load_flg = false
        #テストロードに切り替え
        @test_load_flg = false
        #テストロード用の値
        @test_load_val = {
            'money':10000,
            'bet':10,
            'combo':10,
            'tension':100,
            'past_fever_num':0,
            'prev_muse':[11],
            'item_have_now':[],
            'prev_fever_muse':[11]
        }

        #デバッグ用リールにすりかえる
        @lille_flg = false
        #デバッグ用リール配列
        @lille_array = [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]

        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = false
        #アイテムが降ってくる頻度を上げる
        @item_fall_early_flg = false
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

        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = 0
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @force_pause_flg is true
            @force_main_flg = true