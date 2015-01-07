enchant();

window.onload = function() {
  var game;
  game = new Game(320, 320);
  game.fps = 24;
  game.preload('images/chara1.png');
  game.onload = function() {
    var bear;
    bear = new Bear(32, 32, "images/chara1.png");
    return game.rootScene.addChild(bear);
  };
  return game.start();
};

var Bear,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Bear = (function(_super) {
  __extends(Bear, _super);

  function Bear(w, h, image) {
    Bear.__super__.constructor.call(this, 32, 32);
    this.image = Game.instance.assets[image];
    this.x = 0;
    this.y = 0;
  }

  Bear.prototype.onenterframe = function(e) {
    return this.x = this.x + 1;
  };

  return Bear;

})(Sprite);
