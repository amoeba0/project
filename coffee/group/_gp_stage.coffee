class gpStage extends appGroup
    constructor: () ->
        super
        @initial()
    initial:()->
        @setPlayer()
    setPlayer:()->
        @bear = new Bear()
        @addChild(@bear)