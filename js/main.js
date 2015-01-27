var Bear, Button, Catch, Character, Floor, Guest, Item, Money, MyGame, Panorama, Param, Player, Slot, System, appGroup, appLabel, appNode, appObject, appScene, appSprite, backGround, gameCycle, mainScene, objectCtrl, slotCtrl, text, titleScene,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

enchant();

window.onload = function() {
  var game;
  game = new MyGame();
  return game.start();
};

appGroup = (function(_super) {
  __extends(appGroup, _super);

  function appGroup() {
    return appGroup.__super__.constructor.apply(this, arguments);
  }

  return appGroup;

})(Group);

appLabel = (function(_super) {
  __extends(appLabel, _super);

  function appLabel() {
    return appLabel.__super__.constructor.apply(this, arguments);
  }

  return appLabel;

})(Label);

appNode = (function(_super) {
  __extends(appNode, _super);

  function appNode() {
    return appNode.__super__.constructor.apply(this, arguments);
  }

  return appNode;

})(Node);

appScene = (function(_super) {
  __extends(appScene, _super);

  function appScene() {
    return appScene.__super__.constructor.apply(this, arguments);
  }

  return appScene;

})(Scene);

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
    MyGame.__super__.constructor.call(this, this.width, this.height);
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

text = (function(_super) {
  __extends(text, _super);

  function text() {
    return text.__super__.constructor.apply(this, arguments);
  }

  return text;

})(appLabel);

gameCycle = (function(_super) {
  __extends(gameCycle, _super);

  function gameCycle() {
    return gameCycle.__super__.constructor.apply(this, arguments);
  }

  return gameCycle;

})(appNode);

objectCtrl = (function(_super) {
  __extends(objectCtrl, _super);

  function objectCtrl() {
    return objectCtrl.__super__.constructor.apply(this, arguments);
  }

  return objectCtrl;

})(appNode);

slotCtrl = (function(_super) {
  __extends(slotCtrl, _super);

  function slotCtrl() {
    return slotCtrl.__super__.constructor.apply(this, arguments);
  }

  return slotCtrl;

})(appNode);

mainScene = (function(_super) {
  __extends(mainScene, _super);

  function mainScene() {
    return mainScene.__super__.constructor.apply(this, arguments);
  }

  return mainScene;

})(appScene);

titleScene = (function(_super) {
  __extends(titleScene, _super);

  function titleScene() {
    return titleScene.__super__.constructor.apply(this, arguments);
  }

  return titleScene;

})(appScene);

backGround = (function(_super) {
  __extends(backGround, _super);

  function backGround(w, h, image) {
    backGround.__super__.constructor.call(this, w, h, image);
  }

  return backGround;

})(appSprite);

Floor = (function(_super) {
  __extends(Floor, _super);

  function Floor(w, h, image) {
    Floor.__super__.constructor.call(this, w, h, image);
  }

  return Floor;

})(backGround);

Panorama = (function(_super) {
  __extends(Panorama, _super);

  function Panorama(w, h, image) {
    Panorama.__super__.constructor.call(this, w, h, image);
  }

  return Panorama;

})(backGround);

appObject = (function(_super) {
  __extends(appObject, _super);

  function appObject(w, h, image) {
    appObject.__super__.constructor.call(this, w, h, image);
  }

  return appObject;

})(appSprite);

Character = (function(_super) {
  __extends(Character, _super);

  function Character(w, h, image) {
    Character.__super__.constructor.call(this, w, h, image);
  }

  return Character;

})(appObject);

Guest = (function(_super) {
  __extends(Guest, _super);

  function Guest(w, h, image) {
    Guest.__super__.constructor.call(this, w, h, image);
  }

  return Guest;

})(Character);

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

Item = (function(_super) {
  __extends(Item, _super);

  function Item(w, h, image) {
    Item.__super__.constructor.call(this, w, h, image);
  }

  return Item;

})(appObject);

Catch = (function(_super) {
  __extends(Catch, _super);

  function Catch(w, h, image) {
    Catch.__super__.constructor.call(this, w, h, image);
  }

  return Catch;

})(Item);

Money = (function(_super) {
  __extends(Money, _super);

  function Money(w, h, image) {
    Money.__super__.constructor.call(this, w, h, image);
  }

  return Money;

})(Item);

Slot = (function(_super) {
  __extends(Slot, _super);

  function Slot(w, h, image) {
    Slot.__super__.constructor.call(this, w, h, image);
  }

  return Slot;

})(appSprite);

System = (function(_super) {
  __extends(System, _super);

  function System(w, h, image) {
    System.__super__.constructor.call(this, w, h, image);
  }

  return System;

})(appSprite);

Button = (function(_super) {
  __extends(Button, _super);

  function Button(w, h, image) {
    Button.__super__.constructor.call(this, w, h, image);
  }

  return Button;

})(System);

Param = (function(_super) {
  __extends(Param, _super);

  function Param(w, h, image) {
    Param.__super__.constructor.call(this, w, h, image);
  }

  return Param;

})(System);

//# sourceMappingURL=main.js.map
