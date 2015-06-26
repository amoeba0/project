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
            2:10, 3:30, 4:50, 5:100, 6:100, 1:300, 7:600,
            11:1000, 12:1000, 13:1000, 14:1000, 15:1000, 16:1000, 17:1000, 18:1000, 19:1000
        }
        #テンションの最大値
        @tension_max = 500
        #前回入ったμ’sメンバー
        @prev_muse_num = 0

    setGravity:()->
        return Math.floor((game.tension / @tension_max) * 1.5) + 0.5


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
        return result

    ###
    挿入するμ’sメンバーを決める
    ###
    setMuseMember:()->
        result = Math.round(Math.random() * 8) + 11
        @prev_muse_num = result
        return result

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
        random = Math.floor(Math.random() * 100)
        if random < rate
            result = true
        return result

    getReturnMoneyFallValue:()->
        return Math.floor(game.bet * game.combo * 0.02)

    ###
    アイテムを取った時のテンションゲージの増減値を決める
    ###
    setTensionItemCatch:()->
        val = (@tension_max - game.tension) * 0.01 * (game.item_kind + 1)
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
        bet_rate = game.bet / game.money
        if game.money < 100
            correct = 0.2
        else if game.money < 1000
            correct = 0.4
        else if game.money < 10000
            correct = 0.6
        else if game.money < 100000
            correct = 0.8
        else
            correct = 1
        val = bet_rate * correct * @tension_max
        if val > @tension_max
            val = @tension_max
        else if val < @tension_max * 0.05
            val = @tension_max * 0.05
        val = Math.round(val)
        val *= -1
        if game.debug.fix_tention_item_fall_flg is true
            val = game.debug.fix_tention_item_fall_val
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
    @param number tension 変化前のテンション
    @param number val     テンションの増減値
    ###
    changeLilleForTension:(tension, val)->
        slot = game.main_scene.gp_slot
        before = tension
        after = tension + val
        tension_33 = Math.floor(@tension_max * 0.33)
        tension_66 = Math.floor(@tension_max * 0.66)
        if before > tension_33 && after < tension_33
            slot.slotLilleChange(@lille_array, false)
        if before < tension_66 && after > tension_66
            slot.slotLilleChange(@lille_array_2, false)
        if (before < tension_33 || before > tension_66) && (after > tension_33 && after < tension_66)
            slot.slotLilleChange(@lille_array_1, false)
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