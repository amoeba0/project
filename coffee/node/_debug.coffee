###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #全てのデバッグフラグをONにする
        @all_debug_flg = false

        #開始後いきなりポーズ画面
        @force_pause_flg = false

        #デバッグ用リールにすりかえる
        @lille_flg = true
        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = true
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
        #デバッグ用リール配列
        @lille_array = [
            [16, 15],
            [15],
            [15]
        ]
        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = -50
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