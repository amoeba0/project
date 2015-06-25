###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super

        #全てのデバッグフラグをONにする
        @all_debug_flg = false

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
        #デバッグ用リール配列
        @lille_array = [
            [7,1],
            [1,7],
            [7,1]
        ]
        #アイテムを取った時のテンション増減固定値
        @fix_tention_item_catch_val = 50
        #アイテムを落とした時のテンション増減固定値
        @fix_tention_item_fall_val = -1
        #スロットが当たった時のテンション増減固定値
        @fix_tention_slot_hit_flg = 200

        if @all_debug_flg is true
            @lille_flg = true
            @item_flg = true
            @item_fall_early_flg = true
            @fix_tention_item_catch_flg = true
            @fix_tention_item_fall_flg = true
            @fix_tention_slot_hit_flg = true