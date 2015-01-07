class Bear extends Sprite
  constructor: (w, h, image) ->
    super 32, 32
    @image = Game.instance.assets[image]
    @x = 0
    @y = 0

  onenterframe: (e) ->
    @x = @x + 1