###
スロットのリールの並びや掛け金に対する当選額
テンションによるリールの変化確率など
ゲームバランスに作用する固定値の設定
###
class slotSetting extends appNode
    constructor: () ->
        super
        #リールの並び
        @lille_array_0 = [
            [1,2,1,2,1,3,5,1,2,3,5,1,2,1,3,4,1,2,1,4],
            [2,4,1,1,3,2,4,1,3,2,5,1,3,2,4,1,3,1,5,1],
            [1,5,2,3,1,4,1,3,1,4,5,2,3,1,4,2,3,1,2,1]
        ]
        @lille_array_1 = [
            [1,3,1,3,1,2,5,1,3,2,5,1,3,1,2,4,1,3,1,4],
            [3,4,1,1,2,3,4,1,2,3,5,1,2,3,4,1,2,1,5,1],
            [1,5,3,2,1,4,1,2,1,4,5,3,2,1,4,3,2,1,3,1]
        ]
        @lille_array_2 = [
            [1,4,1,4,1,2,5,1,4,2,5,1,4,1,2,3,1,4,1,3],
            [4,3,1,1,2,4,3,1,2,4,5,1,2,4,3,1,2,1,5,1],
            [1,5,4,2,1,3,1,2,1,3,5,4,2,1,3,4,2,1,4,1]
        ]
        #リールの目に対する当選額の倍率
        @bairitu = {
            1:10, 2:20, 3:30, 4:40, 5:50,
            11:50, 12:50, 13:50, 14:50, 15:50, 16:50, 17:50, 18:50, 19:50
        }
        ###
        カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
        11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
        ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
        31:ほのりん、32:ことぱな、33:にこのぞ、34:ことうみ、35:まきりん、36:のぞえり、37:にこまき、38:うみえり
        direction:キャラクターの向き、left or right
        カットインの画像サイズ、頭の位置で570px
        頭の上に余白がある場合の高さ計算式：(570/(元画像高さ-元画像頭のY座標))*元画像高さ
        ###
        @muse_material_list = {
            11:{
                'cut_in':[
                    {'name':'11_0', 'width':360, 'height':570, 'direction':'left'},
                    {'name':'11_1', 'width':730, 'height':662, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'yumenaki', 'time':107, 'title':'夢なき夢は夢じゃない', 'unit':'高坂穂乃果', 'image':'bgm_11'}
                ],
                'voice':['11_0', '11_1']
            },
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':510, 'height':728, 'direction':'left'},
                    {'name':'12_1', 'width':640, 'height':648, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'blueberry', 'time':98, 'title':'ぶる～べりぃとれいん', 'unit':'南ことり', 'image':'bgm_12'}
                ],
                'voice':['12_0', '12_1']
            },
            13:{
                'cut_in':[
                    {'name':'13_0', 'width':570, 'height':634, 'direction':'left'},
                    {'name':'13_1', 'width':408, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'reason', 'time':94, 'title':'勇気のReason', 'unit':'園田海未', 'image':'bgm_13'}
                ],
                'voice':['13_0', '13_1']
            },
            14:{
                'cut_in':[
                    {'name':'14_0', 'width':476, 'height':648, 'direction':'left'},
                    {'name':'14_1', 'width':650, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'daring', 'time':91, 'title':'Darling！！', 'unit':'西木野真姫', 'image':'bgm_14'}
                ],
                'voice':['14_0', '14_1']
            },
            15:{
                'cut_in':[
                    {'name':'15_0', 'width':502, 'height':570, 'direction':'right'},
                    {'name':'15_1', 'width':601, 'height':638, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'rinrinrin', 'time':128, 'title':'恋のシグナルRin rin rin！', 'unit':'星空凛', 'image':'bgm_15'}
                ],
                'voice':['15_0', '15_1']
            },
            16:{
                'cut_in':[
                    {'name':'16_0', 'width':438, 'height':570, 'direction':'right'},
                    {'name':'16_1', 'width':580, 'height':644, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'nawatobi', 'time':164, 'title':'なわとび', 'unit':'小泉花陽', 'image':'bgm_16'}
                ],
                'voice':['16_0', '16_1']
            },
            17:{
                'cut_in':[
                    {'name':'17_0', 'width':465, 'height':705, 'direction':'left'},
                    {'name':'17_1', 'width':361, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'mahoutukai', 'time':105, 'title':'まほうつかいはじめました', 'unit':'矢澤にこ', 'image':'bgm_17'}
                ],
                'voice':['17_0', '17_1']
            },
            18:{
                'cut_in':[
                    {'name':'18_0', 'width':599, 'height':606, 'direction':'right'},
                    {'name':'18_1', 'width':380, 'height':675, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'junai', 'time':127, 'title':'純愛レンズ', 'unit':'東條希', 'image':'bgm_18'}
                ],
                'voice':['18_0', '18_1']
            },
            19:{
                'cut_in':[
                    {'name':'19_0', 'width':460, 'height':570, 'direction':'left'},
                    {'name':'19_1', 'width':670, 'height':650, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'arihureta', 'time':93, 'title':'ありふれた悲しみの果て', 'unit':'絢瀬絵里', 'image':'bgm_19'}
                ],
                'voice':['19_0', '19_1']
            },
            20:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'タイトル', 'unit':'ユニット', 'image':'test_image2'}
                ]
            },
            21:{
                'bgm':[
                    {'name':'hello_hoshi', 'time':93, 'title':'Hello，星を数えて ', 'unit':'1年生<br>（星空凛、西木野真姫、小泉花陽）', 'image':'bgm_21'}
                ]
            },
            22:{
                'bgm':[
                    {'name':'future_style', 'time':94, 'title':'Future style', 'unit':'2年生<br>（高坂穂乃果、南ことり、園田海未）', 'image':'bgm_22'}
                ]
            },
            23:{
                'bgm':[
                    {'name':'hatena_heart', 'time':84, 'title':'？←HEARTBEAT', 'unit':'3年生<br>（絢瀬絵里、東條希、矢澤にこ）', 'image':'bgm_23'}
                ]
            },
            24:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'sweet＆sweet holiday', 'unit':'Printemps<br>(高坂穂乃果、南ことり、小泉花陽)', 'image':'bgm_24'}
                ]
            },
            25:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'あ・の・ね・が・ん・ば・れ', 'unit':'lily white<br>(園田海未、星空凛、東條希)', 'image':'bgm_25'}
                ]
            },
            26:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'ラブノベルス', 'unit':'BiBi<br>(絢瀬絵里、西木野真姫、矢澤にこ)', 'image':'bgm_26'}
                ]
            },
            27:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'Listen to my heart！！', 'unit':'にこりんぱな<br>(矢澤にこ、星空凛、小泉花陽)', 'image':'bgm_27'}
                ]
            },
            28:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'soldier game', 'unit':'<br>園田海未、西木野真姫、絢瀬絵里', 'image':'bgm_28'}
                ]
            },
            31:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'Mermaid festa vol．2', 'unit':'高坂穂乃果、星空凛', 'image':'bgm_31'}
                ]
            },
            32:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'告白日和、です！', 'unit':'南ことり、小泉花陽', 'image':'bgm_32'}
                ]
            },
            33:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'乙女式れんあい塾', 'unit':'矢澤にこ、東條希', 'image':'bgm_33'}
                ]
            },
            34:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'Anemone heart', 'unit':'南ことり、園田海未', 'image':'bgm_34'}
                ]
            },
            35:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'Bea in Angel', 'unit':'西木野真姫、星空凛', 'image':'bgm_35'}
                ]
            },
            36:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'硝子の花園', 'unit':'東條希、絢瀬絵里', 'image':'bgm_36'}
                ]
            },
            37:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'ずるいよMagnetic today', 'unit':'矢澤にこ、西木野真姫', 'image':'bgm_37'}
                ]
            },
            38:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'Storm in Lover', 'unit':'園田海未、絢瀬絵里', 'image':'bgm_38'}
                ]
            }
        }

        @bgm_list = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 36, 37, 38]

        ###
        アイテムのリスト
        ###
        @item_list = {
            0:{
                'name':'アイテム',
                'image':'test_image',
                'discription':'アイテムの説明',
                'price':100, #値段
                'durationSec':30, #持続時間(秒)
                'conditoin':'出現条件',
                'condFunc':()-> #出現条件の関数 true:出す、false:隠す
                    return true
            },
            1:{
                'name':'チーズケーキ鍋',
                'image':'item_1',
                'discription':'チーズケーキしか降ってこなくなる<br>ニンニクは降ってこなくなる',
                'price':1000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(2)
            },
            2:{
                'name':'くすくす大明神',
                'image':'item_2',
                'discription':'コンボ数に関わらず<br>たくさんのコインが降ってくるようになる',
                'price':10000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(4)
            },
            3:{
                'name':'ぴょんぴょこぴょんぴょん',
                'image':'item_3',
                'discription':'ジャンプ力が上がる',
                'price':50000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(3)
            },
            4:{
                'name':'テンション上がるにゃー！',
                'image':'item_4',
                'discription':'移動速度が上がる',
                'price':100000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(1)
            },
            5:{
                'name':'ファイトだよっ',
                'image':'item_5',
                'discription':'CHANCE!!でスロットが揃う時に<br>FEVER!!が出やすくなる',
                'price':100000000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(7)
            },
            6:{
                'name':'チョットマッテテー',
                'image':'item_6',
                'discription':'おやつが降ってくる速度が<br>ちょっとだけ遅くなる',
                'price':1000000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(6)
            },
            7:{
                'name':'完っ全にフルハウスね',
                'image':'item_7',
                'discription':'3回に1回の確率で<br>CHANCE!!状態になる',
                'price':10000000,
                'durationSec':120,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(5)
            },
            8:{
                'name':'認められないわぁ',
                'image':'item_8',
                'discription':'アイテムを落としてもコンボが減らず<br>テンションも下がらないようになる',
                'price':5000000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(9)
            },
            9:{
                'name':'ラブアローシュート',
                'image':'item_9',
                'discription':'おやつが近くに落ちてくる',
                'price':1000000000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(8)
            },
            11:{
                'name':'高坂穂乃果',
                'image':'item_11',
                'discription':'部員に穂乃果を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'穂乃果でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(11)
            },
            12:{
                'name':'南ことり',
                'image':'item_12',
                'discription':'部員にことりを追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'ことりでスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(12)
            },
            13:{
                'name':'園田海未',
                'image':'item_13',
                'discription':'部員に海未を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'海未でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(13)
            },
            14:{
                'name':'西木野真姫',
                'image':'item_14',
                'discription':'部員に真姫を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'真姫でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(14)
            },
            15:{
                'name':'星空凛',
                'image':'item_15',
                'discription':'部員に凛を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'凛でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(15)
            },
            16:{
                'name':'小泉花陽',
                'image':'item_16',
                'discription':'部員に花陽を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'花陽でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(16)
            },
            17:{
                'name':'矢澤にこ',
                'image':'item_17',
                'discription':'部員ににこを追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'にこでスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(17)
            },
            18:{
                'name':'東條希',
                'image':'item_18',
                'discription':'部員に希を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'希でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(18)
            },
            19:{
                'name':'絢瀬絵里',
                'image':'item_19',
                'discription':'部員に絵里を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
                'price':0,
                'conditoin':'絵里でスロットを3つ揃える',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(19)
            },
            21:{
                'name':'ブロンズことり',
                'image':'item_21',
                'discription':'移動速度とジャンプ力がアップする',
                'price':10000000,
                'conditoin':'100コンボ達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(21)
            },
            22:{
                'name':'シルバーことり',
                'image':'item_22',
                'discription':'魔法のスロットが1つ増える',
                'price':1000000000,
                'conditoin':'ソロ楽曲9曲を全て達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(22)
            },
            23:{
                'name':'ゴールドことり',
                'image':'item_23',
                'discription':'魔法のスロットが1つ増える',
                'price':10000000000,
                'conditoin':'200コンボ達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(23)
            },
            24:{
                'name':'プラチナことり',
                'image':'item_24',
                'discription':'エンディングが見れる',
                'price':1000000000000,
                'conditoin':'全楽曲25曲を全て達成する',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(24)
            }
        }

        #アイテムの並び順
        #@item_sort_list = [2->1, 4->2, 3->3, 1->4, 7->5, 6->6, 5->7, 9->8, 8->9]

        #μ’ｓメンバーアイテムの値段、フィーバーになった順に
        @member_item_price = [1000, 10000, 100000, 500000, 1000000, 5000000, 10000000, 50000000, 100000000]

        #テンションの最大値
        @tension_max = 500
        #trueならスロットが強制で当たる
        @isForceSlotHit = false
        #スロットが強制で当たる確率
        @slotHitRate = 0
        #アイテムポイントの最大値
        @item_point_max = 500
        #アイテムポイントが全回復するまでの秒数
        @item_point_recovery_sec = 60
        #アイテムポイントが増える／減るのにかかる値(ポイント／フレーム)
        #0はアイテムがセットされていない時に増える値、１～は各アイテムをセットしている時に減る値
        @item_point_value = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0]
        #掛け金が増えると当選金額の割合が減る補正
        @prize_div = 1
        @item_gravity = 0
        #ランダムでの結果と部員の編成を加味した最終的な挿入するμ’ｓメンバーの数値
        @add_muse_num = 0

        #セーブする変数
        @prev_muse = [] #過去にスロットに入ったμ’ｓ番号
        @now_muse_num = 0 #現在ランダムに選択されてスロットに入るμ’ｓ番号

    setItemPointValue:()->
        @item_point_value[0] = Math.floor(@item_point_max * 1000 / (@item_point_recovery_sec * game.fps)) / 1000
        for i in [1..9]
            @item_point_value[i] = Math.floor(@item_point_max * 1000 / (@item_list[i].durationSec * game.fps)) / 1000

    ###
    落下アイテムの加速度
    掛け金が多いほど速くする、10000円で速すぎて取れないレベルまで上げる
    ###
    setGravity:()->
        if game.bet < 10
            val = 0.35
            @prize_div = 1
        else if game.bet < 50
            val = 0.40
            @prize_div = 1
        else if game.bet < 100
            val = 0.44
            @prize_div = 1
        else if game.bet < 500
            val = 0.48
            @prize_div = 0.9
        else if game.bet < 1000
            val = 0.5
            @prize_div = 0.9
        else if game.bet < 5000
            val = 0.53
            @prize_div = 0.8
        else if game.bet < 10000
            val = 0.55
            @prize_div = 0.8
        else if game.bet < 100000
            val = 0.55 + Math.floor(game.bet / 10000) / 100
            @prize_div = Math.floor(700 - (game.bet / 500)) / 1000
        else if game.bet < 1000000
            val = 0.65 + Math.floor(game.bet / 10000) / 100
            @prize_div = Math.floor(500 - (game.bet / 5000)) / 1000
        else
            val = 2
            @prize_div = 0.3
        #div = 1 + Math.floor(2 * game.tension / @tension_max) / 10
        div = 1
        val = Math.floor(val * div * 100) / 100
        if 100 < game.combo
            div = Math.floor((game.combo - 100) / 20) / 10
            if 2 < div
                div = 2
            val += div
        if game.isItemSet(6)
            val = Math.floor(val * 0.7 * 100) / 100
        @item_gravity = val
        return val

    ###
    テンションからスロットにμ’sが入るかどうかを返す
    初期値5％、テンションMAXで20％
    過去のフィーバー回数が少ないほど上方補正かける 0回:+12,1回:+8,2回:+4
    @return boolean
    ###
    isAddMuse:()->
        result = false
        rate = Math.floor((game.tension / @tension_max) * 15) + 5
        if game.past_fever_num <= 2
            rate += (3 - game.past_fever_num) * 4
        random = Math.floor(Math.random() * 100)
        if random < rate
            result = true
        if game.debug.force_insert_muse is true
            result = true
        if game.fever is true
            result = false
        return result

    ###
    挿入するμ’sメンバーを決める
    過去に挿入されたメンバーは挿入しない
    ###
    setMuseMember:(force)->
        full = [11,12,13,14,15,16,17,18,19]
        remain = []
        if @prev_muse.length >= 9
            @now_muse_num = 0
        else
            for key, val of full
                if @prev_muse.indexOf(val) is -1
                    remain.push(full[key])
            random = Math.floor(Math.random() * remain.length)
            member = remain[random]
            @now_muse_num = member
            if @prev_muse.indexOf(member) is -1
                @prev_muse.push(member)
        game.pause_scene.pause_member_set_layer.dispSetMemberList()


    ###
    挿入するμ’sメンバーの人数を決める
    ###
    setMuseNum:()->
        num = Math.floor(game.combo / 100) + 1
        return num

    ###
    スロットを強制的に当たりにするかどうかを決める
    コンボ数 * 0.1 ％
    テンションMAXで+15補正
    過去のフィーバー回数が少ないほど上方補正かける 0回:+9,1回:+6,2回:+3
    最大値は30％
    フィーバー中は強制的に当たり
    @return boolean true:当たり
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor((game.combo * 0.1) + ((game.tension / @tension_max) * 15))
        if game.past_fever_num <= 2
            rate += ((3 - game.past_fever_num)) * 3
        if rate > 30 || game.isItemSet(5) || game.main_scene.gp_back_panorama.now_back_effect_flg is true
            rate = 30
        if game.debug.half_slot_hit is true
            rate = 50
        @slotHitRate = rate
        random = Math.floor(Math.random() * 100)
        if random < rate || game.fever is true || game.debug.force_slot_hit is true
            result = true
        @isForceSlotHit = result
        return result

    ###
    スロットが回っている時に降ってくる掛け金の戻り分の額を計算
    ###
    getReturnMoneyFallValue:()->
        up = game.combo
        if game.isItemSet(2) && game.combo < 200
            up = 200
        return Math.floor(game.bet * up * 0.03)

    ###
    スロットの当選金額を計算
    @param eye 当たったスロットの目
    ###
    calcPrizeMoney: (eye) ->
        ret_money = Math.floor(game.bet * @bairitu[eye] * @prize_div)
        if game.fever is true
            time = @muse_material_list[game.fever_hit_eye]['bgm'][0]['time']
            div = Math.floor(time / 90)
            if div < 1
                div = 1
            ret_money = Math.floor(ret_money / div)
        if game.main_scene.gp_back_panorama.now_back_effect_flg is true
            ret_money *= 2
        if ret_money > 10000000000
            ret_money = 10000000000
        return ret_money

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (game.item_kind + 2) * @_getTensionCorrect()
        if game.main_scene.gp_stage_front.player.isAir is true
            val *= 1.5
        if val >= 1
            val = Math.round(val)
        else
            val = 1
        if game.debug.fix_tention_item_catch_flg is true
            val = game.debug.fix_tention_item_catch_val
        if game.fever is true
            val = 0
        return val

    ###
    所持金と掛け金の比でテンションの増値に補正を加える
    ###
    _getTensionCorrect:()->
        quo = Math.round(game.money / game.bet)
        val = 1
        if quo <= 10
            val = 3
        else if quo <= 30
            val = 2
        else if quo <= 60
            val = 1.5
        else if quo <= 200
            val = 1
        else if quo <= 600
            val = 0.75
        else if quo <= 2000
            val = 0.5
        else
            val = 0.25
        return  val

    ###
    アイテムを落とした時のテンションゲージの増減値を決める
    ###
    setTensionItemFall:()->
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        else
            if game.isItemSet(8) || game.fever is true
                val = 0
            else
                val = @tension_max * @_getTensionDownCorrect()
        return val

    setTensionMissItem:()->
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        else
            val = Math.ceil(@tension_max * (@_getTensionDownCorrect() - 0.2))
        return val

    _getTensionDownCorrect:()->
        val = -0.1
        if game.bet < 10000
            val = -0.1
        else if game.bet < 1000000
            val = -0.2
        else
            val = -0.3
        return val

    ###
    スロットが当たったのテンションゲージの増減値を決める
    @param number hit_eye     当たった目の番号
    ###
    setTensionSlotHit:(hit_eye)->
        val = @_getTensionCorrect() * @tension_max * 0.1
        if val > @tension_max * 0.5
            val = @tension_max * 0.5
        else if val < @tension_max * 0.05
            val = @tension_max * 0.05
        val = Math.round(val)
        if game.debug.fix_tention_slot_hit_flg is true
            val = game.debug.fix_tention_slot_hit_flg
        if game.fever is true
            val = 0
        return val

    ###
    テンションの状態でスロットの内容を変更する
    ミスアイテムの頻度を決める
    @param number tension 変化前のテンション
    @param number val     テンションの増減値
    ###
    changeLilleForTension:(tension, val)->
        if game.debug.lille_flg is false
            slot = game.main_scene.gp_slot
            stage = game.main_scene.gp_stage_front
            before = tension
            after = tension + val
            tension_33 = Math.floor(@tension_max * 0.33)
            tension_66 = Math.floor(@tension_max * 0.66)
            if before > 0 && after <= 0
                slot.slotLilleChange(@lille_array_0, true)
            else if before > tension_33 && after < tension_33
                slot.slotLilleChange(@lille_array_0, false)
                stage.missItemFallSycle = 4
                stage.missItemFallSycleNow = 0
            else if before < tension_66 && after > tension_66
                slot.slotLilleChange(@lille_array_2, false)
                stage.missItemFallSycle = 2
                stage.missItemFallSycleNow = 0
            else if (before < tension_33 || before > tension_66) && (after > tension_33 && after < tension_66)
                slot.slotLilleChange(@lille_array_1, false)
                stage.missItemFallSycle = 1
                stage.missItemFallSycleNow = 0

    ###
    落下するアイテムの種類を決める
    @return 0から4のどれか
    ###
    getCatchItemFrame:()->
        val = 0
        rate = Math.round(Math.random() * 100)
        if rate < 20
            val = 0
        else if rate < 40
            val = 1
        else if rate < 60
            val = 2
        else if rate < 80
            val = 3
        else
            val = 4
        if game.isItemSet(1)
            val = 4
        game.item_kind = val
        return val
    ###
    スロットの強制当たりが有効な時間を決める
    エフェクトが画面にイン、アウトする時間が合計0.6秒あるので
    実際はこれの返り値に+0.6追加される
    ###
    setChanceTime:()->
        if @slotHitRate <= 10
            fixTime = 2
            randomTime = 5
        else if @slotHitRate <= 20
            fixTime = 1.5
            randomTime = 10
        else
            fixTime = 1
            randomTime = 15
        fixTime += Math.floor((1 - @item_gravity) * 10) / 10
        ret = fixTime + Math.floor(Math.random() * randomTime) / 10
        return ret
    ###
    スロットの揃った目が全てμ’sなら役を判定して返します
    メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    @return role
    ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:ほのりん、32:ことぱな、33:にこのぞ、34:ことうみ、35:まきりん、36:のぞえり、37:にこまき、38:うみえり
    ###
    getHitRole:(left, middle, right)->
        role = 20
        lille = [left, middle, right]
        items = game.getDeduplicationList(lille)
        items = game.sortAsc(items)
        items = items.join(',')
        switch items #重複除外、昇順、カンマ区切りの文字列になる
            when '14,15,16' then role = 21
            when '11,12,13' then role = 22
            when '17,18,19' then role = 23
            when '11,12,16' then role = 24
            when '13,15,18' then role = 25
            when '14,17,19' then role = 26
            when '15,16,17' then role = 27
            when '13,14,19' then role = 28
            when '11,15'    then role = 31
            when '12,16'    then role = 32
            when '17,18'    then role = 33
            when '12,13'    then role = 34
            when '14,15'    then role = 35
            when '18,19'    then role = 36
            when '14,17'    then role = 37
            when '13,14'    then role = 38
            else role = 20
        return role

    ###
    アイテムの出現条件を返す
    @param num アイテムの番号
    @return boolean
    ###
    itemConditinon:(num)->
        rslt = false
        if num < 10
            rslt = true
        else if num < 20
            if game.prev_fever_muse.indexOf(parseInt(num)) != -1
                rslt = true
        else if num is 21
            if 100 <= game.max_combo
                rslt = true
        else if num is 22
            if 9 <= game.countSoloMusic()
                rslt = true
        else if num is 23
            if 200 <= game.max_combo
                rslt = true
        else if num is 24
            if 25 <= game.countFullMusic()
                rslt = true
        return rslt

    ###
    μ’ｓメンバーの値段を決める
    ###
    setMemberItemPrice:()->
        cnt = 0
        list = game.getDeduplicationList(game.prev_fever_muse)
        for key, val of list
            if 11 <= val && val <= 19
                if 0 == @item_list[val].price
                    @item_list[val].price = @member_item_price[cnt]
                cnt++
    ###
    現在セットされているメンバーから次にスロットに挿入するμ’ｓメンバーを決めて返します
    ###
    getAddMuseNum:()->
        member = game.member_set_now
        if member.length is 0
            ret = @now_muse_num
        else
            ret = member[game.next_add_member_key]
            game.next_add_member_key += 1
            if member[game.next_add_member_key] is undefined
                game.next_add_member_key = 0
        @add_muse_num = ret
        return ret

    ###
    チャンスの時に強制的にフィーバーにする
    ###
    isForceFever:()->
        tension_rate = Math.floor((game.tension * 100)/ @tension_max)
        if game.isItemSet(5)
            rate = 25
        else if tension_rate is 100 || game.past_fever_num is 0
            rate = 20
        else if 80 <= tension_rate || game.past_fever_num is 1
            rate = 15
        else if 60 <= tension_rate || game.past_fever_num is 2
            rate = 10
        else
            rate = 5
        result = false
        random = Math.floor(Math.random() * 100)
        if game.debug.force_fever is true || random <= rate
            result = true
        return result
