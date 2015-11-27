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
        @testGetHitRole()
        #@testSetGravity()
        #@viewItemList()
        #@testCutin()
        #@preLoadMulti()
        #@addMuse()

    #以下、テスト用関数

    testGetHitRole:()->
        result = game.slot_setting.getHitRole(11, 11, 12)
        console.log(result)

    testSetGravity:()->
        param = [1, 5, 10, 50, 100, 500, 1000, 2000]
        for key, val of param
            console.log('bet:'+val)
            game.bet = val
            result = game.slot_setting.setGravity()
            console.log('gravity:'+result)

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