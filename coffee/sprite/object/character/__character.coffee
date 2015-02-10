class Character extends appObject
    constructor: (w, h) ->
        super w, h
        @moveFlg = {'left':false, 'right':false, 'jump':false}
    onenterframe: (e) ->
        @charMove()
    ###キャラクターの動き###
    charMove:()->
        if @moveFlg.left is true
            @x -= 1
        if @moveFlg.right is true
            @x += 1