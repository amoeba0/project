class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 900
        @initial()
    initial:()->
        @setPlayer()
    setPlayer:()->
        @bear = new Bear()
        @bear.y = @floor
        @addChild(@bear)