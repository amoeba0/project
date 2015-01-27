class mainScene extends appScene
    constructor:()->
        super
        @initial()
    initial:()->
        @setPlayer()
    setPlayer:()->
        @bear = new Bear()
        @addChild(@bear)