class appGame extends Game
    constructor:(w, h)->
        super w, h
        if @isSumaho() is false
            @scale = 1
        @is_server = false
        @mute = false #ミュート（消音）フラグ
        @imgList = []
        @soundList = []
        @nowPlayBgm = null
        @loadedFile = [] #ロード済みのファイル
    ###
        画像の呼び出し
    ###
    imageload:(img) ->
        callImg = @assets["images/"+img+".png"]
        if callImg is undefined
            callImg = null
        return callImg

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
    bgmPlay:(bgm, bgm_loop = false)->
        if bgm != undefined
            bgm.play()
            @nowPlayBgm = bgm
            if bgm_loop is true
                if @is_server is true
                    bgm.src.loop = true
                else
                    bgm._element.loop = true

    ###
    BGMを止める
    ###
    bgmStop:(bgm)->
        if bgm != undefined
            bgm.stop()
            @nowPlayBgm = null

    ###
    BGMの中断
    ###
    bgmPause:(bgm)->
        if bgm != undefined
            bgm.pause()

    ###
    現在再生中のBGMを一時停止する
    ###
    nowPlayBgmPause:()->
        if @nowPlayBgm != null
            @bgmPause(@nowPlayBgm)

    ###
    現在再生中のBGMを再開する
    ###
    nowPlayBgmRestart:(bgm_loop = false)->
        if @nowPlayBgm != null
            @bgmPlay(@nowPlayBgm, bgm_loop)

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
    enchant.jsのload関数をラッピング
    ロード終了後にloadedFileにロードしたファイルを置いておいて、ロード済みかどうかの判別に使う
    ###
    appLoad:(file)->
        @load(file)
        #if @loadedFile.indexOf(file) is -1
        #@load(file, @setLoadedFile(file))

    ###
    ロード済みのファイルを記憶しておく
    ###
    setLoadedFile:(file)->
        @loadedFile.push(file)

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
    ###
    配列から指定の値を削除して詰めて返す
    @param arr    対象の配列
    @param target 削除する値
    @return array
    ###
    arrayValueDel:(arr, target)->
        arr.some((v, i)->
            if v == target
                arr.splice(i, 1)
        )
        return arr

    ###
    targetの配列の中にsearchの配列が全て入っていたらtrueを返す
    １つでも入っていなかったらfalseを返す
    @param arr target 検索する対象の配列
    @param arr search 検索する文字列を格納した配列
    @return boolean
    ###
    arrIndexOf:(target, search)->
        rslt = true
        for searchVal in search
            if target.indexOf(searchVal) is -1
                rslt = false
                break
        return rslt

    ###
    数値の単位を漢数字で区切る
    ###
    toJPUnit:(num)->
        str = num + ''
        n = ''
        n_ = ''
        count = 0
        ptr = 0
        kName = ['', '万', '億', '兆', '京', '垓']
        i = str.length - 1
        while i >= 0
            n_ = str.charAt(i) + n_
            count++
            if count % 4 == 0 and i != 0
                if n_ != '0000'
                    n = n_ + kName[ptr] + n
                n_ = ''
                ptr += 1
            if i == 0
                n = n_ + kName[ptr] + n
            i--
        return n

    ###
    ユーザーエージェントの判定
    ###
    userAgent:()->
        u = window.navigator.userAgent.toLowerCase()
        mobile = {
            0: u.indexOf('windows') != -1 and u.indexOf('phone') != -1 or u.indexOf('iphone') != -1 or u.indexOf('ipod') != -1 or u.indexOf('android') != -1 and u.indexOf('mobile') != -1 or u.indexOf('firefox') != -1 and u.indexOf('mobile') != -1 or u.indexOf('blackberry') != -1
            iPhone: u.indexOf('iphone') != -1
            Android: u.indexOf('android') != -1 and u.indexOf('mobile') != -1
        }
        tablet = u.indexOf('windows') != -1 and u.indexOf('touch') != -1 or u.indexOf('ipad') != -1 or u.indexOf('android') != -1 and u.indexOf('mobile') == -1 or u.indexOf('firefox') != -1 and u.indexOf('tablet') != -1 or u.indexOf('kindle') != -1 or u.indexOf('silk') != -1 or u.indexOf('playbook') != -1
        pc = !mobile[0] and !tablet
        return {
            Mobile: mobile
            Tablet: tablet
            PC: pc
        }
    ###
    スマホかタブレットならtrueを返す
    ###
    isSumaho:()->
        ua = @userAgent()
        rslt = false
        if ua.Mobile[0] is true || ua.Tablet is true
            rslt = true
        return rslt