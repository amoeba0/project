window.onload = ->
  game = new Game(320, 320)
  game.fps = 24
  game.preload('images/chara1.png')
  
  game.onload = ->
    bear = new Bear(32, 32, "images/chara1.png")
    game.rootScene.addChild(bear)
  
  game.start()