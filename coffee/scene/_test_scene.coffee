###
テスト用、空のシーン
###
class testScene extends appScene
    constructor: () ->
        super
        @gp_test = new gpTest()
        @addChild(@gp_test)