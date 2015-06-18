class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 900 #床の位置
        @itemFallSec = 5 #アイテムを降らせる周期（秒）
        @catchItems = [] #キャッチアイテムのコンストラクタを格納
        @nowCatchItemsNum = 0
        @initial()
    initial:()->
        @setPlayer()
    onenterframe: () ->
        @_stageCycle()
    setPlayer:()->
        @player = new Bear()
        @player.y = @floor
        @addChild(@player)
    ###
    一定周期でステージに発生するイベント
    ###
    _stageCycle:()->
        if @age % (game.fps * @itemFallSec) is 0
            @_catchFall()
    ###
    キャッチアイテムをランダムな位置から降らせる
    ###
    _catchFall:()->
        @catchItems.push(new MacaroonCatch())
        @addChild(@catchItems[@nowCatchItemsNum])
        @catchItems[@nowCatchItemsNum].setPosition(1)
        @nowCatchItemsNum += 1