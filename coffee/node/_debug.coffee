###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super
        #デバッグ用リールにすりかえる
        @lille_flg = false
        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = false
        #アイテムが降ってくる頻度を上げる
        @item_fall_early_flg = false
        #デバッグ用リール配列
        @lille_array = [
            [1,7],
            [7,1],
            [1,7]
        ]