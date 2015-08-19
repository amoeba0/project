###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #全てのデバッグフラグをONにする
        @all_debug_flg = false

        #開始後いきなりメイン画面
        @force_main_flg = true
        #開始後いきなりポーズ画面
        @force_pause_flg = false

        #デバッグ用リールにすりかえる
        @lille_flg = false
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
        #デバッグ用リール配列
        @lille_array = [
            [11, 12, 11],
            [12, 11, 11],
            [11, 12, 11]
        ]
        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = 0
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @all_debug_flg is true
            @lille_flg = true
            @item_flg = true
            @item_fall_early_flg = true
            @fix_tention_item_catch_flg = true
            @fix_tention_item_fall_flg = true
            @fix_tention_slot_hit_flg = true
            @force_insert_muse = true

        if @force_pause_flg is true
            @force_main_flg = true