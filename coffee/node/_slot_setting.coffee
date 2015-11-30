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
        20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
        31:のぞえり、32:ほのりん、33:ことぱな、34:にこまき
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
                    {'name':'yumenaki', 'time':107}
                ],
                'voice':['11_0', '11_1']
            },
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':510, 'height':728, 'direction':'left'},
                    {'name':'12_1', 'width':640, 'height':648, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'blueberry', 'time':98}
                ],
                'voice':['12_0', '12_1']
            },
            13:{
                'cut_in':[
                    {'name':'13_0', 'width':570, 'height':634, 'direction':'left'},
                    {'name':'13_1', 'width':408, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'reason', 'time':94}
                ],
                'voice':['13_0', '13_1']
            },
            14:{
                'cut_in':[
                    {'name':'14_0', 'width':476, 'height':648, 'direction':'left'},
                    {'name':'14_1', 'width':650, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'daring', 'time':91}
                ],
                'voice':['14_0', '14_1']
            },
            15:{
                'cut_in':[
                    {'name':'15_0', 'width':502, 'height':570, 'direction':'right'},
                    {'name':'15_1', 'width':601, 'height':638, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'rinrinrin', 'time':128}
                ],
                'voice':['15_0', '15_1']
            },
            16:{
                'cut_in':[
                    {'name':'16_0', 'width':438, 'height':570, 'direction':'right'},
                    {'name':'16_1', 'width':580, 'height':644, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'nawatobi', 'time':164}
                ],
                'voice':['16_0', '16_1']
            },
            17:{
                'cut_in':[
                    {'name':'17_0', 'width':465, 'height':705, 'direction':'left'},
                    {'name':'17_1', 'width':361, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'mahoutukai', 'time':105}
                ],
                'voice':['17_0', '17_1']
            },
            18:{
                'cut_in':[
                    {'name':'18_0', 'width':599, 'height':606, 'direction':'right'},
                    {'name':'18_1', 'width':380, 'height':675, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'junai', 'time':127}
                ],
                'voice':['18_0', '18_1']
            },
            19:{
                'cut_in':[
                    {'name':'19_0', 'width':460, 'height':570, 'direction':'left'},
                    {'name':'19_1', 'width':670, 'height':650, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'arihureta', 'time':93}
                ],
                'voice':['19_0', '19_1']
            },
            20:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            21:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            22:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            23:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            24:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            25:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            26:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            27:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            28:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            29:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            30:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            },
            31:{
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ]
            }
        }

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
                'name':'テンション上がるにゃー！',
                'image':'item_1',
                'discription':'移動速度が上がる',
                'price':10000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(1)
            },
            2:{
                'name':'チーズケーキ鍋',
                'image':'item_2',
                'discription':'チーズケーキしか降ってこなくなる<br>ニンニクは降ってこなくなる',
                'price':50000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(2)
            },
            3:{
                'name':'ぴょんぴょこぴょんぴょん',
                'image':'item_3',
                'discription':'ジャンプ力が上がる',
                'price':100000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(3)
            },
            4:{
                'name':'くすくす大明神',
                'image':'item_4',
                'discription':'コンボ数に関わらず<br>たくさんのコインが降ってくるようになる',
                'price':500000,
                'durationSec':60,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(4)
            },
            5:{
                'name':'完っ全にフルハウスね',
                'image':'item_5',
                'discription':'CHANCE!!状態になる確率が<br>大幅に上がる',
                'price':1000000,
                'durationSec':30,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(5)
            },
            6:{
                'name':'チョットマッテテー',
                'image':'item_6',
                'discription':'おやつが降ってくる速度が<br>ちょっとだけ遅くなる',
                'price':5000000,
                'durationSec':30,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(6)
            },
            7:{
                'name':'ファイトだよっ',
                'image':'item_7',
                'discription':'スロットに当たった時に<br>得られる金額が2倍になる',
                'price':10000000,
                'durationSec':30,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(7)
            },
            8:{
                'name':'ラブアローシュート',
                'image':'item_8',
                'discription':'おやつが頭上に落ちてくる',
                'price':100000000,
                'durationSec':30,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(8)
            },
            9:{
                'name':'エリチカおうちに帰る！',
                'image':'item_9',
                'discription':'掛け金をいくら上げても<br>おやつの落下速度が上がらなくなる',
                'price':1000000000,
                'durationSec':30,
                'conditoin':'',
                'condFunc':()->
                    return game.slot_setting.itemConditinon(9)
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
            }
        }

        #μ’ｓメンバーアイテムの値段、フィーバーになった順に
        @member_item_price = [1000, 10000, 100000, 500000, 1000000, 5000000, 10000000, 50000000, 100000000]

        #テンションの最大値
        @tension_max = 500
        #現在スロットに入るμ’ｓ番号
        @now_muse_num = 0
        #trueならスロットが強制で当たる
        @isForceSlotHit = false
        #スロットが強制で当たる確率
        @slotHitRate = 0
        #アイテムポイントの最大値
        @item_point_max = 500
        #アイテムポイントが全回復するまでの秒数
        @item_point_recovery_sec = 120
        #アイテムポイントが増える／減るのにかかる値(ポイント／フレーム)
        #0はアイテムがセットされていない時に増える値、１～は各アイテムをセットしている時に減る値
        @item_point_value = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0]
        #掛け金が増えると当選金額の割合が減る補正
        @prize_div = 1

        #セーブする変数
        @prev_muse = [] #過去にスロットに入ったμ’ｓ番号

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
            val = 0.4
            @prize_div = 1
        else if game.bet < 50
            val = 0.42
            @prize_div = 1
        else if game.bet < 100
            val = 0.46
            @prize_div = 0.9
        else if game.bet < 500
            val = 0.48
            @prize_div = 0.9
        else if game.bet < 1000
            val = 0.5
            @prize_div = 0.8
        else if game.bet < 10000
            val = 0.5 + Math.floor(game.bet / 1000) / 100
            @prize_div = Math.floor(800 - (game.bet / 50)) / 1000
        else if game.bet < 100000
            val = 0.6 + Math.floor(game.bet / 10000) / 100
            @prize_div = Math.floor(600 - (game.bet / 500)) / 1000
        else if game.bet < 1000000
            val = 0.7 + Math.floor(game.bet / 10000) / 100
            @prize_div = Math.floor(400 - (game.bet / 5000)) / 1000
        else
            val = 2
            @prize_div = 0.2
        div = 1 + Math.floor(2 * game.tension / @tension_max) / 10
        val = Math.floor(val * div * 100) / 100
        if 100 < game.combo
            div = Math.floor((game.combo - 100) / 20) / 10
            if 2 < div
                div = 2
            val += div
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
            @prev_muse = []
        for key, val of full
            if @prev_muse.indexOf(val) is -1
                remain.push(full[key])
        random = Math.floor(Math.random() * remain.length)
        member = remain[random]
        #member = 17
        @now_muse_num = member
        if @prev_muse.indexOf(member) is -1
            @prev_muse.push(member)

    ###
    挿入するμ’sメンバーの人数を決める
    ###
    setMuseNum:()->
        num = Math.floor(game.combo / 100) + 1
        return num

    ###
    スロットを強制的に当たりにするかどうかを決める
    コンボ数 * 0.06 ％
    テンションMAXで+5補正
    過去のフィーバー回数が少ないほど上方補正かける 0回:+9,1回:+6,2回:+3
    最大値は20％
    フィーバー中は強制的に当たり
    @return boolean true:当たり
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor((game.combo * 0.06) + ((game.tension / @tension_max) * 5))
        if game.past_fever_num <= 2
            rate += ((3 - game.past_fever_num)) * 3
        if rate > 20
            rate = 20
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
        return Math.floor(game.bet * game.combo * 0.03)

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
        if ret_money > 10000000000
            ret_money = 10000000000
        return ret_money

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (@tension_max - game.tension) * 0.005 * (game.item_kind + 1)
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
    アイテムを落とした時のテンションゲージの増減値を決める
    ###
    setTensionItemFall:()->
        val = @tension_max * -0.2
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        return val

    setTensionMissItem:()->
        val = @tension_max * -0.6
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        return val

    ###
    スロットが当たったのテンションゲージの増減値を決める
    @param number prize_money 当選金額
    @param number hit_eye     当たった目の番号
    ###
    setTensionSlotHit:(prize_money, hit_eye)->
        hit_rate = prize_money / game.money
        if game.money < 100
            correct = 0.02
        else if game.money < 1000
            correct = 0.04
        else if game.money < 10000
            correct = 0.06
        else if game.money < 100000
            correct = 0.08
        else
            correct = 0.1
        val = hit_rate * correct * @tension_max
        if val > @tension_max * 0.5
            val = @tension_max * 0.5
        else if val < @tension_max * 0.1
            val = @tension_max * 0.1
        val = Math.round(val)
        if game.debug.fix_tention_slot_hit_flg is true
            val = game.debug.fix_tention_slot_hit_flg
        if hit_eye > 10
            val = @tension_max
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
        if game.bet < 10
            rate_0 = 60
            rate_1 = 80
            rate_2 = 90
            rate_3 = 95
        else if game.bet < 100
            rate_0 = 20
            rate_1 = 60
            rate_2 = 80
            rate_3 = 90
        else if game.bet < 1000
            rate_0 = 10
            rate_1 = 30
            rate_2 = 60
            rate_3 = 80
        else if game.bet < 5000
            rate_0 = 5
            rate_1 = 20
            rate_2 = 40
            rate_3 = 70
        else
            rate_0 = 2
            rate_1 = 10
            rate_2 = 30
            rate_3 = 50
        if rate < rate_0
            val = 0
        else if rate < rate_1
            val = 1
        else if rate < rate_2
            val = 2
        else if rate < rate_3
            val = 3
        else
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
        else if @slotHitRate <= 15
            fixTime = 1.5
            randomTime = 10
        else
            fixTime = 1
            randomTime = 15
        return fixTime + Math.floor(Math.random() * randomTime) / 10
    ###
    スロットの揃った目が全てμ’sなら役を判定して返します
    メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    @return role
    ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:のぞえり、32:ほのりん、33:ことぱな、34:にこまき
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
            when '18,19'    then role = 31
            when '11,15'    then role = 32
            when '12,16'    then role = 33
            when '14,17'    then role = 34
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
        else
            if game.prev_fever_muse.indexOf(parseInt(num)) != -1
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
        return ret
