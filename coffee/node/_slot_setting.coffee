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
            [3,2,3,4,2,3,5,2,4,3,4,5,2,5,2,1,2,3,4,5,2,3],
            [3,5,2,5,4,2,3,4,3,2,1,5,4,3,5,2,3,4,1,4,5,3],
            [2,4,1,5,1,4,2,3,2,4,3,1,3,2,3,2,3,5,3,2,4,5]
        ]
        @lille_array_1 = [
            [1,5,3,4,2,3,5,4,1,3,4,5,4,5,4,1,4,5,4,5,1,4],
            [4,5,2,5,4,2,5,4,4,2,1,5,4,3,5,4,3,5,1,4,5,3],
            [5,4,1,5,1,4,2,4,5,4,3,1,5,2,4,5,1,5,3,2,4,5]
        ]
        @lille_array_2 = [
            [1,5,1,4,2,3,1,4,1,5,4,1,2,5,4,1,4,1,4,5,1,4],
            [1,5,2,1,4,2,5,1,5,2,1,5,1,3,1,5,3,4,1,4,5,1],
            [1,4,1,5,1,4,2,1,5,1,3,1,5,2,4,5,1,5,1,3,4,1]
        ]
        #リールの目に対する当選額の倍率
        @bairitu = {
            2:20, 3:30, 4:40, 5:50, 6:60, 1:70, 7:80,
            11:100, 12:100, 13:100, 14:100, 15:100, 16:100, 17:100, 18:100, 19:100
        }
        ###
        カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
        11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
        direction:キャラクターの向き、left or right
        カットインの画像サイズ、頭の位置で570px
        ###
        @muse_material_list = {
            11:{
                'cut_in':[
                    {'name':'11_0', 'width':360, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['11_0', '11_1']
            },
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':510, 'height':728, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['12_0', '12_1']
            },
            13:{
                'cut_in':[
                    {'name':'13_0', 'width':570, 'height':634, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['13_0', '13_1']
            },
            14:{
                'cut_in':[
                    {'name':'14_0', 'width':476, 'height':648, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
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
                    {'name':'16_0', 'width':438, 'height':570, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['16_0', '16_1']
            },
            17:{
                'cut_in':[
                    {'name':'17_0', 'width':465, 'height':705, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['17_0', '17_1']
            },
            18:{
                'cut_in':[
                    {'name':'18_0', 'width':599, 'height':606, 'direction':'right'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['18_0', '18_1']
            },
            19:{
                'cut_in':[
                    {'name':'19_0', 'width':460, 'height':570, 'direction':'left'}
                ],
                'bgm':[
                    {'name':'zenkai_no_lovelive', 'time':30}
                ],
                'voice':['19_0', '19_1']
            }
        }
        #テンションの最大値
        @tension_max = 500
        #現在スロットに入るμ’ｓ番号
        @now_muse_num = 0

        #セーブする変数
        @prev_muse = [] #過去にスロットに入ったμ’ｓ番号

    ###
    落下アイテムの速度
    TODO 掛け金が多いほど速くする、10000円で速すぎて取れないレベルまで上げる
    テンションが高いと速度に補正をかける
    ###
    setGravity:()->
        val = Math.floor((game.tension / @tension_max) * 0.9) + 0.5
        if game.fever is true
            val = 1.2
        return val


    ###
    テンションからスロットにμ’sが入るかどうかを返す
    @return boolean
    ###
    isAddMuse:()->
        result = false
        rate = Math.floor((game.tension / @tension_max) * 15) + 5
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
        #member = 16
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
    コンボ数 * 0.1 ％
    テンションMAXで2倍補正
    過去のフィーバー回数が少ないほど上方補正かける 0回:+15,1回:+10,2回:+5
    フィーバー中は強制的に当たり
    @return boolean true:当たり
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor(game.combo * 0.1 * ((game.tension / @tension_max) + 1))
        if game.past_fever_num <= 2
            rate += (3 - game.past_fever_num) * 5
        if rate > 100
            rate = 100
        random = Math.floor(Math.random() * 100)
        if random < rate || game.fever is true || game.debug.force_slot_hit is true
            result = true
        return result

    getReturnMoneyFallValue:()->
        return Math.floor(game.bet * game.combo * 0.05)

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
        val = game.tension * 0.2
        if val < @tension_max * 0.1
            val = @tension_max * 0.1
        val *= -1
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
        #TODO スロットにμ’ｓがいれば1つ消す
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
        if game.bet < 100
            rate_0 = 60
            rate_1 = 80
            rate_2 = 90
            rate_3 = 95
        else if game.bet < 1000
            rate_0 = 20
            rate_1 = 60
            rate_2 = 80
            rate_3 = 90
        else if game.bet < 10000
            rate_0 = 10
            rate_1 = 30
            rate_2 = 60
            rate_3 = 80
        else if game.bet < 100000
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