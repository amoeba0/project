class gpStage extends appGroup
    constructor: () ->
        super
        @floor = 300
        @initial()
        #@bg_color = 'rgb(153,204,255)';
    initial:()->
        @setPlayer()
    setPlayer:()->
        @bear = new Bear()
        @bear.y = @floor
        @addChild(@bear)