var Bear, Character, MyGame, Player, appSprite,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

enchant();

window.onload = function() {
  var game;
  game = new MyGame();
  return game.start();
};

appSprite = (function(_super) {
  __extends(appSprite, _super);

  function appSprite(w, h, image) {
    appSprite.__super__.constructor.call(this, w, h);
  }

  return appSprite;

})(Sprite);

MyGame = (function(_super) {
  __extends(MyGame, _super);

  function MyGame(w, h) {
    MyGame.__super__.constructor.call(this, width, height);
    this.width = 320;
    this.height = 320;
    this.fps = 24;
    this.preload('images/chara1.png');
  }

  MyGame.prototype.onload = function() {
    var bear;
    bear = new Bear(32, 32, "images/chara1.png");
    return this.rootScene.addChild(bear);
  };

  return MyGame;

})(Game);

Character = (function(_super) {
  __extends(Character, _super);

  function Character(w, h, image) {
    Character.__super__.constructor.call(this, w, h, image);
  }

  return Character;

})(appSprite);

Player = (function(_super) {
  __extends(Player, _super);

  function Player(w, h, image) {
    Player.__super__.constructor.call(this, w, h, image);
  }

  return Player;

})(Character);

Bear = (function(_super) {
  __extends(Bear, _super);

  function Bear(w, h, image) {
    Bear.__super__.constructor.call(this, 32, 32, image);
    this.image = Game.instance.assets[image];
    this.x = 0;
    this.y = 0;
  }

  Bear.prototype.onenterframe = function(e) {
    return this.x = this.x + 1;
  };

  return Bear;

})(Player);

//# sourceMappingURL=main.js.map
