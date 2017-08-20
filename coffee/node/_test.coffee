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
        @moneyFormat2()
        #@itemCatchTension()
        #@chanceTime()
        #@forceFever()
        #@tensionUp()
        #@nextMuse()
        #@getRoleByMemberSetNow()
        #@getRoleAbleMemberList()
        #@betDown()
        #@setForceFeverRole()
        #@betUp()
        #@appload()
        #@multiload()
        #@isAddMuse()
        #@manySoundLoad()
        #@setMemberItemPrice()
        #@autoMemberSetBeforeFever()
        #@getIsForceSlotHit()
        #@textView()
        #@betChange()
        #@calcMoneyItemsNum()
        #@fallPrizeMoneyStart()
        #@numDigit()

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
        console.log(game.toJPUnit(1234))
        console.log(game.toJPUnit(123456))
        console.log(game.toJPUnit(1234561234))
        console.log(game.toJPUnit(12345612345678))
        console.log(game.toJPUnit(123456123456789012))
        console.log(game.toJPUnit(1234561234567890123456))
        console.log(game.toJPUnit(12345612345678901234567890))
        console.log(game.toJPUnit(123456123456789012345678901234))
        console.log(game.toJPUnit(1234561234567890123456789012341234))
        console.log(game.toJPUnit(12345612345678901234567890123412341234))
        console.log(game.toJPUnit(123456123456789012345678901234123412341234))
        console.log(game.toJPUnit(1234561234567890123456789012341234123412341234))
        console.log(game.toJPUnit(123456123456789012345678901234123412341234123412634))
        console.log(game.toJPUnit(1234561234567890123456789012341234123412341234126341234))

    moneyFormat2:()->
        console.log(game.toJPUnit(1, 1))
        console.log(game.toJPUnit(12, 1))
        console.log(game.toJPUnit(123, 1))
        console.log(game.toJPUnit(1234, 1))
        console.log(game.toJPUnit(12345, 1))
        console.log(game.toJPUnit(123456, 1))
        console.log(game.toJPUnit(1234567, 1))
        console.log(game.toJPUnit(12345678, 1))
        console.log(game.toJPUnit(123456789, 1))
        console.log(game.toJPUnit(1234567890, 1))
        console.log(game.toJPUnit(12345678901, 1))
        console.log(game.toJPUnit(123456789012, 1))
        console.log(game.toJPUnit(1234567890123, 1))
        console.log(game.toJPUnit(12345678901234, 1))
        console.log(game.toJPUnit(123456789012345, 1))
        console.log(game.toJPUnit(1234567890123456, 1))
        console.log(game.toJPUnit(12345678901234567, 1))
        console.log(game.toJPUnit(123456789012345678, 1))
        console.log(game.toJPUnit(1234567890123456789, 1))
        console.log(game.toJPUnit(12345678901234567890, 1))


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
        lille = [15,4,1,4,11,2,5,11,4,2,5,11,4,12,2,3,11,4,11,3]
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

    appload:()->
        game.appLoad('sounds/bgm_maid.mp3')
        game.appLoad('sounds/bgm/zenkai_no_lovelive.mp3', @callbackTest())
        console.log(game.loadedFile)

    callbackTest:()->
        console.log('callbackTest')

    multiload:()->
        files = ['sounds/bgm/zenkai_no_lovelive.mp3', 'sounds/bgm/sweet_holiday.mp3']
        game.multiLoad(files)

    isAddMuse:()->
        console.log(game.member_set_now)
        for i in [1..100]
            rslt = game.slot_setting.isAddMuse()
            console.log(rslt)

    manySoundLoad:()->
        #console.log(enchant.Core.instance.assets['sounds/bgm_maid.mp3'])
        ###
        files = [
            'sounds/bgm/anemone_heart.mp3', 'sounds/bgm/anone_ganbare.mp3', 'sounds/bgm/arihureta.mp3', 'sounds/bgm/beat_in_angel.mp3',
            'sounds/bgm/blueberry.mp3', 'sounds/bgm/daring.mp3', 'sounds/bgm/future_style.mp3', 'sounds/bgm/garasu.mp3',
            'sounds/bgm/hatena_heart.mp3', 'sounds/bgm/hello_hoshi.mp3'
        ]
        game.multiLoad(files)
        ###
        game.appLoad('sounds/bgm/anemone_heart.mp3')
        game.appLoad('sounds/bgm/anone_ganbare.mp3')
        window.setTimeout(console.log(game.loadedFile), 5000)

    setMemberItemPrice:()->
        game.slot_setting.setMemberItemPrice()
        console.log(game.slot_setting.item_list)

    autoMemberSetBeforeFever:()->
        for i in [1..30]
            game.autoMemberSetBeforeFever()
            console.log('member_set_now')
            console.log(game.member_set_now)
            console.log('prev_fever_muse')
            console.log(game.prev_fever_muse)

    getIsForceSlotHit:()->
        game.slot_setting.getIsForceSlotHit()
        game.slot_setting.isForceFever()

    textView:()->
        gp_test = game.test_scene.gp_test
        txt = new moneyText()
        gp_test.addChild(txt)

    betChange:()->
        console.log(game.bet)
        game.slot_setting.betChange(false)

    calcMoneyItemsNum:()->
        val = 2234567890
        rslt = game.main_scene.gp_stage_back._calcMoneyItemsNum(val)
        console.log(rslt)

    fallPrizeMoneyStart:()->
        val = 2234567890
        rslt = game.main_scene.gp_stage_back.fallPrizeMoneyStart(val)

    numDigit:()->
        val = 1234561234567890123456789012341234123412341234126341234
        #val = 1234561234567890
        console.log(val)
        rslt = game.numDigit(val)
        console.log(rslt)