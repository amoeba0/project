class appGame extends Game
    constructor:(w, h)->
        super w, h
        #ミュート（消音）フラグ
        @scale = 1
        @mute = false
        @imgList = []
        @soundList = []
    ###
        画像の呼び出し
    ###
    imageload:(img) ->
        return @assets["images/"+img+".png"]

    ###
        音声の呼び出し
    ###
    soundload:(sound) ->
        return @assets["sounds/"+sound+".mp3"]

    ###
    効果音を鳴らす
    ###
    sePlay:(se)->
        se.clone().play()

    ###
    BGMをならす
    ###
    bgmPlay:(bgm, bgm_loop)->
        if bgm != undefined
            bgm.play()
            if bgm_loop is true
                bgm._element.loop = true
                #bgm.src.loop = true

    ###
    BGMを止める
    ###
    bgmStop:(bgm)->
        if bgm != undefined
            bgm.stop()

    ###
        素材をすべて読み込む
    ###
    preloadAll:()->
        tmp = []
        if @imgList?
            for val in @imgList
                tmp.push "images/"+val+".png"
        if @mute is false and @soundList?
            for val in @soundList
                tmp.push "sounds/"+val+".mp3"
        @preload(tmp)

    ###
    数値から右から数えた特定の桁を取り出して数値で返す
    @param number num   数値
    @param number digit 右から数えた桁数、例：1の位は１、10の位は２、１００の位は３
    @return number
    ###
    getDigitNum:(num, digit)->
        tmp_num = num + ''
        split_num = tmp_num.length - digit
        split = tmp_num.substring(split_num, split_num + 1)
        result = Number(split)
        return result

    ###
    配列、オブジェクトの参照渡しを防ぐためにコピーする
    http://monopocket.jp/blog/javascript/2137/
    @param array or object target コピー対象
    @param boolean isObject true:object false:array
    @return array or object
    ###
    arrayCopy:(target, isObject = false)->
        if isObject is true
            tmp_arr = {}
        else
            tmp_arr = []
        return $.extend(true, tmp_arr, target)

    ###
    配列から重複を除外したリストを返す
    ###
    getDeduplicationList:(arr)->
        return arr.filter(
            (x, i, self)->
                return self.indexOf(x) == i
        )
    ###
    数値の昇順ソート
    ###
    sortAsc:(arr)->
        return arr.sort(
            (a,b)->
                if a < b
                    return -1
                if a > b
                    return 1
                return 0
        )
    ###
    数値の降順ソート
    ###
    sortDesc:(arr)->
        return arr.sort(
            (a,b)->
                if a > b
                    return -1
                if a < b
                    return 1
                return 0
        )