###
テストコード用
###
class Test extends appNode
    constructor: () ->
        super
        @test_exe_flg = false #テスト実行フラグ、trueだとゲーム呼び出し時にテスト関数を走らせる
    ###
    ここにゲーム呼び出し時に実行するテストを書く
    ###
    testExe:()->
        #@testGetHitRole()
        #@testSetGravity()
        #@viewItemList()
        #@testCutin()
        #@preLoadMulti()
        #@addMuse()
        #@moneyFormat()
        #@itemCatchTension()
        #@chanceTime()
        #@forceFever()
        #@tensionUp()
        #@nextMuse()
        #@getRoleByMemberSetNow()
        #@getRoleAbleMemberList()
        #@betDown()
        #@setForceFeverRole()
        @betUp()

    #以下、テスト用関数

    testGetHitRole:()->
        result = game.slot_setting.getHitRole(11, 11, 12)
        console.log(result)

    testSetGravity:()->
        param = [1, 5, 10, 50, 100, 500, 1000, 2000, 8000, 9000, 10000, 20000, 80000, 90000, 100000, 200000, 800000, 900000, 1000000]
        for key, val of param
            console.log('****************')
            console.log('bet:'+val)
            game.bet = val
            result = game.slot_setting.setGravity()
            console.log('gravity:'+result)
            console.log('div:'+game.slot_setting.prize_div)
            console.log('prize:'+game.slot_setting.prize_div * val * 50)


    viewItemList:()->
        game.prev_fever_muse.push(15)
        game.prev_fever_muse.push(11)
        game.slot_setting.setMemberItemPrice()
        console.log(game.slot_setting.item_list)

    testCutin:()->
        for i in [1..100]
            game.main_scene.gp_effect.cutInSet()

    preLoadMulti:()->
        game.member_set_now = [17,18,19]
        game.musePreLoadByMemberSetNow()
        console.log(game.already_added_material)

    addMuse:()->
        game.member_set_now = []
        for i in [1..6]
            num = game.slot_setting.getAddMuseNum()
            console.log(num)

    moneyFormat:()->
        console.log(game.toJPUnit(12000012340000))

    itemCatchTension:()->
        game.past_fever_num = 0
        game.tension = 400
        val = game.slot_setting.setTensionItemCatch()
        console.log(val)

    chanceTime:()->
        val = game.slot_setting.setChanceTime()
        console.log(val)

    forceFever:()->
        game.combo = 200
        game.slot_setting.isForceFever()

    tensionUp:()->
        #game.money = 100000
        game.money = 300
        game.item_kind = 1
        #param = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000, 50000]
        param = [1, 2, 3, 5, 10, 30, 50, 100]
        console.log('所持金：'+game.money)
        console.log('おやつ：'+game.item_kind)
        console.log('*******************')
        for key, val of param
            game.bet = val
            console.log('掛け金：'+game.bet)
            result = game.slot_setting.setTensionItemCatch()
            console.log('アイテム取得：'+result)
            result = game.slot_setting.setTensionSlotHit(3)
            console.log('スロット当たり：'+result)
            result = game.slot_setting.setTensionItemFall()
            console.log('アイテム落下：'+result)
            result = game.slot_setting.setTensionMissItem()
            console.log('ニンニク：'+result)
            console.log('*******************')

    nextMuse:()->
        console.log(game.member_set_now)
        console.log(game.slot_setting.now_muse_num)
        for i in [1..6]
            num = game.slot_setting.getAddMuseNum()
            console.log(num)

    getRoleByMemberSetNow:()->
        console.log(game.member_set_now)
        console.log(game.slot_setting.now_muse_num)
        role = game.getRoleByMemberSetNow()
        console.log(role)

    getRoleAbleMemberList:()->
        console.log(game.item_have_now)
        role = game.slot_setting.getRoleAbleMemberList()
        console.log(role)

    betDown:()->
        game.money = 8549655214758
        console.log(game.money)
        val = game.slot_setting.betDown()
        console.log(val)

    setForceFeverRole:()->
        lille = [15,4,1,4,11,2,5,1,4,2,5,12,4,1,2,3,1,4,13,3]
        role = game.slot_setting.setForceFeverRole(lille)
        console.log(role)

    betUp:()->
        game.auto_bet = 1
        game.money = 62345
        game.bet = 520
        console.log(game.money)
        console.log(game.bet)
        game.slot_setting.betUp()
        console.log(game.bet)
