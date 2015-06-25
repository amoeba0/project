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
            [1,2,3,4,2,3,5,2,1,3,4,5,2,5,7,1,2,3,4,5,1,7],
            [3,5,2,5,4,2,3,4,7,2,1,5,4,3,5,2,3,7,1,4,5,3],
            [2,4,1,5,1,4,2,7,2,4,3,1,7,2,3,7,1,5,3,2,4,5]
        ]
        #リールの目に対する当選額の倍率
        @bairitu = {
            2:10, 3:30, 4:50, 5:100, 6:100, 1:300, 7:600,
            11:1000, 12:1000, 13:1000, 14:1000, 15:1000, 16:1000, 17:1000, 18:1000, 19:1000
        }
        #テンションの最大値
        @tension_max = 500

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
        #console.log(val)
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
        #console.log(val)
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
        #console.log(val)
        return val

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