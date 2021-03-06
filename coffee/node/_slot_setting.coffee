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
            1:8, 2:10, 3:12, 4:14, 5:20,
            11:20, 12:20, 13:20, 14:20, 15:20, 16:20, 17:20, 18:20, 19:20
        }
        @allRoles = {
            11:[11],12:[12],13:[13],14:[14],15:[15],16:[16],17:[17],18:[18],19:[19],
            21:[14,15,16], 22:[11,12,13], 23:[17,18,19], 24:[11,12,16], 25:[13,15,18], 26:[14,17,19], 27:[15,16,17], 28:[13,14,19],
            31:[11,15], 32:[12,16], 33:[17,18], 34:[12,13], 35:[14,15], 36:[18,19], 37:[14,17], 38:[13,19],
        }
        @allRolesKey = [21,22,23,24,25,26,27,28,31,32,33,34,35,36,37,38,11,12,13,14,15,16,17,18,19]
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
                    {'name':'11_1', 'width':730, 'height':662, 'direction':'left'},
                    {'name':'11_2', 'width':563, 'height':570, 'direction':'left'}
                ],
                'cut_in2':[
                    {'name':'11_0', 'width':258, 'height':344, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'yumenaki', 'time':47, 'title':'夢なき夢は夢じゃない', 'unit':'高坂穂乃果', 'image':'bgm_11'}
                ],
                'voice':['11_0', '11_1', '11_2']
            },
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':510, 'height':728, 'direction':'left'},
                    {'name':'12_1', 'width':640, 'height':648, 'direction':'right'},
                    {'name':'12_2', 'width':388, 'height':570, 'direction':'right'}
                ],
                'cut_in2':[
                    {'name':'12_0', 'width':244, 'height':325, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'blueberry', 'time':40, 'title':'ぶる～べりぃとれいん', 'unit':'南ことり', 'image':'bgm_12'}
                ],
                'voice':['12_0', '12_1', '12_2']
            },
            13:{
                'cut_in':[
                    {'name':'13_0', 'width':570, 'height':634, 'direction':'left'},
                    {'name':'13_1', 'width':408, 'height':570, 'direction':'left'},
                    {'name':'13_2', 'width':412, 'height':570, 'direction':'right'}
                ],
                'cut_in2':[
                    {'name':'13_0', 'width':239, 'height':346, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'reason', 'time':41, 'title':'勇気のReason', 'unit':'園田海未', 'image':'bgm_13'}
                ],
                'voice':['13_0', '13_1', '13_2']
            },
            14:{
                'cut_in':[
                    {'name':'14_0', 'width':476, 'height':648, 'direction':'left'},
                    {'name':'14_1', 'width':650, 'height':570, 'direction':'right'},
                    {'name':'14_2', 'width':750, 'height':660, 'direction':'left'}
                ],
                'cut_in2':[
                    {'name':'14_0', 'width':183, 'height':309, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'daring', 'time':35, 'title':'Darling！！', 'unit':'西木野真姫', 'image':'bgm_14'}
                ],
                'voice':['14_0', '14_1', '14_2']
            },
            15:{
                'cut_in':[
                    {'name':'15_0', 'width':502, 'height':570, 'direction':'right'},
                    {'name':'15_1', 'width':601, 'height':638, 'direction':'left'},
                    {'name':'15_2', 'width':563, 'height':570, 'direction':'right'}
                ],
                'cut_in2':[
                    {'name':'15_0', 'width':191, 'height':314, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'rinrinrin', 'time':53, 'title':'恋のシグナルRin rin rin！', 'unit':'星空凛', 'image':'bgm_15'}
                ],
                'voice':['15_0', '15_1', '15_2']
            },
            16:{
                'cut_in':[
                    {'name':'16_0', 'width':438, 'height':570, 'direction':'right'},
                    {'name':'16_1', 'width':580, 'height':644, 'direction':'left'},
                    {'name':'16_2', 'width':450, 'height':570, 'direction':'left'}
                ],
                'cut_in2':[
                    {'name':'16_0', 'width':209, 'height':329, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'nawatobi', 'time':56, 'title':'なわとび', 'unit':'小泉花陽', 'image':'bgm_16'}
                ],
                'voice':['16_0', '16_1', '16_2']
            },
            17:{
                'cut_in':[
                    {'name':'17_0', 'width':465, 'height':705, 'direction':'left'},
                    {'name':'17_1', 'width':361, 'height':570, 'direction':'left'},
                    {'name':'17_2', 'width':378, 'height':570, 'direction':'left'}
                ],
                'cut_in2':[
                    {'name':'17_0', 'width':268, 'height':314, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'mahoutukai', 'time':47, 'title':'まほうつかいはじめました', 'unit':'矢澤にこ', 'image':'bgm_17'}
                ],
                'voice':['17_0', '17_1', '17_2']
            },
            18:{
                'cut_in':[
                    {'name':'18_0', 'width':599, 'height':606, 'direction':'right'},
                    {'name':'18_1', 'width':380, 'height':675, 'direction':'left'},
                    {'name':'18_2', 'width':433, 'height':602, 'direction':'right'}
                ],
                'cut_in2':[
                    {'name':'18_0', 'width':275, 'height':327, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'junai', 'time':55, 'title':'純愛レンズ', 'unit':'東條希', 'image':'bgm_18'}
                ],
                'voice':['18_0', '18_1', '18_2']
            },
            19:{
                'cut_in':[
                    {'name':'19_0', 'width':460, 'height':570, 'direction':'left'},
                    {'name':'19_1', 'width':670, 'height':650, 'direction':'right'},
                    {'name':'19_2', 'width':797, 'height':595, 'direction':'left'}
                ],
                'cut_in2':[
                    {'name':'19_0', 'width':246, 'height':353, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'arihureta', 'time':44, 'title':'ありふれた悲しみの果て', 'unit':'絢瀬絵里', 'image':'bgm_19'}
                ],
                'voice':['19_0', '19_1', '19_2']
            },
            20:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30, 'title':'タイトル', 'unit':'ユニット', 'image':'test_image2'}
                ]
            },
            21:{
                'bgm':[
                    {'name':'hello_hoshi', 'time':42, 'title':'Hello，星を数えて ', 'unit':'1年生<br>（星空凛、西木野真姫、小泉花陽）', 'image':'bgm_21'}
                ]
            },
            22:{
                'bgm':[
                    {'name':'future_style', 'time':50, 'title':'Future style', 'unit':'2年生<br>（高坂穂乃果、南ことり、園田海未）', 'image':'bgm_22'}
                ]
            },
            23:{
                'bgm':[
                    {'name':'hatena_heart', 'time':44, 'title':'？←HEARTBEAT', 'unit':'3年生<br>（絢瀬絵里、東條希、矢澤にこ）', 'image':'bgm_23'}
                ]
            },
            24:{
                'bgm':[
                    {'name':'sweet_holiday', 'time':49, 'title':'sweet＆sweet holiday', 'unit':'Printemps<br>(高坂穂乃果、南ことり、小泉花陽)', 'image':'bgm_24'}
                ]
            },
            25:{
                'bgm':[
                    {'name':'hutari_hapinesu', 'time':72, 'title':'ふたりハピネス', 'unit':'lily white<br>(園田海未、星空凛、東條希)', 'image':'bgm_25'}
                ]
            },
            26:{
                'bgm':[
                    {'name':'cutie_panther', 'time':53, 'title':'CutiePanther', 'unit':'BiBi<br>(絢瀬絵里、西木野真姫、矢澤にこ)', 'image':'bgm_26'}
                ]
            },
            27:{
                'bgm':[
                    {'name':'listen_to_my_heart', 'time':46, 'title':'Listen to my heart！！', 'unit':'にこりんぱな<br>(矢澤にこ、星空凛、小泉花陽)', 'image':'bgm_27'}
                ]
            },
            28:{
                'bgm':[
                    {'name':'soldier_game', 'time':38, 'title':'soldier game', 'unit':'<br>園田海未、西木野真姫、絢瀬絵里', 'image':'bgm_28'}
                ]
            },
            31:{
                'bgm':[
                    {'name':'mermaid2', 'time':64, 'title':'Mermaid festa vol．2', 'unit':'高坂穂乃果、星空凛', 'image':'bgm_31'}
                ]
            },
            32:{
                'bgm':[
                    {'name':'kokuhaku', 'time':52, 'title':'告白日和、です！', 'unit':'南ことり、小泉花陽', 'image':'bgm_32'}
                ]
            },
            33:{
                'bgm':[
                    {'name':'otomesiki', 'time':38, 'title':'乙女式れんあい塾', 'unit':'矢澤にこ、東條希', 'image':'bgm_33'}
                ]
            },
            34:{
                'bgm':[
                    {'name':'anemone_heart', 'time':45, 'title':'Anemone heart', 'unit':'南ことり、園田海未', 'image':'bgm_34'}
                ]
            },
            35:{
                'bgm':[
                    {'name':'beat_in_angel', 'time':47, 'title':'Beat in Angel', 'unit':'西木野真姫、星空凛', 'image':'bgm_35'}
                ]
            },
            36:{
                'bgm':[
                    {'name':'garasu', 'time':41, 'title':'硝子の花園', 'unit':'東條希、絢瀬絵里', 'image':'bgm_36'}
                ]
            },
            37:{
                'bgm':[
                    {'name':'magnetic', 'time':41, 'title':'ずるいよMagnetic today', 'unit':'矢澤にこ、西木野真姫', 'image':'bgm_37'}
                ]
            },
            38:{
                'bgm':[
                    {'name':'storm', 'time':44, 'title':'Storm in Lover', 'unit':'園田海未、絢瀬絵里', 'image':'bgm_38'}
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
                'price':100
            },
            1:{
                'name':'まきちゃんかわいい',
                'image':'item_1',
                'discription':'スロットが揃った時以外の<br>コインがたくさん降ってくるようになる',
                'price':1000
            },
            2:{
                'name':'チーズケーキ鍋',
                'image':'item_2',
                'discription':'チーズケーキしか降ってこなくなる<br>爆弾は降ってこなくなる<br>(掛け金が1京円を超えると効果が無くなる)',
                'price':7000
            },
            3:{
                'name':'テンション上がるにゃー！',
                'image':'item_3',
                'discription':'移動速度とジャンプ力が上がる<br>テンションの上がり幅が1.3倍になる',
                'price':60000
            },
            4:{
                'name':'チョットマッテテー',
                'image':'item_4',
                'discription':'おやつが降ってくる速度が<br>ちょっとだけ遅くなる',
                'price':400000
            },
            5:{
                'name':'認められないわぁ',
                'image':'item_5',
                'discription':'アイテムを落としてもコンボが減らず<br>テンションも下がらないようになる',
                'price':3000000
            },
            6:{
                'name':'完っ全にフルハウスね',
                'image':'item_6',
                'discription':'CHANCE!!が出やすくなる',
                'price':20000000
            },
            7:{
                'name':'ラブアローシュート',
                'image':'item_7',
                'discription':'おやつが近くに落ちてくる',
                'price':200000000
            },
            8:{
                'name':'鈍いのですね',
                'image':'item_8',
                'discription':'おやつが降ってくる速度が<br>だいぶ遅くなる<br>チョットマッテテー（遅）と組み合わせると<br>更に遅くなる',
                'price':1000000000
            },
            9:{
                'name':'ファイトだよっ',
                'image':'item_9',
                'discription':'FEVER!!が出やすくなる',
                'price':10000000000
            },

            11:{
                'name':'高坂穂乃果',
                'image':'item_11',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>穂乃果と入れ替わる。',
                'price':0
            },
            12:{
                'name':'南ことり',
                'image':'item_12',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>ことりと入れ替わる。',
                'price':0
            },
            13:{
                'name':'園田海未',
                'image':'item_13',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>海未と入れ替わる。',
                'price':0
            },
            14:{
                'name':'西木野真姫',
                'image':'item_14',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>真姫と入れ替わる。',
                'price':0
            },
            15:{
                'name':'星空凛',
                'image':'item_15',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>凛と入れ替わる。',
                'price':0
            },
            16:{
                'name':'小泉花陽',
                'image':'item_16',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>花陽と入れ替わる。',
                'price':0
            },
            17:{
                'name':'矢澤にこ',
                'image':'item_17',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>にこと入れ替わる。',
                'price':0
            },
            18:{
                'name':'東條希',
                'image':'item_18',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>希と入れ替わる。',
                'price':0
            },
            19:{
                'name':'絢瀬絵里',
                'image':'item_19',
                'discription':'スロットが揃ったときに<br>一定確率でスロット内のリトライが<br>絵里と入れ替わる。',
                'price':0
            },
            21:{
                'name':'ブロンズことり',
                'image':'item_21',
                'discription':'第２話が見れる<br>移動速度とジャンプ力がアップする',
                'price':1000000
            },
            22:{
                'name':'シルバーことり',
                'image':'item_22',
                'discription':'第３話が見れる<br>スキルのスロットが1つ増える',
                'price':100000000
            },
            23:{
                'name':'ゴールドことり',
                'image':'item_23',
                'discription':'第４話が見れる<br>移動速度とジャンプ力がアップする<br>スキルのスロットが1つ増える',
                'price':10000000000
            },
            24:{
                'name':'プラチナことり',
                'image':'item_24',
                'discription':'最終話が見れる',
                'price':100000000000000
            }
        }

        #アイテムの並び順
        #@item_sort_list = [2->1, 1->2, 4->3, 5->4, 6->5, 7->6, 9->7, 3->8, 8->9]

        #μ’ｓメンバーアイテムの値段、フィーバーになった順に
        #TODO タイトルに戻って最初からやりなおすと前回プレイ時の値段が残っている？
        @member_item_price = [1000, 5000, 30000, 100000, 1000000, 5000000, 30000000, 200000000, 1000000000]

        #テンションの最大値
        @tension_max = 500
        #trueならスロットが強制で当たる
        @isForceSlotHit = false
        #スロットが強制で当たる確率
        @slotHitRate = 0
        #アイテムポイントの最大値
        @item_point_max_init = 500
        @item_point_max = 500
        #アイテムポイントが全回復するまでの秒数
        @item_point_recovery_sec = 60
        #アイテムポイントが増える／減るのにかかる値(ポイント／フレーム)
        #0はアイテムがセットされていない時に増える値、１～は各アイテムをセットしている時に減る値
        @item_point_value = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0]
        #単位時間で減少するアイテムポイント
        @item_decrease_point = 0
        #掛け金が増えると当選金額の割合が減る補正
        @prize_div = 1
        @item_gravity = 0
        #ランダムでの結果と部員の編成を加味した最終的な挿入するμ’ｓメンバーの数値
        @add_muse_num = 0
        #おすすめで前回編成した部員のキー
        @prev_osusume_role = 0

        #セーブする変数
        #@prev_muse = [] #過去にスロットに入ったμ’ｓ番号(TODO 使ってない？不要か検証してから消す)
        @now_muse_num = 0 #現在ランダムに選択されてスロットに入るμ’ｓ番号

    setItemPointValue:()->
        @item_point_value[0] = Math.floor(@item_point_max * 1000 / (@item_point_recovery_sec * game.fps)) / 1000
        for i in [1..9]
            @item_point_value[i] = Math.floor(@item_point_max_init * 1000 / (90 * game.fps)) / 1000

    ###
    単位時間で減少するアイテムポイントの値を決定する
    ###
    setItemDecreasePoint:()->
        point = 0
        for key, val of game.item_set_now
            if val != undefined
                point += @item_point_value[val]
        @item_decrease_point = point

    ###
    アイテムポイントの最大値を決定する
    ###
    setItemPointMax:()->
        @item_point_max = @item_point_max_init * game.max_set_item_num
        @setItemPointValue()
        sys = game.main_scene.gp_system
        sys.item_gauge_back.setWidth()
        sys.item_gauge.setWidth()

    ###
    落下アイテムの加速度
    掛け金が多いほど速くする
    ###
    setGravity:()->
        missSycle = 0
        if game.bet < 1 * Math.pow(10, 1)
            val = 0.32
            @prize_div = 2
            missSycle = 0
        else if game.bet < 5 * Math.pow(10, 1)
            val = 0.36
            @prize_div = 1.9
            missSycle = 8
        else if game.bet < 1 * Math.pow(10, 2)
            val = 0.4
            @prize_div = 1.8
            missSycle = 7
        else if game.bet < 5 * Math.pow(10, 2)
            val = 0.43
            @prize_div = 1.6
            missSycle = 6
        else if game.bet < 1 * Math.pow(10, 3)
            val = 0.45
            @prize_div = 1.4
            missSycle = 5
        else if game.bet < 5 * Math.pow(10, 3)
            val = 0.48
            @prize_div = 1.2
            missSycle = 4
        else if game.bet < 1 * Math.pow(10, 4) #1万
            val = 0.5
            @prize_div = 1
            missSycle = 4
        else if game.bet < 5 * Math.pow(10, 4)
            val = 0.52
            @prize_div = 1
            missSycle = 3
        else if game.bet < 1 * Math.pow(10, 5)
            val = 0.54
            @prize_div = 1
            missSycle = 3
        else if game.bet < 5 * Math.pow(10, 5)
            val = 0.57
            @prize_div = 1
            missSycle = 2
        else if game.bet < 1 * Math.pow(10, 6) #100万
            val = 0.59
            @prize_div = 1
            missSycle = 2
        else if game.bet < 5 * Math.pow(10, 6)
            val = 0.61
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 7)
            val = 0.63
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 7)
            val = 0.65
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 8) #１億
            val = 0.68
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 8)
            val = 0.74
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 9)
            val = 0.8
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 9)
            val = 0.9
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 10) #100億
            val = 1
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 10)
            val = 1.1
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 11)
            val = 1.2
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 11)
            val = 1.4
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 12) #1兆
            val = 1.6
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 12)
            val = 1.8
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 13)
            val = 2
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 13)
            val = 2.2
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 14) #100兆
            val = 2.4
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 14)
            val = 2.6
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 15)
            val = 2.8
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 15)
            val = 3
            @prize_div = 1
            missSycle = 1
        else if game.bet < 1 * Math.pow(10, 16) #1京
            val = 3.4
            @prize_div = 1
            missSycle = 1
        else if game.bet < 5 * Math.pow(10, 16)
            val = 3.8
            @prize_div = 1
            missSycle = 0.5
        else if game.bet < 1 * Math.pow(10, 17)
            val = 4.2
            @prize_div = 1
            missSycle = 0.5
        else if game.bet < 5 * Math.pow(10, 17)
            val = 4.4
            @prize_div = 1
            missSycle = 0.5
        else if game.bet < 1 * Math.pow(10, 18) #100京
            val = 4.6
            @prize_div = 1
            missSycle = 0.5
        else if game.bet < 5 * Math.pow(10, 18)
            val = 4.8
            @prize_div = 1
            missSycle = 0.5
        else if game.bet < 1 * Math.pow(10, 19)
            val = 5
            @prize_div = 1
            missSycle = 0.5
        else if game.bet < 1 * Math.pow(10, 20) #1垓
            val = 6
            @prize_div = 1.2
            missSycle = 0.5
        else if game.bet < 1 * Math.pow(10, 24) #1抒
            val = 6
            @prize_div = 1.6
            missSycle = 0.4
        else if game.bet < 1 * Math.pow(10, 32) #1溝
            val = 7
            @prize_div = 2
            missSycle = 0.3
        else if game.bet < 1 * Math.pow(10, 40) #1正
            val = 7
            @prize_div = 3
            missSycle = 0.2
        else if game.bet < 1 * Math.pow(10, 48) #1極
            val = 7
            @prize_div = 3.5
            missSycle = 0.2
        else if game.bet < 1 * Math.pow(10, 56) #1阿僧祇
            val = 7
            @prize_div = 4
            missSycle = 0.1
        else
            val = 8
            @prize_div = 5
            missSycle = 0.1
        game.main_scene.gp_stage_front.missItemFallSycle = missSycle
        div = 1
        val = Math.floor(val * div * 100) / 100
        if 100 < game.combo
            div = Math.floor((game.combo - 100) / 50) / 10
            if div < 0
                div = 0
            if 2 < div
                div = 2
            val += div
        if game.isItemSet(4)
            val = Math.floor(val * 0.7 * 100) / 100
        else if game.isItemSet(8)
            val = Math.floor(val * 0.5 * 100) / 100
        if game.isItemSet(4) && game.isItemSet(8)
            val = Math.floor(val * 0.3 * 100) / 100
        @item_gravity = val
        return val

    ###
    スロットにμ’sが入るかどうかを返す
    カットインはリトライ以外が当たった時、確率で起こる
    部員0-1人セットで60%、2人セットで80%、3人セットで100%
    @return boolean
    ###
    isAddMuse:()->
        result = false
        length = game.member_set_now.length
        rate = 60
        if length is 2 || game.past_fever_num is 1
            rate = 80
        if 3 <= length || game.past_fever_num is 0
            rate = 100
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
        member = 0
        if game.arrIndexOf(game.prev_fever_muse, full)
            @now_muse_num = 0
        else
            for key, val of full
                if game.prev_fever_muse.indexOf(val) is -1
                    remain.push(full[key])
            random = Math.floor(Math.random() * remain.length)
            member = remain[random]
            @now_muse_num = member


    ###
    挿入するμ’sメンバーの人数を決める
    ###
    setMuseNum:()->
        num = Math.floor(game.combo / 100) + 1
        return num

    ###
    スロットを強制的に当たりにするかどうかを決める
    コンボ数 * 0.1 ％
    テンションMAXで+20補正
    過去のフィーバー回数が少ないほど上方補正かける 0回:+24,1回:+16,2回:+8
    最大値は30％
    フィーバー中は強制的に当たり
    @return boolean true:当たり
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor((game.combo * 0.1) + ((game.tension / @tension_max) * 20))
        if game.past_fever_num <= 2
            rate += ((3 - game.past_fever_num)) * 8
        if rate > 30 || game.main_scene.gp_back_panorama.now_back_effect_flg is true || game.isItemSet(6)
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
        if game.isItemSet(1) && game.combo < 200
            up = 200
        div = 1
        if Math.pow(10, 9) < game.bet then div = 0.8
        if Math.pow(10, 13) < game.bet then div = 0.7
        return Math.floor(game.bet * up * 0.02 * div)

    ###
    スロットの当選金額を計算
    @param eye 当たったスロットの目
    ###
    calcPrizeMoney: (eye) ->
        ret_money = Math.floor(game.bet * @bairitu[eye] * @prize_div)
        ###
        if game.fever is true
            time = @muse_material_list[game.fever_hit_eye]['bgm'][0]['time']
            div = Math.floor(time * 10 / 90) / 10
            if div < 1
                div = 1
            ret_money = Math.floor(ret_money / div)
        ###
        if game.main_scene.gp_back_panorama.now_back_effect_flg is true
            ret_money *= 2
        return ret_money

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (game.item_kind + 2) * @_getTensionCorrect() * 1.5
        if game.main_scene.gp_stage_front.player.isAir is true
            @_upItemPointIfPlayerIsAir()
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
    空中でアイテムを取った時にアイテムポイントを回復する
    高い位置で取った時ほど大幅に回復させる
    ###
    _upItemPointIfPlayerIsAir:()->
        playerY = game.main_scene.gp_stage_front.player.y
        if playerY < game.height * 0.4
            val = 100
        else if playerY < game.height * 0.5
            val = 80
        else if playerY < game.height * 0.6
            val = 60
        else
            val = 40
        val *= game.max_set_item_num
        game.main_scene.gp_system.upItemPoint(val)
        game.main_scene.gp_system.shineItemPoint()

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
            val = 0.3
        return  val

    ###
    アイテムを落とした時のテンションゲージの増減値を決める
    ###
    setTensionItemFall:()->
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        else
            if game.isItemSet(5) || game.fever is true
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
            else if before < tension_66 && after > tension_66
                slot.slotLilleChange(@lille_array_2, false)
            else if (before < tension_33 || before > tension_66) && (after > tension_33 && after < tension_66)
                slot.slotLilleChange(@lille_array_1, false)

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
        if game.isItemSet(2)
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
        if @item_gravity < 1
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
            when '13,19'    then role = 38
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
            rslt = true
        else if num is 21
            if 50 <= game.max_combo
                rslt = true
        else if num is 22
            if 9 <= game.countFullMusic() || 100 <= game.max_combo
                rslt = true
        else if num is 23
            if 9 <= game.countFullMusic() && 100 <= game.max_combo
                rslt = true
        else if num is 24
            if 15 <= game.countFullMusic()
                rslt = true
        return rslt

    ###
    μ’ｓメンバーの値段を決める
    ###
    setMemberItemPrice:()->
        cnt = 0
        if 0 < game.item_have_now.length
            have_muse = []
            for key, val of game.item_have_now
                if 11 <= val && val <= 19
                    have_muse.push(val)
            cnt = have_muse.length
        for val in [11..19]
            @item_list[val].price = @member_item_price[cnt]

    ###
    現在セットされているメンバーから次にスロットに挿入するμ’ｓメンバーを決めて返します
    ###
    getAddMuseNum:()->
        member = game.member_set_now
        max = game.max_set_member_num
        if member.length is 0
            ret = @now_muse_num
        else
            if game.next_add_member_key is member.length && game.next_add_member_key != max && @now_muse_num != 0
                ret = @now_muse_num
            else
                if @now_muse_num is 0
                    if game.next_add_member_key is member.length
                        game.next_add_member_key = 0
                else
                    if game.next_add_member_key is member.length + 1 || game.next_add_member_key is max
                        game.next_add_member_key = 0
                if member[game.next_add_member_key] is undefined
                    game.next_add_member_key = 0
                ret = member[game.next_add_member_key]
            game.next_add_member_key += 1
        @add_muse_num = ret
        return ret

    ###
    チャンスの時に強制的にフィーバーにする
    ###
    isForceFever:()->
        tension_rate = Math.floor((game.tension * 100)/ @tension_max)
        if tension_rate is 100
            rate = 80
        else if 85 <= tension_rate
            if game.past_fever_num <= 3
                rate = 16
            else if game.past_fever_num <= 6
                rate = 14
            else if game.past_fever_num <= 9
                rate = 12
            else
                rate = 10
        else if 70 <= tension_rate
            if game.past_fever_num <= 3
                rate = 8
            else if game.past_fever_num <= 6
                rate = 7
            else if game.past_fever_num <= 9
                rate = 6
            else
                rate = 5
        else
            rate = 2
        if tension_rate != 100 && game.isItemSet(9)
            rate = 30
        if 100 < rate
            rate = 100
        result = false
        random = Math.floor(Math.random() * 100)
        if game.debug.force_fever is true || random <= rate
            result = true
        return result

    ###
    現在所持している部員から作成可能な役を作って返します
    過去にフィーバーになった役は除外します
    @return array role
    メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    ユニット(役):21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:ほのりん、32:ことぱな、33:にこのぞ、34:ことうみ、35:まきりん、36:のぞえり、37:にこまき、38:うみえり
    ###
    getRoleAbleMemberList:()->
        role = []
        allRoles = []
        roleCnt = 0
        returnRoles = @allRoles
        for roleNum, member of returnRoles
            if game.arrIndexOf(game.item_have_now, member)
                if game.prev_fever_muse.indexOf(parseInt(roleNum)) is -1 || 25 <= game.past_fever_num
                    roleCnt++
                    if @prev_osusume_role is 0 || @prev_osusume_role.indexOf(parseInt(roleNum)) is -1
                        allRoles.push(roleNum)
        if 0 < allRoles.length
            random = Math.floor(Math.random() * allRoles.length)
            role = returnRoles[allRoles[random]]
        if 1 < roleCnt
            @prev_osusume_role = allRoles[random]
        else
            @prev_osusume_role = 0
        return role

    ###
    強制的にフィーバーになるときに左のスロットから役が作成可能かを判定して、作成可能ならその役を返す
    過去にフィーバーになった役は除外
    該当する役が無かった時、校章があれば校章を返すようにする
    ###
    setForceFeverRole:(left_lille)->
        role = []
        roles = []
        for i, roleNum of @allRolesKey
            member = @allRoles[roleNum]
            if game.arrIndexOf(left_lille, member) && (game.prev_fever_muse.indexOf(parseInt(roleNum)) is -1 || 25 <= game.past_fever_num)
                roles.push(member)
        if roles[0] != undefined
            role = roles[0]
            if role.length is 1
                role[1] = role[0]
                role[2] = role[0]
            else if role.length is 2
                role[3] = role[0]
            role.sort(
                ()->
                    Math.random() - 0.5
            )
        else
            if left_lille.indexOf(1) != -1
                role = [1,1,1]
        return role

    betChange:(up)->
        val = 1
        bet = game.bet
        betStr = bet + ''
        betLng = game.numDigit(bet)
        betHead = betStr.slice(0, 1)
        if up is true
            val = Math.pow(10, betLng - 1)
        else
            if betHead is '1'
                val = Math.pow(10, betLng - 2)
            else
                val = Math.pow(10, betLng - 1)
            val *= -1
        game.bet += val
        if game.bet < 1
            game.bet = 1
        else if game.bet > game.money
            game.bet -= val
        if up is false and game.auto_bet is 1 and game.bet < Math.floor(game.money / 100)
            game.auto_bet = 0

    ###
    掛け金が所持金を上回った時に掛け金を減らす
    ###
    betDown:()->
        digit = Math.pow(10, (game.numDigit(game.money) - 1))
        val = Math.floor(game.money / digit) * digit / 100
        if val < 1
            val = 1
        return val

    betUp:()->
        if game.fever is false and @isForceSlotHit is false
            @betUpExe()

    betUpExe:()->
        if game.auto_bet is 1
            tmp_bet = Math.floor(game.money / 50)
            if game.bet < tmp_bet
                digit = Math.pow(10, (game.numDigit(tmp_bet) - 1))
                game.bet = Math.floor(tmp_bet / digit) * digit
                game.main_scene.gp_system.bet_text.setValue()