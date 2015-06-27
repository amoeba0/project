var BackPanorama, Bear, Button, Catch, Character, Debug, Floor, Frame, FrontPanorama, Guest, HundredMoney, HundredThousandMoney, Item, LeftLille, Lille, LoveliveGame, MacaroonCatch, MiddleLille, Money, OneMoney, OnionCatch, Panorama, Param, Player, RightLille, Slot, System, TenMoney, TenThousandMoney, TensionGauge, TensionGaugeBack, ThousandMoney, UnderFrame, UpperFrame, appGame, appGroup, appLabel, appNode, appObject, appScene, appSprite, backGround, betText, catchAndSlotGame, comboText, comboUnitText, cutIn, effect, gpEffect, gpPanorama, gpSlot, gpStage, gpSystem, mainScene, moneyText, slotSetting, stageBack, stageFront, text, titleScene,
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
    this.imgList = ['chun', 'sweets', 'lille', 'under_frame', 'okujou', 'sky', 'coin'];
    this.sondList = [];
    this.keyList = {
      'left': false,
      'right': false,
      'jump': false,
      'up': false,
      'down': false
    };
    this.keybind(90, 'z');
    this.preloadAll();
    this.slot_setting.setMuseMember();
    this.musePreLoad();
    this.money_init = 100;
    this.money = 0;
    this.bet = 1;
    this.combo = 0;
    this.tension = 0;
    this.fever = false;
    this.fever_down_tension = 0;
    this.item_kind = 0;
  }

  LoveliveGame.prototype.onload = function() {
    this.gameInit();
    this.main_scene = new mainScene();
    return this.pushScene(this.main_scene);
  };


  /*
  スロットにμ’ｓを挿入するときに必要なカットイン画像や音楽を予めロードしておく
   */

  LoveliveGame.prototype.musePreLoad = function() {
    var key, muse_num, val, _ref, _results;
    muse_num = this.slot_setting.now_muse_num;
    if (this.slot_setting.muse_material_list[muse_num] !== void 0) {
      _ref = this.slot_setting.muse_material_list[muse_num]['cut_in'];
      _results = [];
      for (key in _ref) {
        val = _ref[key];
        _results.push(this.load('images/cut_in/' + val.name + '.png'));
      }
      return _results;
    }
  };


  /*
  ゲーム開始時の初期数値調整
   */

  LoveliveGame.prototype.gameInit = function() {
    return this.money = this.money_init;
  };

  LoveliveGame.prototype.onenterframe = function(e) {
    this.buttonPush();
    return this.tensionSetValueFever();
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
    if (this.input.up === true) {
      if (this.keyList.up === false) {
        this.keyList.up = true;
      }
    } else {
      if (this.keyList.up === true) {
        this.keyList.up = false;
      }
    }
    if (this.input.down === true) {
      if (this.keyList.down === false) {
        this.keyList.down = true;
      }
    } else {
      if (this.keyList.down === true) {
        this.keyList.down = false;
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


  /*
  テンションゲージを増減する
  @param number val 増減値
   */

  LoveliveGame.prototype._tensionSetValue = function(val) {
    this.slot_setting.changeLilleForTension(this.tension, val);
    this.tension += val;
    if (this.tension < 0) {
      this.tension = 0;
    } else if (this.tension > this.slot_setting.tension_max) {
      this.tension = this.slot_setting.tension_max;
    }
    return this.main_scene.gp_system.tension_gauge.setValue();
  };


  /*
  アイテムを取った時にテンションゲージを増減する
   */

  LoveliveGame.prototype.tensionSetValueItemCatch = function() {
    var val;
    val = this.slot_setting.setTensionItemCatch();
    return this._tensionSetValue(val);
  };


  /*
  アイテムを落とした時にテンションゲージを増減する
   */

  LoveliveGame.prototype.tensionSetValueItemFall = function() {
    var val;
    val = this.slot_setting.setTensionItemFall();
    return this._tensionSetValue(val);
  };


  /*
  はずれのアイテムを取った時にテンションゲージを増減する
   */

  LoveliveGame.prototype.tensionSetValueMissItemCatch = function() {
    var val;
    val = this.slot_setting.setTensionItemFall();
    return this._tensionSetValue(val);
  };


  /*
  フィーバー中に一定時間でテンションが下がる
  テンションが0になったらフィーバーを解く
   */

  LoveliveGame.prototype.tensionSetValueFever = function() {
    if (this.fever === true) {
      this._tensionSetValue(this.fever_down_tension);
      if (this.tension <= 0) {
        return this.fever = false;
      }
    }
  };


  /*
  スロットが当たった時にテンションゲージを増減する
  @param number prize_money 当選金額
  @param number hit_eye     当たった目の番号
   */

  LoveliveGame.prototype.tensionSetValueSlotHit = function(prize_money, hit_eye) {
    var val;
    val = this.slot_setting.setTensionSlotHit(prize_money, hit_eye);
    return this._tensionSetValue(val);
  };

  return LoveliveGame;

})(catchAndSlotGame);

gpEffect = (function(_super) {
  __extends(gpEffect, _super);

  function gpEffect() {
    gpEffect.__super__.constructor.apply(this, arguments);
  }

  gpEffect.prototype.cutInSet = function() {
    var setting;
    setting = game.slot_setting;
    if (setting.muse_material_list[setting.now_muse_num] !== void 0) {
      this.cut_in = new cutIn();
      return this.addChild(this.cut_in);
    }
  };

  return gpEffect;

})(appGroup);

gpPanorama = (function(_super) {
  __extends(gpPanorama, _super);

  function gpPanorama() {
    gpPanorama.__super__.constructor.apply(this, arguments);
    this.back_panorama = new BackPanorama();
    this.addChild(this.back_panorama);
    this.front_panorama = new FrontPanorama();
    this.addChild(this.front_panorama);
  }

  return gpPanorama;

})(appGroup);

gpSlot = (function(_super) {
  __extends(gpSlot, _super);

  function gpSlot() {
    gpSlot.__super__.constructor.apply(this, arguments);
    this.underFrame = new UnderFrame();
    this.addChild(this.underFrame);
    this.isStopping = false;
    this.stopIntervalFrame = 9;
    this.slotIntervalFrameRandom = 0;
    this.stopStartAge = 0;
    this.leftSlotEye = 0;
    this.feverSec = 0;
    this.slotSet();
    this.debugSlot();
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
        this.saveLeftSlotEye();
        this.setIntervalFrame();
      }
      if (this.age === this.stopStartAge + this.stopIntervalFrame + this.slotIntervalFrameRandom) {
        this.middle_lille.isRotation = false;
        this.forceHit(this.middle_lille);
        this.setIntervalFrame();
      }
      if (this.age === this.stopStartAge + this.stopIntervalFrame * 2 + this.slotIntervalFrameRandom) {
        this.right_lille.isRotation = false;
        this.forceHit(this.right_lille);
        this.isStopping = false;
        return this.slotHitTest();
      }
    }
  };


  /*
  左のスロットが当たった目を記憶する
   */

  gpSlot.prototype.saveLeftSlotEye = function() {
    return this.leftSlotEye = this.left_lille.lilleArray[this.left_lille.nowEye];
  };


  /*
  確率でスロットを強制的に当たりにする
   */

  gpSlot.prototype.forceHit = function(target) {
    var tmp_eye;
    if (game.slot_setting.getIsForceSlotHit() === true) {
      tmp_eye = this._searchEye(target);
      if (tmp_eye !== 0) {
        target.nowEye = tmp_eye;
        return target.frameChange();
      }
    }
  };

  gpSlot.prototype._searchEye = function(target) {
    var key, result, val, _ref;
    result = 0;
    _ref = target.lilleArray;
    for (key in _ref) {
      val = _ref[key];
      if (result === 0 && val === this.leftSlotEye) {
        result = key;
      }
    }
    return result;
  };


  /*
  スロットの当選判定
   */

  gpSlot.prototype.slotHitTest = function() {
    var hit_eye, member, prize_money, _ref;
    if ((this.left_lille.lilleArray[this.left_lille.nowEye] === (_ref = this.middle_lille.lilleArray[this.middle_lille.nowEye]) && _ref === this.right_lille.lilleArray[this.right_lille.nowEye])) {
      hit_eye = this.left_lille.lilleArray[this.left_lille.nowEye];
      prize_money = this._calcPrizeMoney();
      game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money);
      game.tensionSetValueSlotHit(prize_money, hit_eye);
      return this._feverStart(hit_eye);
    } else {
      if (game.slot_setting.isAddMuse() === true) {
        member = game.slot_setting.now_muse_num;
        return this.slotAddMuse(member, 1);
      }
    }
  };


  /*
  フィーバーを開始する
   */

  gpSlot.prototype._feverStart = function(hit_eye) {
    if (hit_eye > 10 && game.fever === false) {
      game.fever = true;
      game.slot_setting.setMuseMember();
      game.musePreLoad();
      return this._feverBgmStart(hit_eye);
    }
  };


  /*
  フィーバー中のBGMを開始する
   */

  gpSlot.prototype._feverBgmStart = function(hit_eye) {
    var bgm, bgms, random;
    bgms = game.slot_setting.muse_material_list[hit_eye]['bgm'];
    random = Math.floor(Math.random() * bgms.length);
    bgm = bgms[random];
    this.feverSec = bgm['time'];
    game.fever_down_tension = Math.round(game.slot_setting.tension_max * 100 / (this.feverSec * game.fps)) / 100;
    return game.fever_down_tension *= -1;
  };


  /*
  スロットの当選金額を計算
   */

  gpSlot.prototype._calcPrizeMoney = function() {
    var eye, ret_money;
    ret_money = 0;
    eye = this.middle_lille.lilleArray[this.middle_lille.nowEye];
    ret_money = game.bet * game.slot_setting.bairitu[eye];
    if (ret_money > 10000000000) {
      ret_money = 10000000000;
    }
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
  リールを指定のリールに変更する
  @param array   lille     リール
  @param boolean isMuseDel μ’sは削除する
   */

  gpSlot.prototype.slotLilleChange = function(lille, isMuseDel) {
    this.left_lille.lilleArray = this._slotLilleChangeUnit(this.left_lille, lille[0], isMuseDel);
    this.middle_lille.lilleArray = this._slotLilleChangeUnit(this.middle_lille, lille[1], isMuseDel);
    return this.right_lille.lilleArray = this._slotLilleChangeUnit(this.right_lille, lille[2], isMuseDel);
  };


  /*
  リールを指定のリールに変更する（単体）
  リールにμ’sの誰かがいればそのまま残す
  @param array target 変更対象
  @param array change 変更後
  @param boolean isMuseDel μ’sは削除する
   */

  gpSlot.prototype._slotLilleChangeUnit = function(target, change, isMuseDel) {
    var arr, key, val, _ref;
    console.log(isMuseDel);
    arr = [];
    if (isMuseDel === false) {
      _ref = target.lilleArray;
      for (key in _ref) {
        val = _ref[key];
        if (val > 10) {
          arr.push(key);
        }
      }
      if (arr.length > 0) {
        for (key in arr) {
          val = arr[key];
          change[key] = target.lilleArray[key];
        }
      }
    }
    console.log(change);
    return change;
  };


  /*
  リールにμ’sの誰かを挿入
  スロットが止まってハズレだったときに確率で実行
  @param number num メンバーの指定
  @param number cnt 人数の指定
   */

  gpSlot.prototype.slotAddMuse = function(num, cnt) {
    this.left_lille.lilleArray = this._slotAddMuseUnit(num, cnt, this.left_lille);
    this.middle_lille.lilleArray = this._slotAddMuseUnit(num, cnt, this.middle_lille);
    this.right_lille.lilleArray = this._slotAddMuseUnit(num, cnt, this.right_lille);
    return game.main_scene.gp_effect.cutInSet();
  };


  /*
  リールにμ’sの誰かを挿入(単体)
  @param number num   メンバーの指定
  @param number cnt   人数の指定
  @param array  lille リール
   */

  gpSlot.prototype._slotAddMuseUnit = function(num, cnt, lille) {
    var add_num, arr, i, key, random_key, val, _i, _ref;
    arr = [];
    for (i = _i = 1; 1 <= cnt ? _i <= cnt : _i >= cnt; i = 1 <= cnt ? ++_i : --_i) {
      _ref = lille.lilleArray;
      for (key in _ref) {
        val = _ref[key];
        if (val < 10) {
          arr.push(key);
        }
      }
      if (arr.length > 0) {
        random_key = Math.floor(arr.length * Math.random());
        add_num = arr[random_key];
        lille.lilleArray[add_num] = num;
      }
    }
    return lille.lilleArray;
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
      this.left_lille.lilleArray = game.debug.lille_array[0];
      this.middle_lille.lilleArray = game.debug.lille_array[1];
      return this.right_lille.lilleArray = game.debug.lille_array[2];
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
    this.itemFallSecInit = 5;
    this.itemFallFrm = 0;
    this.catchItems = [];
    this.nowCatchItemsNum = 0;
    this.missItemFallSycle = 4;
    this.missItemFallSycleNow = 0;
    this.catchMissItems = [];
    this.nowCatchMissItemsNum = 0;
    this.initial();
  }

  stageFront.prototype.initial = function() {
    this.setPlayer();
    return this.setItemFallSecInit();
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
  アイテムを降らせる間隔を初期化
   */

  stageFront.prototype.setItemFallSecInit = function() {
    if (game.debug.item_fall_early_flg === true) {
      this.itemFallSecInit = 3;
    }
    return this.setItemFallFrm(this.itemFallSecInit);
  };


  /*
  アイテムを降らせる間隔（フレーム）を設定、再設定
   */

  stageFront.prototype.setItemFallFrm = function(sec) {
    this.itemFallSec = sec;
    this.itemFallFrm = game.fps * sec;
    return this.age = 0;
  };


  /*
  一定周期でステージに発生するイベント
   */

  stageFront.prototype._stageCycle = function() {
    if (this.age % this.itemFallFrm === 0) {
      this._catchFall();
      this.missItemFallSycleNow += 1;
      game.main_scene.gp_stage_back.returnMoneyFallStart();
      if (this.itemFallSec !== this.itemFallSecInit) {
        this.setItemFallFrm(this.itemFallSecInit);
      }
    }
    if (this.missItemFallSycleNow === this.missItemFallSycle && this.age % this.itemFallFrm === this.itemFallFrm / 2) {
      this._missCatchFall();
      return this.missItemFallSycleNow = 0;
    }
  };


  /*
  キャッチアイテムをランダムな位置から降らせる
   */

  stageFront.prototype._catchFall = function() {
    if (game.money >= game.bet) {
      this.catchItems.push(new MacaroonCatch());
      this.addChild(this.catchItems[this.nowCatchItemsNum]);
      this.catchItems[this.nowCatchItemsNum].setPosition();
      this.nowCatchItemsNum += 1;
      game.money -= game.bet;
      if (game.bet > game.money) {
        game.bet = game.money;
      }
      game.main_scene.gp_system.money_text.setValue();
      return game.main_scene.gp_slot.slotStart();
    }
  };

  stageFront.prototype._missCatchFall = function() {
    if (game.money >= game.bet) {
      this.catchMissItems.push(new OnionCatch());
      this.addChild(this.catchMissItems[this.nowCatchMissItemsNum]);
      this.catchMissItems[this.nowCatchMissItemsNum].setPosition();
      return this.nowCatchMissItemsNum += 1;
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
    this.prizeMoneyItemsInstance = [];
    this.prizeMoneyItemsNum = {
      1: 0,
      10: 0,
      100: 0,
      1000: 0,
      10000: 0,
      100000: 0
    };
    this.nowPrizeMoneyItemsNum = 0;
    this.prizeMoneyFallIntervalFrm = 4;
    this.prizeMoneyFallPeriodSec = 5;
    this.isFallPrizeMoney = false;
    this.oneSetMoney = 1;
    this.returnMoneyItemsInstance = [];
    this.returnMoneyItemsNum = {
      1: 0,
      10: 0,
      100: 0,
      1000: 0,
      10000: 0,
      100000: 0
    };
    this.nowReturnMoneyItemsNum = 0;
    this.returnMoneyFallIntervalFrm = 4;
  }

  stageBack.prototype.onenterframe = function() {
    this._moneyFall();
    return this._returnMoneyFall();
  };


  /*
  スロットの当選金を降らせる
  @param value number 金額
   */

  stageBack.prototype.fallPrizeMoneyStart = function(value) {
    var stage;
    stage = game.main_scene.gp_stage_front;
    if (value < 1000000) {
      this.prizeMoneyFallIntervalFrm = 4;
    } else if (value < 10000000) {
      this.prizeMoneyFallIntervalFrm = 2;
    } else {
      this.prizeMoneyFallIntervalFrm = 1;
    }
    this.prizeMoneyItemsNum = this._calcMoneyItemsNum(value, true);
    this.prizeMoneyItemsInstance = this._setMoneyItemsInstance(this.prizeMoneyItemsNum, true);
    if (this.prizeMoneyItemsNum[100000] > 1000) {
      this.oneSetMoney = Math.floor(this.prizeMoneyItemsNum[100000] / 1000);
    }
    this.prizeMoneyFallPeriodSec = Math.ceil((this.prizeMoneyItemsInstance.length / this.oneSetMoney) * this.prizeMoneyFallIntervalFrm / game.fps) + stage.itemFallSecInit;
    if (this.prizeMoneyFallPeriodSec > stage.itemFallSecInit) {
      stage.setItemFallFrm(this.prizeMoneyFallPeriodSec);
    }
    return this.isFallPrizeMoney = true;
  };


  /*
  スロットの当選金を降らせる
   */

  stageBack.prototype._moneyFall = function() {
    var i, _i, _ref, _results;
    if (this.isFallPrizeMoney === true && this.age % this.prizeMoneyFallIntervalFrm === 0) {
      _results = [];
      for (i = _i = 1, _ref = this.oneSetMoney; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        this.addChild(this.prizeMoneyItemsInstance[this.nowPrizeMoneyItemsNum]);
        this.prizeMoneyItemsInstance[this.nowPrizeMoneyItemsNum].setPosition();
        this.nowPrizeMoneyItemsNum += 1;
        if (this.nowPrizeMoneyItemsNum === this.prizeMoneyItemsInstance.length) {
          this.nowPrizeMoneyItemsNum = 0;
          _results.push(this.isFallPrizeMoney = false);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    }
  };


  /*
  当選金の内訳のコイン枚数を計算する
  @param value   number 金額
  @prize boolean true:当選金額
   */

  stageBack.prototype._calcMoneyItemsNum = function(value, prize) {
    var ret_data;
    ret_data = {
      1: 0,
      10: 0,
      100: 0,
      1000: 0,
      10000: 0,
      100000: 0
    };
    if (value <= 20) {
      ret_data[1] = value;
      ret_data[10] = 0;
      ret_data[100] = 0;
      ret_data[1000] = 0;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
    } else if (value < 100) {
      ret_data[1] = game.getDigitNum(value, 1) + 10;
      ret_data[10] = game.getDigitNum(value, 2) - 1;
      ret_data[100] = 0;
      ret_data[1000] = 0;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
    } else if (value < 1000) {
      ret_data[1] = game.getDigitNum(value, 1);
      ret_data[10] = game.getDigitNum(value, 2) + 10;
      ret_data[100] = game.getDigitNum(value, 3) - 1;
      ret_data[1000] = 0;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
    } else if (value < 10000) {
      ret_data[1] = game.getDigitNum(value, 1);
      ret_data[10] = game.getDigitNum(value, 2);
      ret_data[100] = game.getDigitNum(value, 3) + 10;
      ret_data[1000] = game.getDigitNum(value, 4) - 1;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
    } else if (value < 100000) {
      ret_data[1] = game.getDigitNum(value, 1);
      ret_data[10] = game.getDigitNum(value, 2);
      ret_data[100] = game.getDigitNum(value, 3);
      ret_data[1000] = game.getDigitNum(value, 4) + 10;
      ret_data[10000] = game.getDigitNum(value, 5) - 1;
      ret_data[100000] = 0;
    } else {
      ret_data[1] = game.getDigitNum(value, 1);
      ret_data[10] = game.getDigitNum(value, 2);
      ret_data[100] = game.getDigitNum(value, 3);
      ret_data[1000] = game.getDigitNum(value, 4);
      ret_data[10000] = game.getDigitNum(value, 5);
      ret_data[100000] = Math.floor(value / 100000);
    }
    return ret_data;
  };


  /*
  当選金コインのインスタンスを設置
  @param number  itemsNum コイン数の内訳
  @param boolean isHoming trueならコインがホーミングする
  @return array
   */

  stageBack.prototype._setMoneyItemsInstance = function(itemsNum, isHoming) {
    var i, ret_data, _i, _j, _k, _l, _m, _n, _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
    ret_data = [];
    if (itemsNum[1] > 0) {
      for (i = _i = 1, _ref = itemsNum[1]; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        ret_data.push(new OneMoney(isHoming));
      }
    }
    if (itemsNum[10] > 0) {
      for (i = _j = 1, _ref1 = itemsNum[10]; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; i = 1 <= _ref1 ? ++_j : --_j) {
        ret_data.push(new TenMoney(isHoming));
      }
    }
    if (itemsNum[100] > 0) {
      for (i = _k = 1, _ref2 = itemsNum[100]; 1 <= _ref2 ? _k <= _ref2 : _k >= _ref2; i = 1 <= _ref2 ? ++_k : --_k) {
        ret_data.push(new HundredMoney(isHoming));
      }
    }
    if (itemsNum[1000] > 0) {
      for (i = _l = 1, _ref3 = itemsNum[1000]; 1 <= _ref3 ? _l <= _ref3 : _l >= _ref3; i = 1 <= _ref3 ? ++_l : --_l) {
        ret_data.push(new ThousandMoney(isHoming));
      }
    }
    if (itemsNum[10000] > 0) {
      for (i = _m = 1, _ref4 = itemsNum[10000]; 1 <= _ref4 ? _m <= _ref4 : _m >= _ref4; i = 1 <= _ref4 ? ++_m : --_m) {
        ret_data.push(new TenThousandMoney(isHoming));
      }
    }
    if (itemsNum[100000] > 0) {
      for (i = _n = 1, _ref5 = itemsNum[100000]; 1 <= _ref5 ? _n <= _ref5 : _n >= _ref5; i = 1 <= _ref5 ? ++_n : --_n) {
        ret_data.push(new HundredThousandMoney(isHoming));
      }
    }
    return ret_data;
  };


  /*
  掛け金の戻り分を降らせる、開始
   */

  stageBack.prototype.returnMoneyFallStart = function() {
    var stage, val;
    val = game.slot_setting.getReturnMoneyFallValue();
    if (val < 10) {

    } else if (val < 100) {
      val = Math.floor(val / 10) * 10;
    } else if (val < 1000) {
      val = Math.floor(val / 100) * 100;
    } else if (val < 10000) {
      val = Math.floor(val / 1000) * 1000;
    } else if (val < 100000) {
      val = Math.floor(val / 10000) * 10000;
    } else {
      val = Math.floor(val / 100000) * 100000;
    }
    this.returnMoneyItemsNum = this._calcMoneyItemsNum(val, false);
    this.returnMoneyItemsInstance = this._setMoneyItemsInstance(this.returnMoneyItemsNum, false);
    stage = game.main_scene.gp_stage_front;
    this.returnMoneyFallIntervalFrm = Math.round(stage.itemFallSecInit * game.fps / this.returnMoneyItemsInstance.length);
    return this.nowReturnMoneyItemsNum = 0;
  };


  /*
  掛け金の戻り分を降らせる
   */

  stageBack.prototype._returnMoneyFall = function() {
    if (this.isFallPrizeMoney === false && this.returnMoneyItemsInstance.length > 0 && this.age % this.returnMoneyFallIntervalFrm === 0) {
      if (this.nowReturnMoneyItemsNum === this.returnMoneyItemsInstance.length) {
        this.returnMoneyItemsInstance = [];
        return this.nowReturnMoneyItemsNum = 0;
      } else {
        this.addChild(this.returnMoneyItemsInstance[this.nowReturnMoneyItemsNum]);
        this.returnMoneyItemsInstance[this.nowReturnMoneyItemsNum].setPosition();
        return this.nowReturnMoneyItemsNum += 1;
      }
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
    this.combo_unit_text = new comboUnitText();
    this.addChild(this.combo_unit_text);
    this.combo_text = new comboText();
    this.addChild(this.combo_text);
    this.tension_gauge_back = new TensionGaugeBack();
    this.addChild(this.tension_gauge_back);
    this.tension_gauge = new TensionGauge();
    this.addChild(this.tension_gauge);
    this.keyList = {
      'up': false,
      'down': false
    };
  }

  gpSystem.prototype.onenterframe = function(e) {
    return this._betSetting();
  };


  /*
  キーの上下を押して掛け金を設定する
   */

  gpSystem.prototype._betSetting = function() {
    if (game.keyList['up'] === true) {
      if (this.keyList['up'] === false) {
        this._getBetSettingValue(true);
        this.keyList['up'] = true;
      }
    } else {
      if (this.keyList['up'] === true) {
        this.keyList['up'] = false;
      }
    }
    if (game.keyList['down'] === true) {
      if (this.keyList['down'] === false) {
        this._getBetSettingValue(false);
        return this.keyList['down'] = true;
      }
    } else {
      if (this.keyList['down'] === true) {
        return this.keyList['down'] = false;
      }
    }
  };

  gpSystem.prototype._getBetSettingValue = function(up) {
    var bet, val;
    val = 1;
    bet = game.bet;
    if (up === true) {
      if (bet < 10) {
        val = 1;
      } else if (bet < 100) {
        val = 10;
      } else if (bet < 1000) {
        val = 100;
      } else if (bet < 10000) {
        val = 1000;
      } else if (bet < 100000) {
        val = 10000;
      } else {
        val = 100000;
      }
    } else {
      if (bet <= 10) {
        val = -1;
      } else if (bet <= 100) {
        val = -10;
      } else if (bet <= 1000) {
        val = -100;
      } else if (bet <= 10000) {
        val = -1000;
      } else if (bet <= 100000) {
        val = -10000;
      } else {
        val = -100000;
      }
    }
    game.bet += val;
    if (game.bet < 1) {
      game.bet = 1;
    } else if (game.bet > game.money) {
      game.bet = game.money;
    } else if (game.bet > 10000000) {
      game.bet = 10000000;
    }
    return this.bet_text.setValue();
  };

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

comboText = (function(_super) {
  __extends(comboText, _super);

  function comboText() {
    comboText.__super__.constructor.apply(this, arguments);
    this.text = 0;
    this.color = 'black';
    this.font_size = 50;
    this.font = this.font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 260;
    this.y = 100;
  }

  comboText.prototype.setValue = function() {
    this.text = game.combo;
    return this.setXposition();
  };

  comboText.prototype.setXposition = function() {
    var unit;
    unit = game.main_scene.gp_system.combo_unit_text;
    this.x = game.width / 2 - (this._boundWidth + unit._boundWidth + 6) / 2;
    return unit.x = this.x + this._boundWidth + 6;
  };

  return comboText;

})(text);

comboUnitText = (function(_super) {
  __extends(comboUnitText, _super);

  function comboUnitText() {
    comboUnitText.__super__.constructor.apply(this, arguments);
    this.text = 'combo';
    this.color = 'black';
    this.font = "30px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 290;
    this.y = 120;
  }

  return comboUnitText;

})(text);


/*
デバッグ用設定
 */

Debug = (function(_super) {
  __extends(Debug, _super);

  function Debug() {
    Debug.__super__.constructor.apply(this, arguments);
    this.all_debug_flg = false;
    this.lille_flg = true;
    this.item_flg = true;
    this.item_fall_early_flg = false;
    this.fix_tention_item_catch_flg = true;
    this.fix_tention_item_fall_flg = false;
    this.fix_tention_slot_hit_flg = false;
    this.force_insert_muse = false;
    this.lille_array = [[15], [15], [15]];
    this.fix_tention_item_catch_val = 50;
    this.fix_tention_item_fall_val = -50;
    this.fix_tention_slot_hit_flg = 200;
    if (this.all_debug_flg === true) {
      this.lille_flg = true;
      this.item_flg = true;
      this.item_fall_early_flg = true;
      this.fix_tention_item_catch_flg = true;
      this.fix_tention_item_fall_flg = true;
      this.fix_tention_slot_hit_flg = true;
      this.force_insert_muse = true;
    }
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
    this.lille_array_0 = [[3, 2, 3, 4, 2, 3, 5, 2, 4, 3, 4, 5, 2, 5, 2, 1, 2, 3, 4, 5, 2, 3], [3, 5, 2, 5, 4, 2, 3, 4, 3, 2, 1, 5, 4, 3, 5, 2, 3, 4, 1, 4, 5, 3], [2, 4, 1, 5, 1, 4, 2, 3, 2, 4, 3, 1, 3, 2, 3, 2, 3, 5, 3, 2, 4, 5]];
    this.lille_array_1 = [[1, 5, 3, 4, 2, 3, 5, 4, 1, 3, 4, 5, 4, 5, 4, 1, 4, 5, 4, 5, 1, 4], [4, 5, 2, 5, 4, 2, 5, 4, 4, 2, 1, 5, 4, 3, 5, 4, 3, 5, 1, 4, 5, 3], [5, 4, 1, 5, 1, 4, 2, 4, 5, 4, 3, 1, 5, 2, 4, 5, 1, 5, 3, 2, 4, 5]];
    this.lille_array_2 = [[1, 5, 1, 4, 2, 3, 1, 4, 1, 5, 4, 1, 2, 5, 4, 1, 4, 1, 4, 5, 1, 4], [1, 5, 2, 1, 4, 2, 5, 1, 5, 2, 1, 5, 1, 3, 1, 5, 3, 4, 1, 4, 5, 1], [1, 4, 1, 5, 1, 4, 2, 1, 5, 1, 3, 1, 5, 2, 4, 5, 1, 5, 1, 3, 4, 1]];
    this.bairitu = {
      2: 20,
      3: 40,
      4: 60,
      5: 80,
      6: 80,
      1: 100,
      7: 150,
      11: 200,
      12: 200,
      13: 200,
      14: 200,
      15: 200,
      16: 200,
      17: 200,
      18: 200,
      19: 200
    };

    /*
    カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
    11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    direction:キャラクターの向き、left or right
    カットインの画像サイズ、頭の位置で760px
     */
    this.muse_material_list = {
      12: {
        'cut_in': [
          {
            'name': '12_0',
            'width': 680,
            'height': 970,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': '',
            'time': 10
          }
        ],
        'voice': []
      },
      15: {
        'cut_in': [
          {
            'name': '15_0',
            'width': 670,
            'height': 760,
            'direction': 'right'
          }
        ],
        'bgm': [
          {
            'name': '',
            'time': 10
          }
        ],
        'voice': []
      }
    };
    this.tension_max = 500;
    this.now_muse_num = 0;
    this.prev_muse = [];
  }

  slotSetting.prototype.setGravity = function() {
    var val;
    val = Math.floor((game.tension / this.tension_max) * 1.2) + 0.7;
    if (game.fever === true) {
      val = 1.6;
    }
    return val;
  };


  /*
  テンションからスロットにμ’sが入るかどうかを返す
  @return boolean
   */

  slotSetting.prototype.isAddMuse = function() {
    var random, rate, result;
    result = false;
    rate = Math.floor((game.tension / this.tension_max) * 15) + 5;
    random = Math.floor(Math.random() * 100);
    if (random < rate) {
      result = true;
    }
    if (game.debug.force_insert_muse === true) {
      result = true;
    }
    if (game.fever === true) {
      result = false;
    }
    return result;
  };


  /*
  挿入するμ’sメンバーを決める
  過去に挿入されたメンバーは挿入しない
   */

  slotSetting.prototype.setMuseMember = function() {
    var full, key, member, random, remain, val;
    full = [11, 12, 13, 14, 15, 16, 17, 18, 19];
    remain = [];
    if (this.prev_muse.length >= 9) {
      this.prev_muse = [];
    }
    for (key in full) {
      val = full[key];
      if (this.prev_muse.indexOf(val) === -1) {
        remain.push(full[key]);
      }
    }
    random = Math.floor(Math.random() * remain.length);
    member = remain[random];
    member = 15;
    this.now_muse_num = member;
    if (this.prev_muse.indexOf(member) === -1) {
      return this.prev_muse.push(member);
    }
  };


  /*
  挿入するμ’sメンバーの人数を決める
   */

  slotSetting.prototype.setMuseNum = function() {
    var num;
    num = Math.floor(game.combo / 100) + 1;
    return num;
  };


  /*
  スロットを強制的に当たりにするかどうかを決める
  @return boolean true:当たり
   */

  slotSetting.prototype.getIsForceSlotHit = function() {
    var random, rate, result;
    result = false;
    rate = Math.floor(game.combo * 0.2);
    if (rate > 100) {
      rate = 100;
    }
    random = Math.floor(Math.random() * 100);
    if (random < rate) {
      result = true;
    }
    if (game.fever === true) {
      result = true;
    }
    return result;
  };

  slotSetting.prototype.getReturnMoneyFallValue = function() {
    return Math.floor(game.bet * game.combo * 0.05);
  };


  /*
  アイテムを取った時のテンションゲージの増減値を決める
   */

  slotSetting.prototype.setTensionItemCatch = function() {
    var val;
    val = (this.tension_max - game.tension) * 0.005 * (game.item_kind + 1);
    if (game.main_scene.gp_stage_front.player.isAir === true) {
      val *= 1.5;
    }
    if (val >= 1) {
      val = Math.round(val);
    } else {
      val = 1;
    }
    if (game.debug.fix_tention_item_catch_flg === true) {
      val = game.debug.fix_tention_item_catch_val;
    }
    if (game.fever === true) {
      val = 0;
    }
    return val;
  };


  /*
  アイテムを落とした時のテンションゲージの増減値を決める
   */

  slotSetting.prototype.setTensionItemFall = function() {
    var val;
    val = game.tension * 0.2;
    if (val < this.tension_max * 0.1) {
      val = this.tension_max * 0.1;
    }
    val *= -1;
    if (game.debug.fix_tention_item_fall_flg === true) {
      val = game.debug.fix_tention_item_fall_val;
    }
    return val;
  };


  /*
  スロットが当たったのテンションゲージの増減値を決める
  @param number prize_money 当選金額
  @param number hit_eye     当たった目の番号
   */

  slotSetting.prototype.setTensionSlotHit = function(prize_money, hit_eye) {
    var correct, hit_rate, val;
    hit_rate = prize_money / game.money;
    if (game.money < 100) {
      correct = 0.02;
    } else if (game.money < 1000) {
      correct = 0.04;
    } else if (game.money < 10000) {
      correct = 0.06;
    } else if (game.money < 100000) {
      correct = 0.08;
    } else {
      correct = 0.1;
    }
    val = hit_rate * correct * this.tension_max;
    if (val > this.tension_max * 0.5) {
      val = this.tension_max * 0.5;
    } else if (val < this.tension_max * 0.1) {
      val = this.tension_max * 0.1;
    }
    val = Math.round(val);
    if (game.debug.fix_tention_slot_hit_flg === true) {
      val = game.debug.fix_tention_slot_hit_flg;
    }
    if (hit_eye > 10) {
      val = this.tension_max;
    }
    if (game.fever === true) {
      val = 0;
    }
    return val;
  };


  /*
  テンションの状態でスロットの内容を変更する
  ミスアイテムの頻度を決める
  @param number tension 変化前のテンション
  @param number val     テンションの増減値
   */

  slotSetting.prototype.changeLilleForTension = function(tension, val) {
    var after, before, slot, stage, tension_33, tension_66;
    slot = game.main_scene.gp_slot;
    stage = game.main_scene.gp_stage_front;
    before = tension;
    after = tension + val;
    tension_33 = Math.floor(this.tension_max * 0.33);
    tension_66 = Math.floor(this.tension_max * 0.66);
    if (before > 0 && after <= 0) {
      return slot.slotLilleChange(this.lille_array_0, true);
    } else if (before > tension_33 && after < tension_33) {
      slot.slotLilleChange(this.lille_array_0, false);
      stage.missItemFallSycle = 4;
      return stage.missItemFallSycleNow = 0;
    } else if (before < tension_66 && after > tension_66) {
      slot.slotLilleChange(this.lille_array_2, false);
      stage.missItemFallSycle = 2;
      return stage.missItemFallSycleNow = 0;
    } else if ((before < tension_33 || before > tension_66) && (after > tension_33 && after < tension_66)) {
      slot.slotLilleChange(this.lille_array_1, false);
      stage.missItemFallSycle = 1;
      return stage.missItemFallSycleNow = 0;
    }
  };


  /*
  落下するアイテムの種類を決める
  @return 0から4のどれか
   */

  slotSetting.prototype.getCatchItemFrame = function() {
    var rate, rate_0, rate_1, rate_2, rate_3, val;
    val = 0;
    rate = Math.round(Math.random() * 100);
    if (game.bet < 100) {
      rate_0 = 60;
      rate_1 = 80;
      rate_2 = 90;
      rate_3 = 95;
    } else if (game.bet < 1000) {
      rate_0 = 20;
      rate_1 = 60;
      rate_2 = 80;
      rate_3 = 90;
    } else if (game.bet < 10000) {
      rate_0 = 10;
      rate_1 = 30;
      rate_2 = 60;
      rate_3 = 80;
    } else if (game.bet < 100000) {
      rate_0 = 5;
      rate_1 = 20;
      rate_2 = 40;
      rate_3 = 70;
    } else {
      rate_0 = 2;
      rate_1 = 10;
      rate_2 = 30;
      rate_3 = 50;
    }
    if (rate < rate_0) {
      val = 0;
    } else if (rate < rate_1) {
      val = 1;
    } else if (rate < rate_2) {
      val = 2;
    } else if (rate < rate_3) {
      val = 3;
    } else {
      val = 4;
    }
    game.item_kind = val;
    return val;
  };

  return slotSetting;

})(appNode);

mainScene = (function(_super) {
  __extends(mainScene, _super);

  function mainScene() {
    mainScene.__super__.constructor.apply(this, arguments);
    this.backgroundColor = '#93F0FF';
    this.initial();
  }

  mainScene.prototype.initial = function() {
    return this.setGroup();
  };

  mainScene.prototype.setGroup = function() {
    this.gp_panorama = new gpPanorama();
    this.addChild(this.gp_panorama);
    this.gp_stage_back = new stageBack();
    this.addChild(this.gp_stage_back);
    this.gp_slot = new gpSlot();
    this.addChild(this.gp_slot);
    this.gp_effect = new gpEffect();
    this.addChild(this.gp_effect);
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

BackPanorama = (function(_super) {
  __extends(BackPanorama, _super);

  function BackPanorama(w, h) {
    BackPanorama.__super__.constructor.call(this, game.width, game.height);
    this.image = game.imageload("sky");
  }

  return BackPanorama;

})(Panorama);

FrontPanorama = (function(_super) {
  __extends(FrontPanorama, _super);

  function FrontPanorama(w, h) {
    FrontPanorama.__super__.constructor.call(this, game.width, 400);
    this.image = game.imageload("okujou");
    this.setPosition();
  }

  FrontPanorama.prototype.setPosition = function() {
    this.x = 0;
    return this.y = 560;
  };

  return FrontPanorama;

})(Panorama);

effect = (function(_super) {
  __extends(effect, _super);

  function effect(w, h) {
    effect.__super__.constructor.call(this, w, h);
  }

  return effect;

})(appSprite);


/*
カットインの画像サイズ、頭の位置で760px
 */

cutIn = (function(_super) {
  __extends(cutIn, _super);

  function cutIn() {
    this._callCutIn();
    cutIn.__super__.constructor.call(this, this.cut_in['width'], this.cut_in['height']);
    this._setInit();
  }

  cutIn.prototype.onenterframe = function(e) {
    if (this.age - this.set_age === this.fast) {
      this.vx = this._setVxSlow();
    }
    if (this.age - this.set_age === this.slow) {
      this.vx = this._setVxFast();
    }
    this.x += this.vx;
    if ((this.cut_in['direction'] === 'left' && this.x < -this.w) || ((this.cut_in['direction'] === 'left' && 'left' === 'right') && this.x > game.width)) {
      return game.main_scene.gp_effect.removeChild(this);
    }
  };

  cutIn.prototype._callCutIn = function() {
    var cut_in_list, cut_in_random, muse_num, setting;
    setting = game.slot_setting;
    muse_num = setting.now_muse_num;
    cut_in_list = setting.muse_material_list[muse_num]['cut_in'];
    cut_in_random = Math.floor(Math.random() * cut_in_list.length);
    return this.cut_in = cut_in_list[cut_in_random];
  };

  cutIn.prototype._setInit = function() {
    this.image = game.imageload('cut_in/' + this.cut_in['name']);
    if (this.cut_in['direction'] === 'left') {
      this.x = game.width;
    } else {
      this.x = -this.w;
    }
    this.y = game.height - this.h;
    this.vx = this._setVxFast();
    game.main_scene.gp_stage_front.setItemFallFrm(7);
    this.set_age = this.age;
    this.fast = 0.5 * game.fps;
    return this.slow = 2 * game.fps + this.fast;
  };

  cutIn.prototype._setVxFast = function() {
    var val;
    val = Math.round(((game.width + this.w) / 2) / (0.5 * game.fps));
    if (this.cut_in['direction'] === 'left') {
      val *= -1;
    }
    return val;
  };

  cutIn.prototype._setVxSlow = function() {
    var val;
    val = Math.round((game.width / 4) / (2 * game.fps));
    if (this.cut_in['direction'] === 'left') {
      val *= -1;
    }
    return val;
  };

  return cutIn;

})(effect);

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
    if (this.vy > 0 && this.y + this.h > game.main_scene.gp_stage_front.floor) {
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
      this.y = game.main_scene.gp_stage_front.floor - this.h;
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
    } else {
      return this.frame = 3;
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
    Bear.__super__.constructor.call(this, 90, 87);
    this.image = game.imageload("chun");
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
    if (game.main_scene.gp_stage_front.player.intersect(this)) {
      game.main_scene.gp_stage_front.removeChild(this);
      game.combo += 1;
      game.main_scene.gp_system.combo_text.setValue();
      game.main_scene.gp_slot.slotStop();
      return game.tensionSetValueItemCatch();
    }
  };


  /*
  地面に落ちたら消す
   */

  Catch.prototype.removeOnFloor = function() {
    if (this.y > game.height + this.h) {
      game.main_scene.gp_stage_front.removeChild(this);
      game.combo = 0;
      game.main_scene.gp_system.combo_text.setValue();
      return game.tensionSetValueItemFall();
    }
  };


  /*
  座標と落下速度の設定
   */

  Catch.prototype.setPosition = function() {
    this.y = this.h * -1;
    this.x = this.setPositoinX();
    this.frame = game.slot_setting.getCatchItemFrame();
    return this.gravity = game.slot_setting.setGravity();
  };


  /*
  X座標の位置の設定
   */

  Catch.prototype.setPositoinX = function() {
    var ret_x;
    ret_x = 0;
    if (game.debug.item_flg) {
      ret_x = game.main_scene.gp_stage_front.player.x;
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
    MacaroonCatch.__super__.constructor.call(this, 50, 50);
    this.image = game.imageload("sweets");
    this.frame = 1;
    this.scaleX = 1.5;
    this.scaleY = 1.5;
  }

  return MacaroonCatch;

})(Catch);

OnionCatch = (function(_super) {
  __extends(OnionCatch, _super);

  function OnionCatch(w, h) {
    OnionCatch.__super__.constructor.call(this, 50, 50);
    this.image = game.imageload("sweets");
    this.frame = 5;
    this.scaleX = 1.5;
    this.scaleY = 1.5;
  }

  OnionCatch.prototype.hitPlayer = function() {
    if (game.main_scene.gp_stage_front.player.intersect(this)) {
      game.main_scene.gp_stage_front.removeChild(this);
      return game.tensionSetValueMissItemCatch();
    }
  };

  OnionCatch.prototype.removeOnFloor = function() {
    if (this.y > game.height + this.h) {
      return game.main_scene.gp_stage_front.removeChild(this);
    }
  };

  OnionCatch.prototype.setPosition = function() {
    this.y = this.h * -1;
    this.x = this.setPositoinX();
    return this.gravity = game.slot_setting.setGravity();
  };

  return OnionCatch;

})(Catch);


/*
降ってくるお金
@param boolean isHoming trueならコインがホーミングする
 */

Money = (function(_super) {
  __extends(Money, _super);

  function Money(isHoming) {
    Money.__super__.constructor.call(this, 35, 40);
    this.vx = 0;
    this.vy = 0;
    this.frame_init = 0;
    this.price = 1;
    this.gravity = 0.5;
    this.image = game.imageload("coin");
    this.isHoming = isHoming;
    this._setGravity();
  }

  Money.prototype.onenterframe = function(e) {
    this.homing();
    this._animation();
    this.vy += this.gravity;
    this.y += this.vy;
    this.x += this.vx;
    this.hitPlayer();
    return this.removeOnFloor();
  };

  Money.prototype._setGravity = function() {
    if (this.isHoming === true) {
      return this.gravity = 2;
    }
  };


  /*
  プレイヤーに当たった時
   */

  Money.prototype.hitPlayer = function() {
    if (game.main_scene.gp_stage_front.player.intersect(this)) {
      game.main_scene.gp_stage_back.removeChild(this);
      game.money += this.price;
      return game.main_scene.gp_system.money_text.setValue();
    }
  };


  /*
  地面に落ちたら消す
   */

  Money.prototype.removeOnFloor = function() {
    if (this.y > game.height + this.h) {
      return game.main_scene.gp_stage_back.removeChild(this);
    }
  };

  Money.prototype.setPosition = function() {
    this.y = this.h * -1;
    return this.x = Math.floor((game.width - this.w) * Math.random());
  };


  /*
  ホーミングする
   */

  Money.prototype.homing = function() {
    if (this.isHoming === true) {
      return this.vx = Math.round((game.main_scene.gp_stage_front.player.x - this.x) / ((game.main_scene.gp_stage_front.player.y - this.y) / this.vy));
    }
  };

  Money.prototype._animation = function() {
    var tmp_frm;
    tmp_frm = this.age % 24;
    switch (tmp_frm) {
      case 0:
        this.scaleX *= -1;
        return this.frame = this.frame_init;
      case 3:
        return this.frame = this.frame_init + 1;
      case 6:
        return this.frame = this.frame_init + 2;
      case 9:
        return this.frame = this.frame_init + 3;
      case 12:
        this.scaleX *= -1;
        return this.frame = this.frame_init + 3;
      case 15:
        return this.frame = this.frame_init + 2;
      case 18:
        return this.frame = this.frame_init + 1;
      case 21:
        return this.frame = this.frame_init;
    }
  };

  return Money;

})(Item);


/*
1円
@param boolean isHoming trueならコインがホーミングする
 */

OneMoney = (function(_super) {
  __extends(OneMoney, _super);

  function OneMoney(isHoming) {
    OneMoney.__super__.constructor.call(this, isHoming);
    this.price = 1;
    this.frame = 0;
    this.frame_init = 0;
  }

  return OneMoney;

})(Money);


/*
10円
@param boolean isHoming trueならコインがホーミングする
 */

TenMoney = (function(_super) {
  __extends(TenMoney, _super);

  function TenMoney(isHoming) {
    TenMoney.__super__.constructor.call(this, isHoming);
    this.price = 10;
    this.frame = 0;
    this.frame_init = 0;
  }

  return TenMoney;

})(Money);


/*
100円
@param boolean isHoming trueならコインがホーミングする
 */

HundredMoney = (function(_super) {
  __extends(HundredMoney, _super);

  function HundredMoney(isHoming) {
    HundredMoney.__super__.constructor.call(this, isHoming);
    this.price = 100;
    this.frame = 4;
    this.frame_init = 4;
  }

  return HundredMoney;

})(Money);


/*
1000円
@param boolean isHoming trueならコインがホーミングする
 */

ThousandMoney = (function(_super) {
  __extends(ThousandMoney, _super);

  function ThousandMoney(isHoming) {
    ThousandMoney.__super__.constructor.call(this, isHoming);
    this.price = 1000;
    this.frame = 4;
    this.frame_init = 4;
  }

  return ThousandMoney;

})(Money);


/*
一万円
@param boolean isHoming trueならコインがホーミングする
 */

TenThousandMoney = (function(_super) {
  __extends(TenThousandMoney, _super);

  function TenThousandMoney(isHoming) {
    TenThousandMoney.__super__.constructor.call(this, isHoming);
    this.price = 10000;
    this.frame = 8;
    this.frame_init = 8;
  }

  return TenThousandMoney;

})(Money);


/*
10万円
@param boolean isHoming trueならコインがホーミングする
 */

HundredThousandMoney = (function(_super) {
  __extends(HundredThousandMoney, _super);

  function HundredThousandMoney(isHoming) {
    HundredThousandMoney.__super__.constructor.call(this, isHoming);
    this.price = 100000;
    this.frame = 8;
    this.frame_init = 8;
  }

  return HundredThousandMoney;

})(Money);

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
    return this.frameChange();
  };

  Lille.prototype.frameChange = function() {
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
    this.lilleArray = game.slot_setting.lille_array_0[0];
    this.eyeInit();
    this.x = -55;
  }

  return LeftLille;

})(Lille);

MiddleLille = (function(_super) {
  __extends(MiddleLille, _super);

  function MiddleLille() {
    MiddleLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.slot_setting.lille_array_0[1];
    this.eyeInit();
    this.x = 110;
  }

  return MiddleLille;

})(Lille);

RightLille = (function(_super) {
  __extends(RightLille, _super);

  function RightLille() {
    RightLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.slot_setting.lille_array_0[2];
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

  Param.prototype.drawRect = function(color) {
    var surface;
    surface = new Surface(this.w, this.h);
    surface.context.fillStyle = color;
    surface.context.fillRect(0, 0, this.w, this.h, 10);
    surface.context.fill();
    return surface;
  };

  return Param;

})(System);

TensionGaugeBack = (function(_super) {
  __extends(TensionGaugeBack, _super);

  function TensionGaugeBack(w, h) {
    TensionGaugeBack.__super__.constructor.call(this, 610, 25);
    this.image = this.drawRect('#FFFFFF');
    this.x = 15;
    this.y = 75;
  }

  return TensionGaugeBack;

})(Param);

TensionGauge = (function(_super) {
  __extends(TensionGauge, _super);

  function TensionGauge(w, h) {
    TensionGauge.__super__.constructor.call(this, 600, 15);
    this.image = this.drawRect('#6EB7DB');
    this.x = 20;
    this.y = 80;
    this.setValue();
  }

  TensionGauge.prototype.setValue = function() {
    var tension;
    tension = 0;
    if (game.tension !== 0) {
      tension = game.tension / game.slot_setting.tension_max;
    }
    this.scaleX = tension;
    this.x = 20 - ((this.w - tension * this.w) / 2);
    if (tension < 0.25) {
      return this.image = this.drawRect('#6EB7DB');
    } else if (tension < 0.5) {
      return this.image = this.drawRect('#B2CF3E');
    } else if (tension < 0.75) {
      return this.image = this.drawRect('#F3C759');
    } else if (tension < 1) {
      return this.image = this.drawRect('#EDA184');
    } else {
      return this.image = this.drawRect('#F4D2DE');
    }
  };

  return TensionGauge;

})(Param);

//# sourceMappingURL=main.js.map
