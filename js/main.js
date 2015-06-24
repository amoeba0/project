var Bear, Button, Catch, Character, Debug, Floor, Frame, Guest, HomingMoney, HundredHomingMoney, Item, LeftLille, Lille, LoveliveGame, MacaroonCatch, MiddleLille, Money, OneHomingMoney, Panorama, Param, Player, RightLille, Slot, System, TenHomingMoney, ThousandHomingMoney, UnderFrame, UpperFrame, appGame, appGroup, appLabel, appNode, appObject, appScene, appSprite, backGround, betText, catchAndSlotGame, gpPanorama, gpSlot, gpStage, gpSystem, mainScene, moneyText, slotSetting, stageBack, stageFront, text, titleScene,
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


  /*
  数値から右から数えた特定の桁を取り出して数値で返す
  @param number num   数値
  @param number digit 右から数えた桁数、例：1の位は１、10の位は２、１００の位は３
  @return number
   */

  appGame.prototype.getDigitNum = function(num, digit) {
    var result, split, split_num, tmp_num;
    tmp_num = num + '';
    split_num = tmp_num.length - digit;
    split = tmp_num.substring(split_num, split_num + 1);
    result = Number(split);
    return result;
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
    this.w = w;
    this.h = h;
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
    this.slot_setting = new slotSetting();
    this.debug = new Debug();
    this.width = 640;
    this.height = 960;
    this.fps = 24;
    this.imgList = ['chara1', 'icon1', 'lille', 'under_frame'];
    this.sondList = [];
    this.keyList = {
      'left': false,
      'right': false,
      'jump': false
    };
    this.keybind(90, 'z');
    this.preloadAll();
    this.money_init = 10000;
    this.money = 0;
    this.bet = 55;
  }

  LoveliveGame.prototype.onload = function() {
    this.gameInit();
    this.main_scene = new mainScene();
    return this.pushScene(this.main_scene);
  };


  /*
  ゲーム開始時の初期数値調整
   */

  LoveliveGame.prototype.gameInit = function() {
    return this.money = this.money_init;
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
    this.debugSlot();
    this.underFrame = new UnderFrame();
    this.addChild(this.underFrame);
    this.isStopping = false;
    this.stopIntervalFrame = 9;
    this.slotIntervalFrameRandom = 0;
    this.stopStartAge = 0;
    this.slotSet();
  }

  gpSlot.prototype.onenterframe = function(e) {
    return this.slotStopping();
  };


  /*
  スロットが一定の時間差で連続で停止する
   */

  gpSlot.prototype.slotStopping = function() {
    if (this.isStopping === true) {
      if (this.age === this.stopStartAge) {
        this.left_lille.isRotation = false;
        this.setIntervalFrame();
      }
      if (this.age === this.stopStartAge + this.stopIntervalFrame + this.slotIntervalFrameRandom) {
        this.middle_lille.isRotation = false;
        this.setIntervalFrame();
      }
      if (this.age === this.stopStartAge + this.stopIntervalFrame * 2 + this.slotIntervalFrameRandom) {
        this.right_lille.isRotation = false;
        this.isStopping = false;
        return this.slotHitTest();
      }
    }
  };


  /*
  スロットの当選判定
   */

  gpSlot.prototype.slotHitTest = function() {
    var prize_money, _ref;
    if ((this.left_lille.lilleArray[this.left_lille.nowEye] === (_ref = this.middle_lille.lilleArray[this.middle_lille.nowEye]) && _ref === this.right_lille.lilleArray[this.right_lille.nowEye])) {
      prize_money = this._calcPrizeMoney();
      return game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money);
    }
  };


  /*
  スロットの当選金額を計算
   */

  gpSlot.prototype._calcPrizeMoney = function() {
    var eye, ret_money;
    ret_money = 0;
    eye = this.middle_lille.lilleArray[this.middle_lille.nowEye];
    ret_money = game.bet * game.slot_setting.bairitu[eye];
    return ret_money;
  };


  /*
  スロットマシンを画面に設置する
   */

  gpSlot.prototype.slotSet = function() {
    this.left_lille = new LeftLille();
    this.addChild(this.left_lille);
    this.middle_lille = new MiddleLille();
    this.addChild(this.middle_lille);
    this.right_lille = new RightLille();
    return this.addChild(this.right_lille);
  };


  /*
  スロットマシンの回転を始める
   */

  gpSlot.prototype.slotStart = function() {
    this.left_lille.isRotation = true;
    this.middle_lille.isRotation = true;
    return this.right_lille.isRotation = true;
  };


  /*
  スロットマシンの回転を止める
   */

  gpSlot.prototype.slotStop = function() {
    this.stopStartAge = this.age;
    this.isStopping = true;
    this.setIntervalFrame();
    return this.slotStopping();
  };


  /*
  スロットマシン止まる間隔を決める
   */

  gpSlot.prototype.setIntervalFrame = function() {
    return this.slotIntervalFrameRandom = Math.floor(Math.random() * 3);
  };


  /*
  デバッグ用スロットにすりかえる
   */

  gpSlot.prototype.debugSlot = function() {
    if (game.debug.lille_flg === true) {
      return game.slot_setting.lille_array = game.debug.lille_array;
    }
  };

  return gpSlot;

})(appGroup);

gpStage = (function(_super) {
  __extends(gpStage, _super);

  function gpStage() {
    gpStage.__super__.constructor.apply(this, arguments);
    this.floor = 900;
  }

  return gpStage;

})(appGroup);


/*
ステージ前面
プレイヤーや落下アイテムがある
 */

stageFront = (function(_super) {
  __extends(stageFront, _super);

  function stageFront() {
    stageFront.__super__.constructor.apply(this, arguments);
    this.itemFallSec = 5;
    this.catchItems = [];
    this.nowCatchItemsNum = 0;
    this.initial();
  }

  stageFront.prototype.initial = function() {
    return this.setPlayer();
  };

  stageFront.prototype.onenterframe = function() {
    return this._stageCycle();
  };

  stageFront.prototype.setPlayer = function() {
    this.player = new Bear();
    this.player.y = this.floor;
    return this.addChild(this.player);
  };


  /*
  一定周期でステージに発生するイベント
   */

  stageFront.prototype._stageCycle = function() {
    if (game.debug.item_fall_early_flg === true) {
      this.itemFallSec = 3;
    }
    if (this.age % (game.fps * this.itemFallSec) === 0) {
      return this._catchFall();
    }
  };


  /*
  キャッチアイテムをランダムな位置から降らせる
   */

  stageFront.prototype._catchFall = function() {
    if (game.money >= game.bet) {
      this.catchItems.push(new MacaroonCatch());
      this.addChild(this.catchItems[this.nowCatchItemsNum]);
      this.catchItems[this.nowCatchItemsNum].setPosition(1);
      this.nowCatchItemsNum += 1;
      game.money -= game.bet;
      game.main_scene.gp_system.money_text.setValue();
      return game.main_scene.gp_slot.slotStart();
    }
  };

  return stageFront;

})(gpStage);


/*
ステージ背面
コインがある
 */

stageBack = (function(_super) {
  __extends(stageBack, _super);

  function stageBack() {
    stageBack.__super__.constructor.apply(this, arguments);
    this.prizeMoneyItemsConstructor = [];
    this.prizeMoneyItemsNum = {
      1: 0,
      10: 0,
      100: 0,
      1000: 0
    };
    this.nowPrizeMoneyItemsNum = 0;
    this.prizeMoneyFallIntervalFrm = 6;
    this.prizeMoneyFallPeriodSec = 5;
    this.isFallPrizeMoney = false;
  }


  /*
  スロットの当選金額を降らせる
  @param value number 金額
   */

  stageBack.prototype.fallPrizeMoneyStart = function(value) {
    this._calcPrizeMoneyItemsNum(value);
    this._setPrizeMoneyItemsConstructor();
    return console.log(this.prizeMoneyItemsConstructor);
  };


  /*
  当選金の内訳のコイン枚数を計算する
  @param value number 金額
   */

  stageBack.prototype._calcPrizeMoneyItemsNum = function(value) {
    if (value <= 20) {
      this.prizeMoneyItemsNum[1] = value;
      this.prizeMoneyItemsNum[10] = 0;
      this.prizeMoneyItemsNum[100] = 0;
      return this.prizeMoneyItemsNum[1000] = 0;
    } else if (value < 100) {
      this.prizeMoneyItemsNum[1] = game.getDigitNum(value, 1) + 10;
      this.prizeMoneyItemsNum[10] = game.getDigitNum(value, 2) - 1;
      this.prizeMoneyItemsNum[100] = 0;
      return this.prizeMoneyItemsNum[1000] = 0;
    } else if (value < 1000) {
      this.prizeMoneyItemsNum[1] = game.getDigitNum(value, 1);
      this.prizeMoneyItemsNum[10] = game.getDigitNum(value, 2) + 10;
      this.prizeMoneyItemsNum[100] = game.getDigitNum(value, 3) - 1;
      return this.prizeMoneyItemsNum[1000] = 0;
    } else if (value < 10000) {
      this.prizeMoneyItemsNum[1] = game.getDigitNum(value, 1);
      this.prizeMoneyItemsNum[10] = game.getDigitNum(value, 2);
      this.prizeMoneyItemsNum[100] = game.getDigitNum(value, 3) + 10;
      return this.prizeMoneyItemsNum[1000] = game.getDigitNum(value, 4) - 1;
    } else {
      this.prizeMoneyItemsNum[1] = game.getDigitNum(value, 1);
      this.prizeMoneyItemsNum[10] = game.getDigitNum(value, 2);
      this.prizeMoneyItemsNum[100] = game.getDigitNum(value, 3);
      return this.prizeMoneyItemsNum[1000] = Math.floor(value / 1000);
    }
  };


  /*
  当選金コインのコンストラクタを設置
   */

  stageBack.prototype._setPrizeMoneyItemsConstructor = function() {
    var i, _i, _j, _k, _l, _ref, _ref1, _ref2, _ref3, _results;
    this.prizeMoneyItemsConstructor = [];
    if (this.prizeMoneyItemsNum[1] > 0) {
      for (i = _i = 1, _ref = this.prizeMoneyItemsNum[1]; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        this.prizeMoneyItemsConstructor.push(new OneHomingMoney);
      }
    }
    if (this.prizeMoneyItemsNum[10] > 0) {
      for (i = _j = 1, _ref1 = this.prizeMoneyItemsNum[10]; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        this.prizeMoneyItemsConstructor.push(new TenHomingMoney);
      }
    }
    if (this.prizeMoneyItemsNum[100] > 0) {
      for (i = _k = 1, _ref2 = this.prizeMoneyItemsNum[100]; 1 <= _ref2 ? _k <= _ref2 : _k >= _ref2; i = 1 <= _ref2 ? ++_k : --_k) {
        this.prizeMoneyItemsConstructor.push(new HundredHomingMoney);
      }
    }
    if (this.prizeMoneyItemsNum[1000] > 0) {
      _results = [];
      for (i = _l = 1, _ref3 = this.prizeMoneyItemsNum[1000]; 1 <= _ref3 ? _l <= _ref3 : _l >= _ref3; i = 1 <= _ref3 ? ++_l : --_l) {
        _results.push(this.prizeMoneyItemsConstructor.push(new ThousandHomingMoney));
      }
      return _results;
    }
  };

  return stageBack;

})(gpStage);

gpSystem = (function(_super) {
  __extends(gpSystem, _super);

  function gpSystem() {
    gpSystem.__super__.constructor.apply(this, arguments);
    this.money_text = new moneyText();
    this.addChild(this.money_text);
    this.bet_text = new betText();
    this.addChild(this.bet_text);
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


/*
所持金
 */

moneyText = (function(_super) {
  __extends(moneyText, _super);

  function moneyText() {
    moneyText.__super__.constructor.apply(this, arguments);
    this.text = 0;
    this.color = 'black';
    this.font_size = 30;
    this.font = this.font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 0;
    this.y = 10;
    this.zandaka_text = '残高';
    this.yen_text = '円';
    this.setValue();
  }


  /*
  所持金の文字列を設定する
  @param number val 所持金
   */

  moneyText.prototype.setValue = function() {
    this.text = this.zandaka_text + game.money + this.yen_text;
    return this.setXposition();
  };


  /*
  X座標の位置を設定
   */

  moneyText.prototype.setXposition = function() {
    return this.x = game.width - this._boundWidth - 10;
  };

  return moneyText;

})(text);

betText = (function(_super) {
  __extends(betText, _super);

  function betText() {
    betText.__super__.constructor.apply(this, arguments);
    this.text = 0;
    this.color = 'black';
    this.font_size = 30;
    this.font = this.font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 10;
    this.y = 10;
    this.kakekin_text = '掛金';
    this.yen_text = '円';
    this.setValue();
  }

  betText.prototype.setValue = function() {
    return this.text = this.kakekin_text + game.bet + this.yen_text;
  };

  return betText;

})(text);


/*
デバッグ用設定
 */

Debug = (function(_super) {
  __extends(Debug, _super);

  function Debug() {
    Debug.__super__.constructor.apply(this, arguments);
    this.lille_flg = true;
    this.item_flg = true;
    this.item_fall_early_flg = true;
    this.lille_array = [[2, 3], [3, 2], [2, 3]];
  }

  return Debug;

})(appNode);


/*
スロットのリールの並びや掛け金に対する当選額
テンションによるリールの変化確率など
ゲームバランスに作用する固定値の設定
 */

slotSetting = (function(_super) {
  __extends(slotSetting, _super);

  function slotSetting() {
    slotSetting.__super__.constructor.apply(this, arguments);
    this.lille_array = [[1, 2, 3, 4, 2, 3, 5, 2, 1, 3, 4, 5, 2, 5, 7, 1, 2, 3, 4, 5, 1, 7], [3, 5, 2, 5, 4, 2, 3, 4, 7, 2, 1, 5, 4, 3, 5, 2, 3, 7, 1, 4, 5, 3], [2, 4, 1, 5, 1, 4, 2, 7, 2, 4, 3, 1, 7, 2, 3, 7, 1, 5, 3, 2, 4, 5]];
    this.bairitu = {
      2: 10,
      3: 30,
      4: 50,
      5: 100,
      6: 100,
      1: 300,
      7: 600,
      11: 1000,
      12: 1000,
      13: 1000,
      14: 1000,
      15: 1000,
      16: 1000,
      17: 1000,
      18: 1000,
      19: 1000
    };
  }

  return slotSetting;

})(appNode);

mainScene = (function(_super) {
  __extends(mainScene, _super);

  function mainScene() {
    mainScene.__super__.constructor.apply(this, arguments);
    this.backgroundColor = 'rgb(153,204,255)';
    this.initial();
  }

  mainScene.prototype.initial = function() {
    return this.setGroup();
  };

  mainScene.prototype.setGroup = function() {
    this.gp_stage_back = new stageBack();
    this.addChild(this.gp_stage_back);
    this.gp_slot = new gpSlot();
    this.addChild(this.gp_slot);
    this.gp_stage_front = new stageFront();
    this.addChild(this.gp_stage_front);
    this.gp_system = new gpSystem();
    this.addChild(this.gp_system);
    this.gp_slot.x = 150;
    return this.gp_slot.y = 200;
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


  /*
  制約
  ・objectは必ずstageに対して追加する
   */

  function appObject(w, h) {
    appObject.__super__.constructor.call(this, w, h);
    this.gravity = 1.6;
    this.friction = 2.3;
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
    this.isAir = true;
    this.vx = 0;
    this.vy = 0;
    this.ax = 4;
    this.mx = 9;
    this.my = 25;
  }

  Character.prototype.onenterframe = function(e) {
    return this.charMove();
  };


  /*キャラクターの動き */

  Character.prototype.charMove = function() {
    var vx, vy;
    vx = this.vx;
    vy = this.vy;
    if (this.isAir === true) {
      vy = this._speedHeight(vy);
      vx = this._speedWidthAir(vx);
    } else {
      vx = this._speedWidthFloor(vx);
      vy = this._separateFloor();
    }
    this._moveExe(vx, vy);
    this._direction();
    return this._animation();
  };


  /*
  地面にいるキャラクターを地面から離す
  ジャンプボタンをおした時、足場から離れた時など
   */

  Character.prototype._separateFloor = function() {
    var vy;
    vy = 0;
    if (this.moveFlg.jump === true) {
      vy -= this.my;
      this.isAir = true;
    }
    return vy;
  };


  /*
  地面にいるときの横向きの速度を決める
  @vx num x軸速度
  @return num
   */

  Character.prototype._speedWidthFloor = function(vx) {
    if (this.moveFlg.right === true && this.stopAtRight() === true) {
      if (vx < 0) {
        vx = 0;
      } else if (vx < this.mx) {
        vx += this.ax;
      }
    } else if (this.moveFlg.left === true && this.stopAtLeft() === true) {
      if (vx > 0) {
        vx = 0;
      } else if (vx > this.mx * -1) {
        vx -= this.ax;
      }
    } else {
      if (vx > 0) {
        vx -= this.friction;
        if (vx < 0) {
          vx = 0;
        }
      }
      if (vx < 0) {
        vx += this.friction;
        if (vx > 0) {
          vx = 0;
        }
      }
    }
    vx = this.stopAtEnd(vx);
    return vx;
  };


  /*
  空中にいるときの横向きの速度を決める
  @vy num y軸速度
  @return num
   */

  Character.prototype._speedWidthAir = function(vx) {
    vx = this.stopAtEnd(vx);
    return vx;
  };


  /*
  画面端では横向きの速度を0にする
  @param num vx ｘ軸速度
   */

  Character.prototype.stopAtEnd = function(vx) {
    return vx;
  };


  /*
  画面右端で右に移動するのを許可しない
   */

  Character.prototype.stopAtRight = function() {
    return true;
  };


  /*
  画面左端で左に移動するのを許可しない
   */

  Character.prototype.stopAtLeft = function() {
    return true;
  };


  /*
  縦向きの速度を決める
  @vy num y軸速度
  @return num
   */

  Character.prototype._speedHeight = function(vy) {
    vy += this.gravity;
    if (vy < 0) {
      if (this.moveFlg.jump === false) {
        vy = 0;
      }
    } else {
      if (this._crossFloor() === true) {
        vy = 0;
      }
    }
    return vy;
  };


  /*地面にめり込んでる時trueを返す */

  Character.prototype._crossFloor = function() {
    var flg;
    flg = false;
    if (this.vy > 0 && this.y + this.h > this.parentNode.floor) {
      flg = true;
    }
    return flg;
  };


  /*
  動きの実行
  @ｖx num x軸速度
  @vy num y軸速度
   */

  Character.prototype._moveExe = function(vx, vy) {
    var velocityX, velocityY;
    velocityX = 0;
    velocityY = 0;
    if (vx > 0) {
      velocityX = Math.floor(vx);
    } else {
      velocityX = Math.ceil(vx);
    }
    if (vy > 0) {
      velocityY = Math.floor(vy);
    } else {
      velocityY = Math.ceil(vy);
    }
    this.vx = vx;
    this.vy = vy;
    this.x += velocityX;
    this.y += velocityY;
    if (this.isAir === true && this._crossFloor() === true) {
      this.vy = 0;
      this.y = this.parentNode.floor - this.h;
      return this.isAir = false;
    }
  };


  /*
  ボタンを押している方向を向く
   */

  Character.prototype._direction = function() {
    if (this.moveFlg.right === true && this.scaleX < 0) {
      return this.scaleX *= -1;
    } else if (this.moveFlg.left === true && this.scaleX > 0) {
      return this.scaleX *= -1;
    }
  };


  /*
  アニメーションする
   */

  Character.prototype._animation = function() {
    var tmpAge;
    if (this.isAir === false) {
      if (this.vx === 0) {
        return this.frame = 0;
      } else {
        tmpAge = this.age % 10;
        if (tmpAge <= 5) {
          return this.frame = 1;
        } else {
          return this.frame = 2;
        }
      }
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


  /*
  画面端では横向きの速度を0にする
  @param num vx ｘ軸速度
   */

  Player.prototype.stopAtEnd = function(vx) {
    if (0 !== this.vx) {
      if (this.x <= 0) {
        vx = 0;
      }
      if (this.x + this.w >= game.width) {
        vx = 0;
      }
    }
    return vx;
  };


  /*
  画面右端で右に移動するのを許可しない
   */

  Player.prototype.stopAtRight = function() {
    var flg;
    flg = true;
    if (this.x + this.w >= game.width) {
      flg = false;
    }
    return flg;
  };


  /*
  画面左端で左に移動するのを許可しない
   */

  Player.prototype.stopAtLeft = function() {
    var flg;
    flg = true;
    if (this.x <= 0) {
      flg = false;
    }
    return flg;
  };

  return Player;

})(Character);

Bear = (function(_super) {
  __extends(Bear, _super);

  function Bear() {
    Bear.__super__.constructor.call(this, 96, 96);
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
    this.vx = 0;
    this.vy = 0;
  }


  /*
  地面に落ちたら消す
   */

  Item.prototype.removeOnFloor = function() {
    if (this.y > game.height + this.h) {
      return this.parentNode.removeChild(this);
    }
  };

  return Item;

})(appObject);


/*
キャッチする用のアイテム
 */

Catch = (function(_super) {
  __extends(Catch, _super);

  function Catch(w, h) {
    Catch.__super__.constructor.call(this, w, h);
  }

  Catch.prototype.onenterframe = function(e) {
    this.vy += this.gravity;
    this.y += this.vy;
    this.hitPlayer();
    return this.removeOnFloor();
  };


  /*
  プレイヤーに当たった時
   */

  Catch.prototype.hitPlayer = function() {
    if (this.parentNode.player.intersect(this)) {
      this.parentNode.removeChild(this);
      console.log('hit!');
      return game.main_scene.gp_slot.slotStop();
    }
  };


  /*
  座標と落下速度の設定
   */

  Catch.prototype.setPosition = function(gravity) {
    this.y = this.h * -1;
    this.x = this._setPositoinX();
    return this.gravity = gravity;
  };


  /*
  X座標の位置の設定
   */

  Catch.prototype._setPositoinX = function() {
    var ret_x;
    ret_x = 0;
    if (game.debug.item_flg) {
      ret_x = this.parentNode.player.x;
    } else {
      ret_x = Math.floor((game.width - this.w) * Math.random());
    }
    return ret_x;
  };

  return Catch;

})(Item);


/*
マカロン
 */

MacaroonCatch = (function(_super) {
  __extends(MacaroonCatch, _super);

  function MacaroonCatch(w, h) {
    MacaroonCatch.__super__.constructor.call(this, 48, 48);
    this.image = game.imageload("icon1");
    this.frame = 1;
  }

  return MacaroonCatch;

})(Catch);


/*
降ってくるお金
 */

Money = (function(_super) {
  __extends(Money, _super);

  function Money(w, h) {
    Money.__super__.constructor.call(this, w, h);
    this.price = 1;
    Money.__super__.constructor.call(this, 48, 48);
    this.image = game.imageload("icon1");
  }

  Money.prototype.onenterframe = function(e) {
    this.vy += this.gravity;
    this.y += this.vy;
    this.hitPlayer();
    return this.removeOnFloor();
  };


  /*
  プレイヤーに当たった時
   */

  Money.prototype.hitPlayer = function() {
    if (this.parentNode.player.intersect(this)) {
      this.parentNode.removeChild(this);
      game.money += this.price;
      return game.main_scene.gp_system.money_text.setValue();
    }
  };

  return Money;

})(Item);


/*
ホーミングする
 */

HomingMoney = (function(_super) {
  __extends(HomingMoney, _super);

  function HomingMoney(w, h) {
    HomingMoney.__super__.constructor.call(this, w, h);
  }

  return HomingMoney;

})(Money);


/*
1円
 */

OneHomingMoney = (function(_super) {
  __extends(OneHomingMoney, _super);

  function OneHomingMoney(w, h) {
    OneHomingMoney.__super__.constructor.call(this, w, h);
    this.price = 1;
    this.frame = 2;
  }

  return OneHomingMoney;

})(HomingMoney);


/*
10円
 */

TenHomingMoney = (function(_super) {
  __extends(TenHomingMoney, _super);

  function TenHomingMoney(w, h) {
    TenHomingMoney.__super__.constructor.call(this, w, h);
    this.price = 10;
    this.frame = 7;
  }

  return TenHomingMoney;

})(HomingMoney);


/*
100円
 */

HundredHomingMoney = (function(_super) {
  __extends(HundredHomingMoney, _super);

  function HundredHomingMoney(w, h) {
    HundredHomingMoney.__super__.constructor.call(this, w, h);
    this.price = 100;
    this.frame = 5;
  }

  return HundredHomingMoney;

})(HomingMoney);


/*
1000円
 */

ThousandHomingMoney = (function(_super) {
  __extends(ThousandHomingMoney, _super);

  function ThousandHomingMoney(w, h) {
    ThousandHomingMoney.__super__.constructor.call(this, w, h);
    this.price = 1000;
    this.frame = 4;
  }

  return ThousandHomingMoney;

})(HomingMoney);

Slot = (function(_super) {
  __extends(Slot, _super);

  function Slot(w, h) {
    Slot.__super__.constructor.call(this, w, h);
    this.scaleX = 1.5;
    this.scaleY = 1.5;
  }

  return Slot;

})(appSprite);

Frame = (function(_super) {
  __extends(Frame, _super);

  function Frame(w, h) {
    Frame.__super__.constructor.call(this, w, h);
  }

  return Frame;

})(Slot);

UnderFrame = (function(_super) {
  __extends(UnderFrame, _super);

  function UnderFrame(w, h) {
    UnderFrame.__super__.constructor.call(this, 330, 110);
    this.image = game.imageload("under_frame");
  }

  return UnderFrame;

})(Frame);

UpperFrame = (function(_super) {
  __extends(UpperFrame, _super);

  function UpperFrame(w, h) {
    UpperFrame.__super__.constructor.call(this, w, h);
  }

  return UpperFrame;

})(Frame);

Lille = (function(_super) {
  __extends(Lille, _super);

  function Lille(w, h) {
    Lille.__super__.constructor.call(this, 110, 110);
    this.image = game.imageload("lille");
    this.lilleArray = [];
    this.isRotation = false;
    this.nowEye = 0;
  }

  Lille.prototype.onenterframe = function(e) {
    if (this.isRotation === true) {
      return this.eyeIncriment();
    }
  };


  /*
  回転中にリールの目を１つ進める
   */

  Lille.prototype.eyeIncriment = function() {
    this.nowEye += 1;
    if (this.lilleArray[this.nowEye] === void 0) {
      this.nowEye = 0;
    }
    return this.frame = this.lilleArray[this.nowEye];
  };

  Lille.prototype.rotationStop = function() {
    return this.isRotation = false;
  };


  /*
  初回リールの位置をランダムに決める
   */

  Lille.prototype.eyeInit = function() {
    this.nowEye = Math.floor(Math.random() * this.lilleArray.length);
    return this.eyeIncriment();
  };

  return Lille;

})(Slot);

LeftLille = (function(_super) {
  __extends(LeftLille, _super);

  function LeftLille() {
    LeftLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.slot_setting.lille_array[0];
    this.eyeInit();
    this.x = -55;
  }

  return LeftLille;

})(Lille);

MiddleLille = (function(_super) {
  __extends(MiddleLille, _super);

  function MiddleLille() {
    MiddleLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.slot_setting.lille_array[1];
    this.eyeInit();
    this.x = 110;
  }

  return MiddleLille;

})(Lille);

RightLille = (function(_super) {
  __extends(RightLille, _super);

  function RightLille() {
    RightLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.slot_setting.lille_array[2];
    this.eyeInit();
    this.x = 274;
  }

  return RightLille;

})(Lille);

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
