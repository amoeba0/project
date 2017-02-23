class pauseHelpLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new menuDialogHtml()
        @close_button = new helpDialogCloseButton()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @type = 0
        @nowPage = 0
        @txts = {
            0:{
                'title':'test'
                'text' :[
                    'test'
                ]
            },
            1:{
                'title':'スキルについて'
                'text' :[
                    'スキルをセットすることで<br>おやつの落下速度減少や<br>
                    スロットの確率UPなど<br>様々な効果が得られます<br><br>
                    スキルを使用するには<br>SP（スキルポイント）を消費します',
                    '<span class="red">SPはおやつをジャンプして取ると<br>少し回復します</span><br><br>
                    スキルをセットしていない状態でも<br>時間経過で少しづつ回復します',
                    'SPを全て使い切ると<br>セットされていたスキルは<br>
                    自動的に解除され<br>SPが少しづつ回復し始めます<br><br>
                    SPが満タンになると<br>直前にセットされていたスキルが<br>
                    自動的に再設定されます',
                    'また、スキルは<br>特定のトロフィーを購入することで<br>
                    最大３個までセットできるようになります'
                ]
            },
            2:{
                'title':'移動速度とジャンプ力'
                'text' :[
                    '特定のトロフィーを購入することで<br>
                    ことりの移動速度とジャンプ力が<br>調整できるようになります<br><br>
                    <span class="red">掛け金を上げるほど<br>おやつの落下速度が上がる</span>ので<br><br>
                    おやつの落下速度に合わせて<br>適宜調整してください'
                ]
            },
            3:{
                'title':'部員について'
                'text' :[
                    'スロットが揃った時に<br>一定確率で部員のカットインが入ります<br><br>
                    その時スロット内の「リトライ」が<br>左・中・右それぞれ１箇所づつ<br>
                    カットインが入った部員と<br>入れ替わります',
                    'カットインが入る部員は<br>ユニット編成中の部員の中から選ばれます<br><br>
                    編成中の部員がいなければ<br>ランダムで１人の部員が選ばれます',
                    '部員でスロットが揃うと<br>フィーバーが起こります<br><br>
                    フィーバー中には<br>揃ったユニットの楽曲が流れるので<br>
                    ソロ・デュオ・トリオのいずれかで<br>
                    楽曲を持っているユニットを組まないと<br>フィーバーは起こりません<br>
                    （Printemps、LilyWhite、<br>　BiBi、にこりんぱな、etc・・・）',
                    'また、一度フィーバーが起きたユニットでも<br>フィーバーは起こりません',
                    'フィーバー可能なユニットについては<br>「実績」メニューの「楽曲」を確認して下さい<br><br>
                    よくわからなければ<br><span class="red">「おまかせ」を押すと<br>自動でフィーバー可能なユニットが<br>編成されます</span><br><br>
                    また、「おまかせ」を押さなくても<br>フィーバー終了時にユニットは<br>自動的に再編成されます',
                    'なお、部員によって能力みたいな差は<br>一切ありませんので<br>
                    <span class="red">部員を購入する際は「推しメン順」</span><br>で構いません<br><br>
                    手動でユニットを編成する場合も<br>フィーバー可能であれば<br>
                    推しのユニットで問題ありません'
                ]
            },
            4:{
                'title':'楽曲について'
                'text' :[
                    'フィーバー中に流れる楽曲の一覧です<br><br>
                    楽曲はユニットごとに決まっています'
                ]
            },
            5:{
                'title':'トロフィーについて'
                'text' :[
                    'トロフィーを購入することで<br>ストーリーの続きが見られるようになります<br><br>
                    また、トロフィーには持っているだけで<br>移動速度とジャンプ力の上昇<br>
                    スキルのスロットを増やす<br>といった効果が得られる物もあります'
                ]
            },
            6:{
                'title':'フィーバーの周回について'
                'text' :[
                    '１回目のフィーバーが終了しました！<br><br>
                    これから何回もフィーバーを繰り返して<br>
                    お金を溜めていくことになります<br><br>
                    フィーバーが終了すると<br>メニュー画面が出現します<br><br>
                    ここでフィーバー中に溜めたお金を使って<br>
                    「アイテムSHOP」から<br>
                    「スキル」や「部員」、「トロフィー」を購入します',
                    'まずは「100万円」を目指してください<br><br>
                    100万円貯まると<br>「ブロンズトロフィー」が<br>購入できるようになります<br><br>
                    「ブロンズトロフィー」を購入すると<br>
                    ストーリーの第2話が見れるようになります'
                ]
            },
            7:{
                'title':'ペナルティについて'
                'text' :[
                    'おやつを落とすとテンションが少し減り<br>コンボが0になります<br><br>
                    爆弾に当たるとコンボは減りませんが<br>テンションが大幅に減ります<br><br>
                    テンションが全て無くなると<br>今までスロット内に溜めてきた<br>
                    部員が全て消滅してしまいます<br><br>
                    テンションが無くならないように<br>気をつけてください'
                ]
            }
        }
    setHelp:(type)->
        if @txts[type] is undefined then type = 0
        @type = type
        @text = new helpDiscription(@txts[type]['text'][0])
        @title = new helpTitle(@txts[type]['title'])
        @addChild(@text)
        @addChild(@title)
        @ok_btn = new helpOkButtonHtml()
        @next_btn = new helpNextButtonHtml()
        @prev_btn = new helpPrevButtonHtml()
        if @txts[type]['text'].length is 1
            @ok_btn.x = 170
            @addChild(@ok_btn)
        else
            @addChild(@next_btn)
            page = @setPageText()
            @page_num = new pageNum(page)
            @addChild(@page_num)
    goNext:()->
        if @nowPage is 0
            @addChild(@prev_btn)
        @nowPage++
        @text.setText(@txts[@type]['text'][@nowPage])
        page = @setPageText()
        @page_num.setText(page)
        if @txts[@type]['text'].length - 1 <= @nowPage
            @removeChild(@next_btn)
            @addChild(@ok_btn)
    goPrev:()->
        if @txts[@type]['text'].length - 1 is @nowPage
            @addChild(@next_btn)
            @removeChild(@ok_btn)
        @nowPage--
        @text.setText(@txts[@type]['text'][@nowPage])
        page = @setPageText()
        @page_num.setText(page)
        if @nowPage is 0
            @removeChild(@prev_btn)
    setPageText:()->
        page = @nowPage + 1
        all = @txts[@type]['text'].length
        return page + '／' + all + 'ページ'

