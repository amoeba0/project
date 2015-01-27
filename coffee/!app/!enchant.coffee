enchant()
window.onload = ->
    #グローバル変数にはwindow.をつけて宣言する
    window.game = new MyGame()
    game.start()