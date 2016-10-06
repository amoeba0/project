class gpPanorama extends appGroup
    constructor:()->
        super

class gpBackPanorama extends gpPanorama
    constructor: () ->
        super
        @back_panorama = new BackPanorama()
        @big_kotori = new bigKotori()
        @now_back_effect_flg = false #背景レイヤーのエフェクトを表示中ならtrue
        @back_effect_rate = 300 #背景レイヤーのエフェクトが表示される確率
        @addChild(@back_panorama)
    ###
    背景レイヤーのエフェクト表示を開始
    ###
    setBackEffect:()->
        if game.fever is false && @now_back_effect_flg is false
            random = Math.floor(Math.random() * @back_effect_rate)
            if random is 1
                @_setBigKotori()
    ###
    進撃のことりを設置
    ###
    _setBigKotori:()->
        @big_kotori.setInit()
        @addChild(@big_kotori)
        @now_back_effect_flg = true
    ###
    進撃のことりを終了
    ###
    endBigKotori:()->
        @removeChild(@big_kotori)
        @now_back_effect_flg = false

class gpFrontPanorama extends gpPanorama
    constructor:()->
        super
        @front_panorama = new FrontPanorama()
        @addChild(@front_panorama)