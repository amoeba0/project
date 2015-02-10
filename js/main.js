var Bear, Button, Catch, Character, Floor, Guest, Item, LoveliveGame, Money, Panorama, Param, Player, Slot, System, appGame, appGroup, appLabel, appNode, appObject, appScene, appSprite, backGround, catchAndSlotGame, gameCycle, gpPanorama, gpSlot, gpStage, gpSystem, mainScene, objectCtrl, slotCtrl, text, titleScene,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

enchant();

window.onload = function() {
  window.game = new LoveliveGame();
  return game.start();
};

appGame = (function(_super) {
  __extends(appGame, _super);

  function appGame(w, h) {
    appGame.__super__.constructor.call(this, w, h);
    this.mute = false;
    this.imgList = [];
    this.soundList = [];
  }


  /*
      画像の呼び出し
   */

  appGame.prototype.imageload = function(img) {
    return this.assets["images/" + img + ".png"];
  };


  /*
      音声の呼び出し
   */

  appGame.prototype.soundload = function(sound) {
    return this.assets["sounds/" + sound + ".mp3"];
  };


  /*
      素材をすべて読み込む
   */

  appGame.prototype.preloadAll = function() {
    var tmp, val, _i, _j, _len, _len1, _ref, _ref1;
    tmp = [];
    if (this.imgList != null) {
      _ref = this.imgList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        val = _ref[_i];
        tmp.push("images/" + val + ".png");
      }
    }
    if (this.mute === false && (this.soundList != null)) {
      _ref1 = this.soundList;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        val = _ref1[_j];
        tmp.push("sounds/" + val + ".mp3");
      }
    }
    return this.preload(tmp);
  };

  return appGame;

})(Game);

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

catchAndSlotGame = (function(_super) {
  __extends(catchAndSlotGame, _super);

  function catchAndSlotGame(w, h) {
    catchAndSlotGame.__super__.constructor.call(this, w, h);
  }

  return catchAndSlotGame;

})(appGame);

LoveliveGame = (function(_super) {
  __extends(LoveliveGame, _super);

  function LoveliveGame() {
    LoveliveGame.__super__.constructor.call(this, this.width, this.height);
    this.width = 320;
    this.height = 320;
    this.fps = 24;
    this.imgList = ['chara1', 'icon1'];
    this.sondList = [];
    this.keyList = {
      'left': false,
      'right': false,
      'jump': false
    };
    this.keybind(90, 'z');
    this.preloadAll();
  }

  LoveliveGame.prototype.onload = function() {
    this.main_scene = new mainScene();
    return this.pushScene(this.main_scene);
  };

  LoveliveGame.prototype.onenterframe = function(e) {
    return this.buttonPush();
  };


  /*ボタン操作、物理キーとソフトキー両方に対応 */

  LoveliveGame.prototype.buttonPush = function() {
    if (this.input.left === true) {
      if (this.keyList.left === false) {
        this.keyList.left = true;
      }
    } else {
      if (this.keyList.left === true) {
        this.keyList.left = false;
      }
    }
    if (this.input.right === true) {
      if (this.keyList.right === false) {
        this.keyList.right = true;
      }
    } else {
      if (this.keyList.right === true) {
        this.keyList.right = false;
      }
    }
    if (this.input.z === true) {
      if (this.keyList.jump === false) {
        return this.keyList.jump = true;
      }
    } else {
      if (this.keyList.jump === true) {
        return this.keyList.jump = false;
      }
    }
  };

  return LoveliveGame;

})(catchAndSlotGame);

gpPanorama = (function(_super) {
  __extends(gpPanorama, _super);

  function gpPanorama() {
    gpPanorama.__super__.constructor.apply(this, arguments);
  }

  return gpPanorama;

})(appGroup);

gpSlot = (function(_super) {
  __extends(gpSlot, _super);

  function gpSlot() {
    gpSlot.__super__.constructor.apply(this, arguments);
  }

  return gpSlot;

})(appGroup);

gpStage = (function(_super) {
  __extends(gpStage, _super);

  function gpStage() {
    gpStage.__super__.constructor.apply(this, arguments);
    this.initial();
  }

  gpStage.prototype.initial = function() {
    return this.setPlayer();
  };

  gpStage.prototype.setPlayer = function() {
    this.bear = new Bear();
    return this.addChild(this.bear);
  };

  return gpStage;

})(appGroup);

gpSystem = (function(_super) {
  __extends(gpSystem, _super);

  function gpSystem() {
    gpSystem.__super__.constructor.apply(this, arguments);
  }

  return gpSystem;

})(appGroup);

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
    return this.setGroup();
  };

  mainScene.prototype.setGroup = function() {
    this.gp_stage = new gpStage();
    return this.addChild(this.gp_stage);
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
    this.moveFlg = {
      'left': false,
      'right': false,
      'jump': false
    };
  }

  Character.prototype.onenterframe = function(e) {
    return this.charMove();
  };


  /*キャラクターの動き */

  Character.prototype.charMove = function() {
    if (this.moveFlg.left === true) {
      this.x -= 1;
    }
    if (this.moveFlg.right === true) {
      return this.x += 1;
    }
  };

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
    this.addEventListener("enterframe", function() {
      return this.keyMove();
    });
  }


  /*キーを押した時の動作 */

  Player.prototype.keyMove = function() {
    if (game.keyList.left === true) {
      if (this.moveFlg.left === false) {
        this.moveFlg.left = true;
      }
    } else {
      if (this.moveFlg.left === true) {
        this.moveFlg.left = false;
      }
    }
    if (game.keyList.right === true) {
      if (this.moveFlg.right === false) {
        this.moveFlg.right = true;
      }
    } else {
      if (this.moveFlg.right === true) {
        this.moveFlg.right = false;
      }
    }
    if (game.keyList.jump === true) {
      if (this.moveFlg.jump === false) {
        return this.moveFlg.jump = true;
      }
    } else {
      if (this.moveFlg.jump === true) {
        return this.moveFlg.jump = false;
      }
    }
  };

  return Player;

})(Character);

Bear = (function(_super) {
  __extends(Bear, _super);

  function Bear() {
    Bear.__super__.constructor.call(this, 32, 32);
    this.image = game.imageload("chara1");
    this.x = 0;
    this.y = 0;
  }

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

  function Slot(w, h) {
    Slot.__super__.constructor.call(this, w, h);
  }

  return Slot;

})(appSprite);

System = (function(_super) {
  __extends(System, _super);

  function System(w, h) {
    System.__super__.constructor.call(this, w, h);
  }

  return System;

})(appSprite);

Button = (function(_super) {
  __extends(Button, _super);

  function Button(w, h) {
    Button.__super__.constructor.call(this, w, h);
  }

  return Button;

})(System);

Param = (function(_super) {
  __extends(Param, _super);

  function Param(w, h) {
    Param.__super__.constructor.call(this, w, h);
  }

  return Param;

})(System);

//# sourceMappingURL=main.js.map
