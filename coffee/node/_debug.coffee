###
デバッグ用設定
###
class Debug extends appNode
    constructor: () ->
        super
        #デバッグ用リールにすりかえる
        @lille_flg = false
        #デバッグ用リール配列
        @lille_array = [
            [2,3],
            [3,2],
            [2,3]
        ]