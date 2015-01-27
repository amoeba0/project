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
    appGroup.__super__.constructor.apply(this, arguments);
  }

  return appGroup;

})(Group);

appLabel = (function(_super) {
  __extends(appLabel, _super);

  function appLabel() {
    appLabel.__super__.constructor.apply(this, arguments);
  }

  return appLabel;

})(Label);

appNode = (function(_super) {
  __extends(appNode, _super);

  function appNode() {
    appNode.__super__.constructor.apply(this, arguments);
  }

  return appNode;

})(Node);

appScene = (function(_super) {
  __extends(appScene, _super);

  function appScene() {
    appScene.__super__.constructor.apply(this, arguments);
  }

  return appScene;

})(Scene);

appSprite = (function(_super) {
  __extends(appSprite, _super);

  function appSprite(w, h) {
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
    this.main_scene = new mainScene();
    return this.pushScene(this.main_scene);
  };

  return MyGame;

})(Game);

text = (function(_super) {
  __extends(text, _super);

  function text() {
    text.__super__.constructor.apply(this, arguments);
  }

  return text;

})(appLabel);

gameCycle = (function(_super) {
  __extends(gameCycle, _super);

  function gameCycle() {
    gameCycle.__super__.constructor.apply(this, arguments);
  }

  return gameCycle;

})(appNode);

objectCtrl = (function(_super) {
  __extends(objectCtrl, _super);

  function objectCtrl() {
    objectCtrl.__super__.constructor.apply(this, arguments);
  }

  return objectCtrl;

})(appNode);

slotCtrl = (function(_super) {
  __extends(slotCtrl, _super);

  function slotCtrl() {
    slotCtrl.__super__.constructor.apply(this, arguments);
  }

  return slotCtrl;

})(appNode);

mainScene = (function(_super) {
  __extends(mainScene, _super);

  function mainScene() {
    mainScene.__super__.constructor.apply(this, arguments);
    this.initial();
  }

  mainScene.prototype.initial = function() {
    return this.setPlayer();
  };

  mainScene.prototype.setPlayer = function() {
    this.bear = new Bear();
    return this.addChild(this.bear);
  };

  return mainScene;

})(appScene);

titleScene = (function(_super) {
  __extends(titleScene, _super);

  function titleScene() {
    titleScene.__super__.constructor.apply(this, arguments);
  }

  return titleScene;

})(appScene);

backGround = (function(_super) {
  __extends(backGround, _super);

  function backGround(w, h) {
    backGround.__super__.constructor.call(this, w, h);
  }

  return backGround;

})(appSprite);

Floor = (function(_super) {
  __extends(Floor, _super);

  function Floor(w, h) {
    Floor.__super__.constructor.call(this, w, h);
  }

  return Floor;

})(backGround);

Panorama = (function(_super) {
  __extends(Panorama, _super);

  function Panorama(w, h) {
    Panorama.__super__.constructor.call(this, w, h);
  }

  return Panorama;

})(backGround);

appObject = (function(_super) {
  __extends(appObject, _super);

  function appObject(w, h) {
    appObject.__super__.constructor.call(this, w, h);
  }

  return appObject;

})(appSprite);

Character = (function(_super) {
  __extends(Character, _super);

  function Character(w, h) {
    Character.__super__.constructor.call(this, w, h);
  }

  return Character;

})(appObject);

Guest = (function(_super) {
  __extends(Guest, _super);

  function Guest(w, h) {
    Guest.__super__.constructor.call(this, w, h);
  }

  return Guest;

})(Character);

Player = (function(_super) {
  __extends(Player, _super);

  function Player(w, h) {
    Player.__super__.constructor.call(this, w, h);
  }

  return Player;

})(Character);

Bear = (function(_super) {
  __extends(Bear, _super);

  function Bear() {
    Bear.__super__.constructor.call(this, 32, 32);
    this.image = Game.instance.assets["images/chara1.png"];
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

  function Item(w, h) {
    Item.__super__.constructor.call(this, w, h);
  }

  return Item;

})(appObject);

Catch = (function(_super) {
  __extends(Catch, _super);

  function Catch(w, h) {
    Catch.__super__.constructor.call(this, w, h);
  }

  return Catch;

})(Item);

Money = (function(_super) {
  __extends(Money, _super);

  function Money(w, h) {
    Money.__super__.constructor.call(this, w, h);
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
