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
        @testSetGravity()

    #以下、テスト用関数

    testGetHitRole:()->
        result = game.slot_setting.getHitRole(17, 17, 14)
        console.log(result)

    testSetGravity:()->
        param = [1, 5, 10, 50, 100, 500, 1000, 2000]
        for key, val of param
            console.log('bet:'+val)
            game.bet = val
            result = game.slot_setting.setGravity()
            console.log('gravity:'+result)