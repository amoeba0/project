###
スロットのリールの並びや掛け金に対する当選額
テンションによるリールの変化確率など
ゲームバランスに作用する固定値の設定
###
class slotSetting extends appNode
    constructor: () ->
        super
        #リールの並び
        @lille_array = [
            [3,2,3,4,2,3,5,2,4,3,4,5,2,5,7,1,2,3,4,5,2,3],
            [3,5,2,5,4,2,3,4,7,2,1,5,4,3,5,2,3,7,1,4,5,3],
            [2,4,1,5,1,4,2,7,2,4,3,1,7,2,3,2,3,5,3,2,4,5]
        ]
        @lille_array_1 = [
            [1,5,3,4,2,3,5,4,1,3,4,5,2,5,7,1,4,5,4,5,1,7],
            [4,5,2,5,4,2,5,4,7,2,1,5,4,3,5,4,3,7,1,4,5,3],
            [5,4,1,5,1,4,2,7,5,4,3,1,7,2,4,7,1,5,3,2,4,5]
        ]
        @lille_array_2 = [
            [1,5,7,4,2,3,5,4,1,7,4,5,2,5,7,1,4,1,4,7,1,7],
            [7,5,2,5,7,2,5,1,7,2,1,5,1,3,5,7,3,7,1,4,5,1],
            [1,4,1,7,1,4,2,7,5,7,3,1,7,2,4,7,1,5,7,2,4,1]
        ]
        #リールの目に対する当選額の倍率
        @bairitu = {
            2:10, 3:20, 4:30, 5:50, 6:50, 1:150, 7:300,
            11:500, 12:500, 13:500, 14:500, 15:500, 16:500, 17:500, 18:500, 19:500
        }
        ###
        カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
        11:高坂穂乃果、12:南ことり、13：園田海未
        ###
        @muse_material_list = {
            12:{
                'cut_in':[
                    {'name':'12_0', 'width':680, 'height':970}
                ],
                'bgm':[],
                'voice':[]
            }
        }
        #テンションの最大値
        @tension_max = 500
        #現在スロットに入るμ’ｓ番号
        @now_muse_num = 0
        #過去にスロットに入ったμ’ｓ番号
        @prev_muse = []

    setGravity:()->
        return Math.floor((game.tension / @tension_max) * 1.2) + 0.7


    ###
    テンションからスロットにμ’sが入るかどうかを返す
    @return boolean
    ###
    isAddMuse:()->
        result = false
        rate = Math.floor((game.tension / @tension_max) * 30)
        random = Math.floor(Math.random() * 100)
        if random < rate
            result = true
        if game.debug.force_insert_muse is true
            result = true
        return result

    ###
    挿入するμ’sメンバーを決める
    ###
    setMuseMember:()->
        member = Math.round(Math.random() * 8) + 11
        member = 12
        @now_muse_num = member
        @prev_muse.push(member)

    ###
    挿入するμ’sメンバーの人数を決める
    ###
    setMuseNum:()->
        num = Math.floor(game.combo / 100) + 1
        return num

    ###
    スロットを強制的に当たりにする確率を決める
    ###
    getIsForceSlotHit:()->
        result = false
        rate = Math.floor((game.tension / @tension_max) * 20)
        if game.main_scene.gp_slot.leftSlotEye > 10
            rate *= 2
        random = Math.floor(Math.random() * 100)
        if random < rate
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
        #スロットにμ’ｓがいれば1つ消す
        return val

    ###
    スロットが当たったのテンションゲージの増減値を決める
    @param number prize_money 当選金額
    ###
    setTensionSlotHit:(prize_money)->
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
        if before > tension_33 && after < tension_33
            slot.slotLilleChange(@lille_array, false)
            stage.missItemFallSycle = 4
            stage.missItemFallSycleNow = 0
        if before < tension_66 && after > tension_66
            slot.slotLilleChange(@lille_array_2, false)
            stage.missItemFallSycle = 2
            stage.missItemFallSycleNow = 0
        if (before < tension_33 || before > tension_66) && (after > tension_33 && after < tension_66)
            slot.slotLilleChange(@lille_array_1, false)
            stage.missItemFallSycle = 1
            stage.missItemFallSycleNow = 0
        if before > 0 && after <= 0
            slot.slotLilleChange(@lille_array, true)


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