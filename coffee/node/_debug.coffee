###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super
        #デバッグ用リールにすりかえる
        @lille_flg = true
        #降ってくるアイテムの位置が常にプレイヤーの頭上
        @item_flg = true
        #アイテムが降ってくる頻度を上げる
        @item_fall_early_flg = true
        #デバッグ用リール配列
        @lille_array = [
            [2,3],
            [3,2],
            [2,3]
        ]