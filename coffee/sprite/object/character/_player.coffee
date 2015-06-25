class Player extends Character
    constructor: (w, h) ->
        super w, h
        @addEventListener("enterframe", ()->
            @keyMove()
        )
    ###キーを押した時の動作###
    keyMove:()->
        # 左
        if game.keyList.left is true
            if @moveFlg.left is false
                @moveFlg.left = true
        else
            if @moveFlg.left is true
                @moveFlg.left = false
        # 右
        if game.keyList.right is true
            if @moveFlg.right is false
                @moveFlg.right = true
        else
            if @moveFlg.right is true
                @moveFlg.right = false
        # ジャンプ
        if game.keyList.jump is true
            if @moveFlg.jump is false
                @moveFlg.jump = true
        else
            if @moveFlg.jump is true
                @moveFlg.jump = false

    ###
    画面端では横向きの速度を0にする
    @param num vx ｘ軸速度
    ###
    stopAtEnd:(vx)->
        if 0 != @vx
            if @x <= 0
                vx = 0
            if @x + @w >= game.width
                vx = 0
        return vx

    ###
    画面右端で右に移動するのを許可しない
    ###
    stopAtRight:()->
        flg = true
        if @x + @w >= game.width
            flg = false
        return flg

    ###
    画面左端で左に移動するのを許可しない
    ###
    stopAtLeft:()->
        flg = true
        if @x <= 0
            flg = false
        return flg

class Bear extends Player
    constructor: () ->
        super 90, 87
        @image = game.imageload("chun")
        @x = 0
        @y = 0