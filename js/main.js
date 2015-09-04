var BackPanorama, Bear, Button, Catch, Character, Debug, Dialog, Floor, Frame, FrontPanorama, Guest, HundredMoney, HundredThousandMoney, Item, ItemGauge, ItemGaugeBack, ItemSlot, LeftLille, Lille, LoveliveGame, MacaroonCatch, MiddleLille, Money, OneMoney, OnionCatch, Panorama, Param, Player, RightLille, Slot, System, TenMoney, TenThousandMoney, TensionGauge, TensionGaugeBack, Test, ThousandMoney, UnderFrame, UpperFrame, appDomLayer, appGame, appGroup, appHtml, appLabel, appNode, appObject, appScene, appSprite, backGround, baseCancelButtonHtml, baseDialogHtml, baseItemHtml, baseOkButtonHtml, betButton, betText, bigKotori, buttonHtml, buyItemButtonHtml, buyItemHtml, buyMemberHtml, catchAndSlotGame, chanceEffect, comboText, comboUnitText, controllerButton, cutIn, dialogCloseButton, dialogHtml, discriptionTextDialogHtml, effect, feverEffect, feverOverlay, gpBackPanorama, gpEffect, gpFrontPanorama, gpPanorama, gpSlot, gpStage, gpSystem, heighBetButton, imageHtml, itemBuyCancelButtonHtml, itemBuyDialogCloseButton, itemBuyDialogHtml, itemBuySelectDialogHtml, itemDiscription, itemHtml, itemItemBuyDiscription, itemNameDiscription, itemUseDialogCloseButton, itemUseDialogHtml, jumpButton, kirakiraEffect, leftButton, lowBetButton, mainScene, memberHtml, memberItemBuyDiscription, memberSetDialogCloseButton, memberSetDialogHtml, menuDialogHtml, modal, moneyText, panoramaEffect, pauseBack, pauseButton, pauseItemBuyLayer, pauseItemBuySelectLayer, pauseItemUseLayer, pauseMainLayer, pauseMainMenuButtonHtml, pauseMemberSetLayer, pauseSaveLayer, pauseScene, performanceEffect, returnGameButtonHtml, rightButton, saveDialogHtml, saveGameButtonHtml, saveOkButtonHtml, selectDialogHtml, selectItemImage, setMemberButtonHtml, slotSetting, stageBack, stageFront, startGameButtonHtml, systemHtml, testScene, text, titleDiscription, titleMainLayer, titleMenuButtonHtml, titleScene, useItemButtonHtml, useItemHtml, useMemberHtml,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

enchant();

window.onload = function() {
  window.game = new LoveliveGame();
  return game.start();
};

appDomLayer = (function(_super) {
  __extends(appDomLayer, _super);

  function appDomLayer() {
    appDomLayer.__super__.constructor.apply(this, arguments);
    this.modal = new modal();
  }

  return appDomLayer;

})(DomLayer);

appGame = (function(_super) {
  __extends(appGame, _super);

  function appGame(w, h) {
    appGame.__super__.constructor.call(this, w, h);
    this.scale = 1;
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
  効果音を鳴らす
   */

  appGame.prototype.sePlay = function(se) {
    return se.clone().play();
  };


  /*
  BGMをならす
   */

  appGame.prototype.bgmPlay = function(bgm, bgm_loop) {
    if (bgm !== void 0) {
      bgm.play();
      if (bgm_loop === true) {
        return bgm._element.loop = true;
      }
    }
  };


  /*
  BGMを止める
   */

  appGame.prototype.bgmStop = function(bgm) {
    if (bgm !== void 0) {
      return bgm.stop();
    }
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


  /*
  配列、オブジェクトの参照渡しを防ぐためにコピーする
  http://monopocket.jp/blog/javascript/2137/
  @param array or object target コピー対象
  @param boolean isObject true:object false:array
  @return array or object
   */

  appGame.prototype.arrayCopy = function(target, isObject) {
    var tmp_arr;
    if (isObject == null) {
      isObject = false;
    }
    if (isObject === true) {
      tmp_arr = {};
    } else {
      tmp_arr = [];
    }
    return $.extend(true, tmp_arr, target);
  };


  /*
  配列から重複を除外したリストを返す
   */

  appGame.prototype.getDeduplicationList = function(arr) {
    return arr.filter(function(x, i, self) {
      return self.indexOf(x) === i;
    });
  };


  /*
  数値の昇順ソート
   */

  appGame.prototype.sortAsc = function(arr) {
    return arr.sort(function(a, b) {
      if (a < b) {
        return -1;
      }
      if (a > b) {
        return 1;
      }
      return 0;
    });
  };


  /*
  数値の降順ソート
   */

  appGame.prototype.sortDesc = function(arr) {
    return arr.sort(function(a, b) {
      if (a > b) {
        return -1;
      }
      if (a < b) {
        return 1;
      }
      return 0;
    });
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

appHtml = (function(_super) {
  __extends(appHtml, _super);

  function appHtml(width, height) {
    appHtml.__super__.constructor.apply(this, arguments);
    this._element = document.createElement('div');
    this.width = width;
    this.height = height;
  }

  return appHtml;

})(Entity);

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

pauseItemBuyLayer = (function(_super) {
  __extends(pauseItemBuyLayer, _super);

  function pauseItemBuyLayer() {
    var i, _i, _j;
    pauseItemBuyLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new itemBuyDialogHtml();
    this.close_button = new itemBuyDialogCloseButton();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.close_button);
    this.item_list = {};
    for (i = _i = 1; _i <= 9; i = ++_i) {
      this.item_list[i] = new buyItemHtml(i);
    }
    this.member_list = {};
    for (i = _j = 11; _j <= 19; i = ++_j) {
      this.member_list[i] = new buyMemberHtml(i);
    }
    this.setItemList();
    this.item_title = new itemItemBuyDiscription();
    this.addChild(this.item_title);
    this.member_title = new memberItemBuyDiscription();
    this.addChild(this.member_title);
  }

  pauseItemBuyLayer.prototype.setItemList = function() {
    var item_key, item_val, member_key, member_val, _ref, _ref1, _results;
    _ref = this.item_list;
    for (item_key in _ref) {
      item_val = _ref[item_key];
      this.addChild(item_val);
      item_val.setPosition();
    }
    _ref1 = this.member_list;
    _results = [];
    for (member_key in _ref1) {
      member_val = _ref1[member_key];
      this.addChild(member_val);
      _results.push(member_val.setPosition());
    }
    return _results;
  };

  return pauseItemBuyLayer;

})(appDomLayer);

pauseItemBuySelectLayer = (function(_super) {
  __extends(pauseItemBuySelectLayer, _super);

  function pauseItemBuySelectLayer() {
    pauseItemBuySelectLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new itemBuySelectDialogHtml();
    this.cancel_button = new itemBuyCancelButtonHtml();
    this.item_name = new itemNameDiscription();
    this.item_image = new selectItemImage();
    this.item_discription = new itemDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.item_image);
    this.addChild(this.item_name);
    this.addChild(this.item_discription);
    this.addChild(this.cancel_button);
  }

  pauseItemBuySelectLayer.prototype.setSelectItem = function(kind) {
    var discription, item_options;
    item_options = game.slot_setting.item_list[kind];
    if (item_options === void 0) {
      item_options = game.slot_setting.item_list[0];
    }
    this.item_name.setText(item_options.name);
    this.item_image.setImage(item_options.image);
    discription = this._setDiscription(item_options);
    return this.item_discription.setText(discription);
  };

  pauseItemBuySelectLayer.prototype._setDiscription = function(item_options) {
    var text;
    text = '効果：' + item_options.discription;
    if (item_options.durationSec !== void 0) {
      text += '<br>持続時間：' + item_options.durationSec + '秒';
    }
    if (item_options.condFunc() === true) {
      text += '<br>値段：' + item_options.price + '円';
    } else {
      text += '<br>出現条件：' + item_options.conditoin;
    }
    return text;
  };

  return pauseItemBuySelectLayer;

})(appDomLayer);

pauseItemUseLayer = (function(_super) {
  __extends(pauseItemUseLayer, _super);

  function pauseItemUseLayer() {
    pauseItemUseLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new itemUseDialogHtml();
    this.close_button = new itemUseDialogCloseButton();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.close_button);
  }

  return pauseItemUseLayer;

})(appDomLayer);

pauseMainLayer = (function(_super) {
  __extends(pauseMainLayer, _super);

  function pauseMainLayer() {
    pauseMainLayer.__super__.constructor.apply(this, arguments);
    this.return_game_button = new returnGameButtonHtml();
    this.save_game_button = new saveGameButtonHtml();
    this.buy_item_button = new buyItemButtonHtml();
    this.use_item_button = new useItemButtonHtml();
    this.set_member_button = new setMemberButtonHtml();
    this.addChild(this.return_game_button);
    this.addChild(this.save_game_button);
    this.addChild(this.buy_item_button);
    this.addChild(this.use_item_button);
    this.addChild(this.set_member_button);
  }

  return pauseMainLayer;

})(appDomLayer);

pauseMemberSetLayer = (function(_super) {
  __extends(pauseMemberSetLayer, _super);

  function pauseMemberSetLayer() {
    pauseMemberSetLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new memberSetDialogHtml();
    this.close_button = new memberSetDialogCloseButton();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.close_button);
  }

  return pauseMemberSetLayer;

})(appDomLayer);

pauseSaveLayer = (function(_super) {
  __extends(pauseSaveLayer, _super);

  function pauseSaveLayer() {
    pauseSaveLayer.__super__.constructor.apply(this, arguments);
    this.addChild(this.modal);
    this.dialog = new saveDialogHtml();
    this.addChild(this.dialog);
    this.ok_button = new saveOkButtonHtml();
    this.addChild(this.ok_button);
  }

  return pauseSaveLayer;

})(appDomLayer);

titleMainLayer = (function(_super) {
  __extends(titleMainLayer, _super);

  function titleMainLayer() {
    titleMainLayer.__super__.constructor.apply(this, arguments);
    this.start_game_button = new startGameButtonHtml();
    this.addChild(this.start_game_button);
  }

  return titleMainLayer;

})(appDomLayer);

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
    this.local_storage = window.localStorage;
    this.debug = new Debug();
    this.slot_setting = new slotSetting();
    this.test = new Test();
    this.width = 480;
    this.height = 720;
    this.fps = 24;
    this.imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira', 'big-kotori'];
    this.soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear'];
    this.keybind(90, 'z');
    this.keybind(88, 'x');
    this.preloadAll();
    this.slot_setting.setMuseMember();
    this.musePreLoad();
    this.money_init = 100;
    this.fever = false;
    this.fever_down_tension = 0;
    this.item_kind = 0;
    this.fever_hit_eye = 0;
    this.money = 0;
    this.bet = 1;
    this.combo = 0;
    this.tension = 0;
    this.past_fever_num = 0;
    this.money = this.money_init;
  }

  LoveliveGame.prototype.onload = function() {
    this.title_scene = new titleScene();
    this.main_scene = new mainScene();
    this.pause_scene = new pauseScene();
    if (this.test.test_exe_flg === true) {
      this.test_scene = new testScene();
      this.pushScene(this.test_scene);
      return this.test.testExe();
    } else {
      this.loadGame();
      if (this.debug.force_main_flg === true) {
        this.pushScene(this.main_scene);
        if (this.debug.force_pause_flg === true) {
          return this.pushScene(this.pause_scene);
        }
      } else {
        return this.pushScene(this.title_scene);
      }
    }
  };


  /*
  スロットにμ’ｓを挿入するときに必要なカットイン画像や音楽を予めロードしておく
   */

  LoveliveGame.prototype.musePreLoad = function() {
    var key, material, muse_num, val, _ref, _ref1;
    muse_num = this.slot_setting.now_muse_num;
    if (this.slot_setting.muse_material_list[muse_num] !== void 0) {
      material = this.slot_setting.muse_material_list[muse_num];
      _ref = material['cut_in'];
      for (key in _ref) {
        val = _ref[key];
        this.load('images/cut_in/' + val.name + '.png');
      }
      if (material['voice'].length > 0) {
        _ref1 = material['voice'];
        for (key in _ref1) {
          val = _ref1[key];
          this.load('sounds/voice/' + val + '.mp3');
        }
      }
      return this.load('sounds/bgm/' + material['bgm'][0]['name'] + '.mp3');
    }
  };


  /*
  テンションゲージを増減する
  @param number val 増減値
   */

  LoveliveGame.prototype.tensionSetValue = function(val) {
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
    return this.tensionSetValue(val);
  };


  /*
  アイテムを落とした時にテンションゲージを増減する
   */

  LoveliveGame.prototype.tensionSetValueItemFall = function() {
    var val;
    val = this.slot_setting.setTensionItemFall();
    return this.tensionSetValue(val);
  };


  /*
  はずれのアイテムを取った時にテンションゲージを増減する
   */

  LoveliveGame.prototype.tensionSetValueMissItemCatch = function() {
    var val;
    val = this.slot_setting.setTensionMissItem();
    return this.tensionSetValue(val);
  };


  /*
  スロットが当たった時にテンションゲージを増減する
  @param number prize_money 当選金額
  @param number hit_eye     当たった目の番号
   */

  LoveliveGame.prototype.tensionSetValueSlotHit = function(prize_money, hit_eye) {
    var val;
    val = this.slot_setting.setTensionSlotHit(prize_money, hit_eye);
    return this.tensionSetValue(val);
  };


  /*
  ポーズシーンをセットする
   */

  LoveliveGame.prototype.setPauseScene = function() {
    this.pause_scene.keyList.pause = true;
    return this.pushScene(this.pause_scene);
  };


  /*
  ポーズシーンをポップする
   */

  LoveliveGame.prototype.popPauseScene = function() {
    this.pause_scene.buttonList.pause = false;
    this.main_scene.keyList.pause = true;
    return this.popScene(this.pause_scene);
  };


  /*
  ゲームをロードする
   */

  LoveliveGame.prototype.loadGame = function() {
    if (this.debug.not_load_flg === false) {
      if (this.debug.test_load_flg === false) {
        this._loadGameProduct();
      } else {
        this._loadGameTest();
      }
      return this._gameInitSetting();
    }
  };


  /*
  ゲームをセーブする、ブラウザのローカルストレージへ
   */

  LoveliveGame.prototype.saveGame = function() {
    var key, saveData, val, _results;
    saveData = {
      'money': this.money,
      'bet': this.bet,
      'combo': this.combo,
      'tension': this.tension,
      'past_fever_num': this.past_fever_num,
      'prev_muse': JSON.stringify(this.slot_setting.prev_muse)
    };
    _results = [];
    for (key in saveData) {
      val = saveData[key];
      _results.push(this.local_storage.setItem(key, val));
    }
    return _results;
  };


  /*
  ゲームのロード本番用、ブラウザのローカルストレージから
   */

  LoveliveGame.prototype._loadGameProduct = function() {
    var money;
    money = this.local_storage.getItem('money');
    if (money !== null) {
      this.money = parseInt(money);
      this.bet = this._loadNumber('bet');
      this.combo = this._loadNumber('combo');
      this.tension = this._loadNumber('tension');
      this.past_fever_num = this._loadNumber('past_fever_num');
      return this.slot_setting.prev_muse = JSON.parse(this.local_storage.getItem('prev_muse'));
    }
  };


  /*
  ローカルストレージから指定のキーの値を取り出して数値に変換する
   */

  LoveliveGame.prototype._loadNumber = function(key) {
    var val;
    val = this.local_storage.getItem(key);
    return parseInt(val);
  };


  /*
  ゲームのロードテスト用、デバッグの決まった値
   */

  LoveliveGame.prototype._loadGameTest = function() {
    var data;
    data = this.debug.test_load_val;
    this.money = data.money;
    this.bet = data.bet;
    this.combo = data.combo;
    this.tension = data.tension;
    this.past_fever_num = data.past_fever_num;
    return this.slot_setting.prev_muse = data.prev_muse;
  };


  /*
  ゲームロード後の画面表示等の初期値設定
   */

  LoveliveGame.prototype._gameInitSetting = function() {
    var sys;
    sys = this.main_scene.gp_system;
    sys.money_text.setValue();
    sys.bet_text.setValue();
    sys.combo_text.setValue();
    return sys.tension_gauge.setValue();
  };

  return LoveliveGame;

})(catchAndSlotGame);

gpEffect = (function(_super) {
  __extends(gpEffect, _super);

  function gpEffect() {
    gpEffect.__super__.constructor.apply(this, arguments);
    this.chance_effect = new chanceEffect();
    this.fever_effect = new feverEffect();
    this.fever_overlay = new feverOverlay();
    this.kirakira_effect = [];
    this.kirakira_num = 40;
  }

  gpEffect.prototype.cutInSet = function() {
    var setting;
    setting = game.slot_setting;
    if (setting.muse_material_list[setting.now_muse_num] !== void 0) {
      this.cut_in = new cutIn();
      this.addChild(this.cut_in);
      return game.main_scene.gp_stage_front.missItemFallSycleNow = 0;
    }
  };

  gpEffect.prototype.chanceEffectSet = function() {
    this.addChild(this.chance_effect);
    return this.chance_effect.setInit();
  };

  gpEffect.prototype.feverEffectSet = function() {
    this.addChild(this.fever_effect);
    this.addChild(this.fever_overlay);
    this.fever_overlay.setInit();
    return this._setKirakiraEffect();
  };

  gpEffect.prototype.feverEffectEnd = function() {
    this.removeChild(this.fever_effect);
    this.removeChild(this.fever_overlay);
    return this._endKirakiraEffect();
  };

  gpEffect.prototype._setKirakiraEffect = function() {
    var i, _i, _ref, _results;
    _results = [];
    for (i = _i = 1, _ref = this.kirakira_num; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
      this.kirakira_effect.push(new kirakiraEffect());
      _results.push(this.addChild(this.kirakira_effect[i - 1]));
    }
    return _results;
  };

  gpEffect.prototype._endKirakiraEffect = function() {
    var i, _i, _ref, _results;
    _results = [];
    for (i = _i = 1, _ref = this.kirakira_num; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
      _results.push(this.removeChild(this.kirakira_effect[i - 1]));
    }
    return _results;
  };

  return gpEffect;

})(appGroup);

gpPanorama = (function(_super) {
  __extends(gpPanorama, _super);

  function gpPanorama() {
    gpPanorama.__super__.constructor.apply(this, arguments);
  }

  return gpPanorama;

})(appGroup);

gpBackPanorama = (function(_super) {
  __extends(gpBackPanorama, _super);

  function gpBackPanorama() {
    gpBackPanorama.__super__.constructor.apply(this, arguments);
    this.back_panorama = new BackPanorama();
    this.big_kotori = new bigKotori();
    this.now_back_effect_flg = false;
    this.back_effect_rate = 100;
    this.addChild(this.back_panorama);
  }


  /*
  背景レイヤーのエフェクト表示を開始
   */

  gpBackPanorama.prototype.setBackEffect = function() {
    var random;
    if (game.fever === false && this.now_back_effect_flg === false) {
      random = Math.floor(Math.random() * this.back_effect_rate);
      if (random === 1) {
        return this._setBigKotori();
      }
    }
  };


  /*
  進撃のことりを設置
   */

  gpBackPanorama.prototype._setBigKotori = function() {
    this.big_kotori.setInit();
    this.addChild(this.big_kotori);
    return this.now_back_effect_flg = true;
  };


  /*
  進撃のことりを終了
   */

  gpBackPanorama.prototype.endBigKotori = function() {
    this.removeChild(this.big_kotori);
    return this.now_back_effect_flg = false;
  };

  return gpBackPanorama;

})(gpPanorama);

gpFrontPanorama = (function(_super) {
  __extends(gpFrontPanorama, _super);

  function gpFrontPanorama() {
    gpFrontPanorama.__super__.constructor.apply(this, arguments);
    this.front_panorama = new FrontPanorama();
    this.addChild(this.front_panorama);
  }

  return gpFrontPanorama;

})(gpPanorama);

gpSlot = (function(_super) {
  __extends(gpSlot, _super);

  function gpSlot() {
    gpSlot.__super__.constructor.apply(this, arguments);
    this.underFrame = new UnderFrame();
    this.addChild(this.underFrame);
    this.lille_stop_se = game.soundload('dicision');
    this.slot_hit_se = game.soundload('start');
    this.fever_bgm = game.soundload('bgm/zenkai_no_lovelive');
    this.isStopping = false;
    this.stopIntervalFrame = 9;
    this.slotIntervalFrameRandom = 0;
    this.stopStartAge = 0;
    this.leftSlotEye = 0;
    this.feverSec = 0;
    this.hit_role = 0;
    this.isForceSlotHit = false;
    this.slotSet();
    this.debugSlot();
    this.upperFrame = new UpperFrame();
    this.addChild(this.upperFrame);
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
        this.forceHitStart();
        game.sePlay(this.lille_stop_se);
        this.left_lille.isRotation = false;
        this.saveLeftSlotEye();
        this.setIntervalFrame();
      }
      if (this.age === this.stopStartAge + this.stopIntervalFrame + this.slotIntervalFrameRandom) {
        game.sePlay(this.lille_stop_se);
        this.middle_lille.isRotation = false;
        this.forceHit(this.middle_lille);
        this.setIntervalFrame();
      }
      if (this.age === this.stopStartAge + this.stopIntervalFrame * 2 + this.slotIntervalFrameRandom) {
        game.sePlay(this.lille_stop_se);
        this.right_lille.isRotation = false;
        this.forceHit(this.right_lille);
        this.forceHitEnd();
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

  gpSlot.prototype.forceHitStart = function() {
    if (game.slot_setting.isForceSlotHit === true) {
      return this.isForceSlotHit = true;
    }
  };

  gpSlot.prototype.forceHitEnd = function() {
    return this.isForceSlotHit = false;
  };


  /*
  確率でスロットを強制的に当たりにする
   */

  gpSlot.prototype.forceHit = function(target) {
    var tmp_eye;
    if (this.isForceSlotHit === true) {
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
  スロットの当選判定をして当たった時の処理を流す
   */

  gpSlot.prototype.slotHitTest = function() {
    var member, prize_money;
    if (this._isSlotHit() === true) {
      game.sePlay(this.slot_hit_se);
      this.hit_role = this.left_lille.lilleArray[this.left_lille.nowEye];
      prize_money = game.slot_setting.calcPrizeMoney(this.middle_lille.lilleArray[this.middle_lille.nowEye]);
      game.tensionSetValueSlotHit(prize_money, this.hit_role);
      this._feverStart(this.hit_role);
      if (this.hit_role === 1) {
        member = game.slot_setting.now_muse_num;
        this.slotAddMuse(member);
      } else {
        game.main_scene.gp_stage_back.fallPrizeMoneyStart(prize_money);
      }
      if (game.slot_setting.isForceSlotHit === true) {
        return this.endForceSlotHit();
      }
    }
  };


  /*
  スロットの当選判定をする
  true:３つとも全て同じ目、または、３つとも全てμ’s
   */

  gpSlot.prototype._isSlotHit = function() {
    var hit_flg, left, middle, right;
    left = this.left_lille.lilleArray[this.left_lille.nowEye];
    middle = this.middle_lille.lilleArray[this.middle_lille.nowEye];
    right = this.right_lille.lilleArray[this.right_lille.nowEye];
    hit_flg = false;
    if ((left === middle && middle === right)) {
      hit_flg = true;
      this.hit_role = left;
    } else if (left > 10 && middle > 10 && right > 10) {
      hit_flg = true;
      this.hit_role = game.slot_setting.getHitRole(left, middle, right);
    }
    return hit_flg;
  };


  /*
  フィーバーを開始する
   */

  gpSlot.prototype._feverStart = function(hit_eye) {
    if (hit_eye > 10 && game.fever === false) {
      game.fever = true;
      game.past_fever_num += 1;
      game.slot_setting.setMuseMember();
      game.musePreLoad();
      game.fever_hit_eye = hit_eye;
      game.main_scene.gp_system.changeBetChangeFlg(false);
      game.main_scene.gp_effect.feverEffectSet();
      this.slotAddMuseAll(hit_eye);
      return this._feverBgmStart(hit_eye);
    }
  };


  /*
  フィーバー中のBGMを開始する
   */

  gpSlot.prototype._feverBgmStart = function(hit_eye) {
    var bgm;
    bgm = this._getFeverBgm(hit_eye);
    this.feverSec = bgm['time'];
    this.fever_bgm = game.soundload('bgm/' + bgm['name']);
    game.fever_down_tension = Math.round(game.slot_setting.tension_max * 100 / (this.feverSec * game.fps)) / 100;
    game.fever_down_tension *= -1;
    return game.bgmPlay(this.fever_bgm, false);
  };


  /*
  揃った目の役からフィーバーのBGMを返す
   */

  gpSlot.prototype._getFeverBgm = function(hit_role) {
    var bgms, material, random;
    if (hit_role <= 19) {
      material = game.slot_setting.muse_material_list;
    } else {
      material = game.slot_setting.unit_material_list;
    }
    if (material[hit_role] === void 0) {
      hit_role = 20;
    }
    bgms = material[hit_role]['bgm'];
    random = Math.floor(Math.random() * bgms.length);
    return bgms[random];
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
    var arr, arr_key, arr_val, key, return_arr, val, _ref;
    arr = [];
    return_arr = [];
    return_arr = game.arrayCopy(change);
    if (isMuseDel === false) {
      _ref = target.lilleArray;
      for (key in _ref) {
        val = _ref[key];
        if (val > 10) {
          arr.push(key);
        }
      }
      if (arr.length > 0) {
        for (arr_key in arr) {
          arr_val = arr[arr_key];
          return_arr[arr_val] = target.lilleArray[arr_val];
        }
      }
    }
    return return_arr;
  };


  /*
  リールの音ノ木坂学院校章のどこかにμ’sの誰かを挿入
  スロットが音ノ木坂学院校章で止まったときに実行
  @param number num メンバーの指定
   */

  gpSlot.prototype.slotAddMuse = function(num) {
    this.left_lille.lilleArray = this._slotAddMuseUnit(num, this.left_lille);
    this.middle_lille.lilleArray = this._slotAddMuseUnit(num, this.middle_lille);
    this.right_lille.lilleArray = this._slotAddMuseUnit(num, this.right_lille);
    return game.main_scene.gp_effect.cutInSet();
  };


  /*
  リールにμ’sの誰かを挿入(単体)
  @param number num   メンバーの指定
  @param array  lille リール
   */

  gpSlot.prototype._slotAddMuseUnit = function(num, lille) {
    var add_num, arr, key, random_key, val, _ref;
    arr = [];
    _ref = lille.lilleArray;
    for (key in _ref) {
      val = _ref[key];
      if (val === 1) {
        arr.push(key);
      }
    }
    if (arr.length > 0) {
      random_key = Math.floor(arr.length * Math.random());
      add_num = arr[random_key];
      lille.lilleArray[add_num] = num;
    }
    return lille.lilleArray;
  };


  /*
  リールの音ノ木坂学院校章の全てにμ’sの誰かを挿入
  フィーバー開始時に実行
  @param number num メンバーの指定
   */

  gpSlot.prototype.slotAddMuseAll = function(num) {
    this.left_lille.lilleArray = this._slotAddMuseAllUnit(num, this.left_lille);
    this.middle_lille.lilleArray = this._slotAddMuseAllUnit(num, this.middle_lille);
    return this.right_lille.lilleArray = this._slotAddMuseAllUnit(num, this.right_lille);
  };

  gpSlot.prototype._slotAddMuseAllUnit = function(num, lille) {
    var key, val, _ref;
    _ref = lille.lilleArray;
    for (key in _ref) {
      val = _ref[key];
      if (val === 1) {
        lille.lilleArray[key] = num;
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
      this.left_lille.lilleArray = game.arrayCopy(game.debug.lille_array[0]);
      this.middle_lille.lilleArray = game.arrayCopy(game.debug.lille_array[1]);
      return this.right_lille.lilleArray = game.arrayCopy(game.debug.lille_array[2]);
    }
  };


  /*
  スロットの強制当たりを開始する
   */

  gpSlot.prototype.startForceSlotHit = function() {
    this.upperFrame.frame = 1;
    game.main_scene.gp_system.changeBetChangeFlg(false);
    if (game.fever === false) {
      return game.main_scene.gp_effect.chanceEffectSet();
    }
  };


  /*
  スロットの強制当たりを終了する
   */

  gpSlot.prototype.endForceSlotHit = function() {
    if (game.fever === false && game.slot_setting.isForceSlotHit === true) {
      this.upperFrame.frame = 0;
      game.main_scene.gp_system.changeBetChangeFlg(true);
      return game.slot_setting.isForceSlotHit = false;
    }
  };

  return gpSlot;

})(appGroup);

gpStage = (function(_super) {
  __extends(gpStage, _super);

  function gpStage() {
    gpStage.__super__.constructor.apply(this, arguments);
    this.floor = 640;
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
      game.main_scene.gp_back_panorama.setBackEffect();
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
      game.main_scene.gp_slot.slotStart();
      if (game.slot_setting.getIsForceSlotHit() === true) {
        return game.main_scene.gp_slot.startForceSlotHit();
      } else {
        return game.main_scene.gp_slot.endForceSlotHit();
      }
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
    this.paermit_bet_change_flg = true;
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
    this.pause_button = new pauseButton();
    this.addChild(this.pause_button);
    this.item_slot = new ItemSlot();
    this.addChild(this.item_slot);
    this.item_gauge_back = new ItemGaugeBack();
    this.addChild(this.item_gauge_back);
    this.item_gauge = new ItemGauge();
    this.addChild(this.item_gauge);
    this.left_button = new leftButton();
    this.addChild(this.left_button);
    this.right_button = new rightButton();
    this.addChild(this.right_button);
    this.jump_button = new jumpButton();
    this.addChild(this.jump_button);
    this.heigh_bet_button = new heighBetButton();
    this.addChild(this.heigh_bet_button);
    this.low_bet_button = new lowBetButton();
    this.addChild(this.low_bet_button);
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
  TODO スロットの当選金額落下中は変更できないようにする
   */

  gpSystem.prototype._betSetting = function() {
    if (this.paermit_bet_change_flg === true) {
      if (game.main_scene.keyList['up'] === true) {
        if (this.keyList['up'] === false) {
          this._getBetSettingValue(true);
          this.keyList['up'] = true;
        }
      } else {
        if (this.keyList['up'] === true) {
          this.keyList['up'] = false;
        }
      }
      if (game.main_scene.keyList['down'] === true) {
        if (this.keyList['down'] === false) {
          this._getBetSettingValue(false);
          return this.keyList['down'] = true;
        }
      } else {
        if (this.keyList['down'] === true) {
          return this.keyList['down'] = false;
        }
      }
    }
  };


  /*
  掛け金の変更
   */

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


  /*
  掛け金の変更が可能かを変更する
  @param boolean flg true:変更可能、false:変更不可能
   */

  gpSystem.prototype.changeBetChangeFlg = function(flg) {
    if (flg === true) {
      this.heigh_bet_button.opacity = 1;
      this.low_bet_button.opacity = 1;
      return this.paermit_bet_change_flg = true;
    } else {
      this.heigh_bet_button.opacity = 0;
      this.low_bet_button.opacity = 0;
      return this.paermit_bet_change_flg = false;
    }
  };

  return gpSystem;

})(appGroup);

systemHtml = (function(_super) {
  __extends(systemHtml, _super);

  function systemHtml(width, height) {
    systemHtml.__super__.constructor.call(this, width, height);
    this["class"] = [];
    this.text = '';
    this.is_button = true;
  }

  systemHtml.prototype.setHtml = function() {
    var tmp_cls, val, _i, _len, _ref;
    tmp_cls = '';
    _ref = this["class"];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      val = _ref[_i];
      tmp_cls += val + ' ';
    }
    return this._element.innerHTML = '<div class="' + tmp_cls + '">' + this.text + '</div>';
  };

  systemHtml.prototype.setImageHtml = function() {
    var tmp_class;
    tmp_class = '';
    if (this.is_button === true) {
      tmp_class = 'image-button';
    }
    return this._element.innerHTML = '<img src="images/html/' + this.image_name + '.png" class="' + tmp_class + '"></img>';
  };

  return systemHtml;

})(appHtml);

buttonHtml = (function(_super) {
  __extends(buttonHtml, _super);

  function buttonHtml(width, height) {
    buttonHtml.__super__.constructor.call(this, width, height);
    this["class"] = ['base-button'];
  }

  buttonHtml.prototype.touchendEvent = function() {};

  return buttonHtml;

})(systemHtml);


/*
ポーズメニューのボタン
 */

pauseMainMenuButtonHtml = (function(_super) {
  __extends(pauseMainMenuButtonHtml, _super);

  function pauseMainMenuButtonHtml() {
    pauseMainMenuButtonHtml.__super__.constructor.call(this, 300, 45);
    this.x = 90;
    this.y = 0;
    this["class"].push('pause-main-menu-button');
  }

  pauseMainMenuButtonHtml.prototype.ontouchend = function(e) {
    return this.touchendEvent();
  };

  return pauseMainMenuButtonHtml;

})(buttonHtml);


/*
ゲームへ戻る
 */

returnGameButtonHtml = (function(_super) {
  __extends(returnGameButtonHtml, _super);

  function returnGameButtonHtml() {
    returnGameButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 100;
    this.text = 'ゲームに戻る';
    this.setHtml();
  }

  returnGameButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.buttonList.pause = true;
  };

  return returnGameButtonHtml;

})(pauseMainMenuButtonHtml);


/*
ゲームを保存する
 */

saveGameButtonHtml = (function(_super) {
  __extends(saveGameButtonHtml, _super);

  function saveGameButtonHtml() {
    saveGameButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 200;
    this.text = 'ゲームを保存する';
    this.setHtml();
  }

  saveGameButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.setSaveMenu();
  };

  return saveGameButtonHtml;

})(pauseMainMenuButtonHtml);

buyItemButtonHtml = (function(_super) {
  __extends(buyItemButtonHtml, _super);

  function buyItemButtonHtml() {
    buyItemButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 300;
    this.text = 'アイテム・部員を買う';
    this.setHtml();
  }

  buyItemButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.setItemBuyMenu();
  };

  return buyItemButtonHtml;

})(pauseMainMenuButtonHtml);

useItemButtonHtml = (function(_super) {
  __extends(useItemButtonHtml, _super);

  function useItemButtonHtml() {
    useItemButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 400;
    this.text = 'アイテムを使う';
    this.setHtml();
  }

  useItemButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.setItemUseMenu();
  };

  return useItemButtonHtml;

})(pauseMainMenuButtonHtml);

setMemberButtonHtml = (function(_super) {
  __extends(setMemberButtonHtml, _super);

  function setMemberButtonHtml() {
    setMemberButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 500;
    this.text = '部員を編成する';
    this.setHtml();
  }

  setMemberButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.setMemberSetMenu();
  };

  return setMemberButtonHtml;

})(pauseMainMenuButtonHtml);


/*
OKボタン
 */

baseOkButtonHtml = (function(_super) {
  __extends(baseOkButtonHtml, _super);

  function baseOkButtonHtml() {
    baseOkButtonHtml.__super__.constructor.call(this, 150, 45);
    this["class"].push('base-ok-button');
    this.text = 'ＯＫ';
    this.setHtml();
  }

  baseOkButtonHtml.prototype.ontouchend = function(e) {
    return this.touchendEvent();
  };

  return baseOkButtonHtml;

})(buttonHtml);


/*
セーブのOKボタン
 */

saveOkButtonHtml = (function(_super) {
  __extends(saveOkButtonHtml, _super);

  function saveOkButtonHtml() {
    saveOkButtonHtml.__super__.constructor.apply(this, arguments);
    this.x = 170;
    this.y = 380;
  }

  saveOkButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeSaveMenu();
  };

  return saveOkButtonHtml;

})(baseOkButtonHtml);


/*
キャンセルボタン
 */

baseCancelButtonHtml = (function(_super) {
  __extends(baseCancelButtonHtml, _super);

  function baseCancelButtonHtml() {
    baseCancelButtonHtml.__super__.constructor.call(this, 150, 45);
    this["class"].push('base-cancel-button');
    this.text = 'キャンセル';
    this.setHtml();
  }

  baseCancelButtonHtml.prototype.ontouchend = function(e) {
    return this.touchendEvent();
  };

  return baseCancelButtonHtml;

})(buttonHtml);


/*
アイテム購入のキャンセルボタン
 */

itemBuyCancelButtonHtml = (function(_super) {
  __extends(itemBuyCancelButtonHtml, _super);

  function itemBuyCancelButtonHtml() {
    itemBuyCancelButtonHtml.__super__.constructor.apply(this, arguments);
    this.x = 170;
    this.y = 500;
  }

  itemBuyCancelButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeItemBuySelectMenu();
  };

  return itemBuyCancelButtonHtml;

})(baseCancelButtonHtml);


/*
タイトルメニューのボタン
 */

titleMenuButtonHtml = (function(_super) {
  __extends(titleMenuButtonHtml, _super);

  function titleMenuButtonHtml() {
    titleMenuButtonHtml.__super__.constructor.call(this, 200, 45);
    this.x = 140;
    this.y = 0;
    this["class"].push('title-menu-button');
  }

  titleMenuButtonHtml.prototype.ontouchend = function(e) {
    return this.touchendEvent();
  };

  return titleMenuButtonHtml;

})(buttonHtml);


/*
ゲーム開始ボタン
 */

startGameButtonHtml = (function(_super) {
  __extends(startGameButtonHtml, _super);

  function startGameButtonHtml() {
    startGameButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 350;
    this.text = 'ゲーム開始';
    this.setHtml();
  }

  startGameButtonHtml.prototype.touchendEvent = function() {
    return game.replaceScene(game.main_scene);
  };

  return startGameButtonHtml;

})(titleMenuButtonHtml);


/*
ダイアログを閉じるボタン
 */

dialogCloseButton = (function(_super) {
  __extends(dialogCloseButton, _super);

  function dialogCloseButton() {
    dialogCloseButton.__super__.constructor.call(this, 30, 30);
    this.image_name = 'close';
    this.x = 400;
    this.y = 100;
    this.setImageHtml();
  }

  return dialogCloseButton;

})(systemHtml);

itemBuyDialogCloseButton = (function(_super) {
  __extends(itemBuyDialogCloseButton, _super);

  function itemBuyDialogCloseButton() {
    itemBuyDialogCloseButton.__super__.constructor.apply(this, arguments);
  }

  itemBuyDialogCloseButton.prototype.ontouchend = function() {
    return game.pause_scene.removeItemBuyMenu();
  };

  return itemBuyDialogCloseButton;

})(dialogCloseButton);

itemUseDialogCloseButton = (function(_super) {
  __extends(itemUseDialogCloseButton, _super);

  function itemUseDialogCloseButton() {
    itemUseDialogCloseButton.__super__.constructor.apply(this, arguments);
  }

  itemUseDialogCloseButton.prototype.ontouchend = function() {
    return game.pause_scene.removeItemUseMenu();
  };

  return itemUseDialogCloseButton;

})(dialogCloseButton);

memberSetDialogCloseButton = (function(_super) {
  __extends(memberSetDialogCloseButton, _super);

  function memberSetDialogCloseButton() {
    memberSetDialogCloseButton.__super__.constructor.apply(this, arguments);
  }

  memberSetDialogCloseButton.prototype.ontouchend = function() {
    return game.pause_scene.removeMemberSetMenu();
  };

  return memberSetDialogCloseButton;

})(dialogCloseButton);

dialogHtml = (function(_super) {
  __extends(dialogHtml, _super);

  function dialogHtml(width, height) {
    dialogHtml.__super__.constructor.call(this, width, height);
  }

  return dialogHtml;

})(systemHtml);

modal = (function(_super) {
  __extends(modal, _super);

  function modal() {
    modal.__super__.constructor.call(this, game.width, game.height);
    this["class"] = ['modal'];
    this.text = '　';
    this.setHtml();
  }

  return modal;

})(dialogHtml);

baseDialogHtml = (function(_super) {
  __extends(baseDialogHtml, _super);

  function baseDialogHtml(width, height) {
    baseDialogHtml.__super__.constructor.call(this, width, height);
    this["class"] = ['base-dialog'];
  }

  return baseDialogHtml;

})(dialogHtml);

saveDialogHtml = (function(_super) {
  __extends(saveDialogHtml, _super);

  function saveDialogHtml() {
    saveDialogHtml.__super__.constructor.call(this, 375, 375);
    this.text = '保存しました。';
    this["class"].push('base-dialog-save');
    this.x = 60;
    this.y = 150;
    this.setHtml();
  }

  return saveDialogHtml;

})(baseDialogHtml);

menuDialogHtml = (function(_super) {
  __extends(menuDialogHtml, _super);

  function menuDialogHtml() {
    menuDialogHtml.__super__.constructor.call(this, 420, 460);
    this.text = '　';
    this["class"].push('base-dialog-menu');
    this.x = 25;
    this.y = 80;
    this.setHtml();
  }

  return menuDialogHtml;

})(baseDialogHtml);

itemBuyDialogHtml = (function(_super) {
  __extends(itemBuyDialogHtml, _super);

  function itemBuyDialogHtml() {
    itemBuyDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return itemBuyDialogHtml;

})(menuDialogHtml);

itemUseDialogHtml = (function(_super) {
  __extends(itemUseDialogHtml, _super);

  function itemUseDialogHtml() {
    itemUseDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return itemUseDialogHtml;

})(menuDialogHtml);

memberSetDialogHtml = (function(_super) {
  __extends(memberSetDialogHtml, _super);

  function memberSetDialogHtml() {
    memberSetDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return memberSetDialogHtml;

})(menuDialogHtml);

selectDialogHtml = (function(_super) {
  __extends(selectDialogHtml, _super);

  function selectDialogHtml() {
    selectDialogHtml.__super__.constructor.call(this, 300, 400);
    this.text = '　';
    this["class"].push('base-dialog-select');
    this.x = 35;
    this.y = 150;
    this.setHtml();
  }

  return selectDialogHtml;

})(baseDialogHtml);

itemBuySelectDialogHtml = (function(_super) {
  __extends(itemBuySelectDialogHtml, _super);

  function itemBuySelectDialogHtml() {
    itemBuySelectDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return itemBuySelectDialogHtml;

})(selectDialogHtml);

discriptionTextDialogHtml = (function(_super) {
  __extends(discriptionTextDialogHtml, _super);

  function discriptionTextDialogHtml(w, h) {
    discriptionTextDialogHtml.__super__.constructor.call(this, w, h);
    this["class"].push('base-discription');
  }

  return discriptionTextDialogHtml;

})(dialogHtml);

titleDiscription = (function(_super) {
  __extends(titleDiscription, _super);

  function titleDiscription() {
    titleDiscription.__super__.constructor.call(this, 200, 20);
    this["class"].push('title-discription');
  }

  return titleDiscription;

})(discriptionTextDialogHtml);

itemItemBuyDiscription = (function(_super) {
  __extends(itemItemBuyDiscription, _super);

  function itemItemBuyDiscription() {
    itemItemBuyDiscription.__super__.constructor.apply(this, arguments);
    this.x = 190;
    this.y = 130;
    this.text = 'アイテム';
    this.setHtml();
  }

  return itemItemBuyDiscription;

})(titleDiscription);

memberItemBuyDiscription = (function(_super) {
  __extends(memberItemBuyDiscription, _super);

  function memberItemBuyDiscription() {
    memberItemBuyDiscription.__super__.constructor.apply(this, arguments);
    this.x = 220;
    this.y = 370;
    this.text = '部員';
    this.setHtml();
  }

  return memberItemBuyDiscription;

})(titleDiscription);

itemNameDiscription = (function(_super) {
  __extends(itemNameDiscription, _super);

  function itemNameDiscription() {
    itemNameDiscription.__super__.constructor.apply(this, arguments);
    this.x = 180;
    this.y = 290;
  }

  itemNameDiscription.prototype.setText = function(text) {
    this.text = text;
    return this.setHtml();
  };

  return itemNameDiscription;

})(titleDiscription);

itemDiscription = (function(_super) {
  __extends(itemDiscription, _super);

  function itemDiscription() {
    itemDiscription.__super__.constructor.call(this, 400, 190);
    this.x = 60;
    this.y = 340;
  }

  itemDiscription.prototype.setText = function(text) {
    this.text = text;
    return this.setHtml();
  };

  return itemDiscription;

})(discriptionTextDialogHtml);

imageHtml = (function(_super) {
  __extends(imageHtml, _super);

  function imageHtml(width, height) {
    imageHtml.__super__.constructor.call(this, width, height);
  }

  return imageHtml;

})(systemHtml);


/*
アイテム画像のベース
@param kind 種別
 */

baseItemHtml = (function(_super) {
  __extends(baseItemHtml, _super);

  function baseItemHtml(kind) {
    baseItemHtml.__super__.constructor.call(this, 100, 100);
    this.image_name = 'test_image';
    this.setImageHtml();
    this.item_kind = kind;
    this.scaleX = 0.7;
    this.scaleY = 0.7;
    this.positionY = 0;
    this.positoin_kind = this.item_kind;
  }

  baseItemHtml.prototype.setPosition = function() {
    if (this.positoin_kind <= 4) {
      this.y = this.positionY;
      return this.x = 80 * (this.positoin_kind - 1) + 70;
    } else {
      this.y = this.positionY + 80;
      return this.x = 80 * (this.positoin_kind - 5) + 30;
    }
  };

  baseItemHtml.prototype.dispItemBuySelectDialog = function(kind) {
    return game.pause_scene.setItemBuySelectMenu(kind);
  };

  return baseItemHtml;

})(systemHtml);


/*
アイテム
 */

itemHtml = (function(_super) {
  __extends(itemHtml, _super);

  function itemHtml(kind) {
    itemHtml.__super__.constructor.call(this, kind);
  }

  return itemHtml;

})(baseItemHtml);

buyItemHtml = (function(_super) {
  __extends(buyItemHtml, _super);

  function buyItemHtml(kind) {
    buyItemHtml.__super__.constructor.call(this, kind);
    this.positionY = 160;
  }

  buyItemHtml.prototype.ontouchend = function() {
    return this.dispItemBuySelectDialog(this.item_kind);
  };

  return buyItemHtml;

})(itemHtml);

useItemHtml = (function(_super) {
  __extends(useItemHtml, _super);

  function useItemHtml(kind) {
    useItemHtml.__super__.constructor.call(this, kind);
  }

  return useItemHtml;

})(itemHtml);


/*
部員
 */

memberHtml = (function(_super) {
  __extends(memberHtml, _super);

  function memberHtml(kind) {
    memberHtml.__super__.constructor.call(this, kind);
    this.positoin_kind = this.item_kind - 10;
  }

  return memberHtml;

})(baseItemHtml);

buyMemberHtml = (function(_super) {
  __extends(buyMemberHtml, _super);

  function buyMemberHtml(kind) {
    buyMemberHtml.__super__.constructor.call(this, kind);
    this.positionY = 400;
  }

  buyMemberHtml.prototype.ontouchend = function() {
    return this.dispItemBuySelectDialog(this.item_kind);
  };

  return buyMemberHtml;

})(memberHtml);

useMemberHtml = (function(_super) {
  __extends(useMemberHtml, _super);

  function useMemberHtml(kind) {
    useMemberHtml.__super__.constructor.call(this, kind);
  }

  return useMemberHtml;

})(memberHtml);

selectItemImage = (function(_super) {
  __extends(selectItemImage, _super);

  function selectItemImage() {
    selectItemImage.__super__.constructor.call(this, 100, 100);
    this.x = 200;
    this.y = 180;
  }

  selectItemImage.prototype.setImage = function(image) {
    this.image_name = image;
    return this.setImageHtml();
  };

  return selectItemImage;

})(imageHtml);

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
    this.font_size = 22;
    this.font = this.font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 0;
    this.y = 7;
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
    return this.x = game.width - this._boundWidth - 7;
  };

  return moneyText;

})(text);

betText = (function(_super) {
  __extends(betText, _super);

  function betText() {
    betText.__super__.constructor.apply(this, arguments);
    this.text = 0;
    this.color = 'black';
    this.font_size = 22;
    this.font = this.font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 37;
    this.y = 7;
    this.kakekin_text = '掛金';
    this.yen_text = '円';
    this.text = this.kakekin_text + game.bet + this.yen_text;
  }

  betText.prototype.setValue = function() {
    this.text = this.kakekin_text + game.bet + this.yen_text;
    return game.main_scene.gp_system.low_bet_button.setXposition();
  };

  return betText;

})(text);

comboText = (function(_super) {
  __extends(comboText, _super);

  function comboText() {
    comboText.__super__.constructor.apply(this, arguments);
    this.text = 0;
    this.color = 'black';
    this.font_size = 37;
    this.font = this.font_size + "px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 195;
    this.y = 75;
  }

  comboText.prototype.setValue = function() {
    this.text = game.combo;
    return this.setXposition();
  };

  comboText.prototype.setXposition = function() {
    var unit;
    unit = game.main_scene.gp_system.combo_unit_text;
    this.x = game.width / 2 - (this._boundWidth + unit._boundWidth + 5) / 2;
    return unit.x = this.x + this._boundWidth + 5;
  };

  return comboText;

})(text);

comboUnitText = (function(_super) {
  __extends(comboUnitText, _super);

  function comboUnitText() {
    comboUnitText.__super__.constructor.apply(this, arguments);
    this.text = 'combo';
    this.color = 'black';
    this.font = "22px 'Consolas', 'Monaco', 'ＭＳ ゴシック'";
    this.x = 217;
    this.y = 90;
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
    this.force_main_flg = false;
    this.force_pause_flg = true;
    this.not_load_flg = false;
    this.test_load_flg = false;
    this.test_load_val = {
      'money': 1000,
      'bet': 10,
      'combo': 10,
      'tension': 100,
      'past_fever_num': 0,
      'prev_muse': []
    };
    this.lille_flg = false;
    this.lille_array = [[1, 1, 1], [1, 1, 1], [1, 1, 1]];
    this.item_flg = false;
    this.item_fall_early_flg = false;
    this.fix_tention_item_catch_flg = false;
    this.fix_tention_item_fall_flg = false;
    this.fix_tention_slot_hit_flg = false;
    this.force_insert_muse = false;
    this.force_slot_hit = false;
    this.half_slot_hit = false;
    this.fix_tention_item_catch_val = 50;
    this.fix_tention_item_fall_val = 0;
    this.fix_tention_slot_hit_flg = 200;
    if (this.force_pause_flg === true) {
      this.force_main_flg = true;
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
    this.lille_array_0 = [[1, 2, 1, 2, 1, 3, 5, 1, 2, 3, 5, 1, 2, 1, 3, 4, 1, 2, 1, 4], [2, 4, 1, 1, 3, 2, 4, 1, 3, 2, 5, 1, 3, 2, 4, 1, 3, 1, 5, 1], [1, 5, 2, 3, 1, 4, 1, 3, 1, 4, 5, 2, 3, 1, 4, 2, 3, 1, 2, 1]];
    this.lille_array_1 = [[1, 3, 1, 3, 1, 2, 5, 1, 3, 2, 5, 1, 3, 1, 2, 4, 1, 3, 1, 4], [3, 4, 1, 1, 2, 3, 4, 1, 2, 3, 5, 1, 2, 3, 4, 1, 2, 1, 5, 1], [1, 5, 3, 2, 1, 4, 1, 2, 1, 4, 5, 3, 2, 1, 4, 3, 2, 1, 3, 1]];
    this.lille_array_2 = [[1, 4, 1, 4, 1, 2, 5, 1, 4, 2, 5, 1, 4, 1, 2, 3, 1, 4, 1, 3], [4, 3, 1, 1, 2, 4, 3, 1, 2, 4, 5, 1, 2, 4, 3, 1, 2, 1, 5, 1], [1, 5, 4, 2, 1, 3, 1, 2, 1, 3, 5, 4, 2, 1, 3, 4, 2, 1, 4, 1]];
    this.bairitu = {
      1: 10,
      2: 20,
      3: 30,
      4: 40,
      5: 50,
      11: 50,
      12: 50,
      13: 50,
      14: 50,
      15: 50,
      16: 50,
      17: 50,
      18: 50,
      19: 50
    };

    /*
    カットインやフィーバー時の音楽などに使うμ’ｓの素材リスト
    11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
    direction:キャラクターの向き、left or right
    カットインの画像サイズ、頭の位置で570px
    頭の上に余白がある場合の高さ計算式：(570/(元画像高さ-元画像頭のY座標))*元画像高さ
     */
    this.muse_material_list = {
      11: {
        'cut_in': [
          {
            'name': '11_0',
            'width': 360,
            'height': 570,
            'direction': 'left'
          }, {
            'name': '11_1',
            'width': 730,
            'height': 662,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': 'yumenaki',
            'time': 107
          }
        ],
        'voice': ['11_0', '11_1']
      },
      12: {
        'cut_in': [
          {
            'name': '12_0',
            'width': 510,
            'height': 728,
            'direction': 'left'
          }, {
            'name': '12_1',
            'width': 640,
            'height': 648,
            'direction': 'right'
          }
        ],
        'bgm': [
          {
            'name': 'blueberry',
            'time': 98
          }
        ],
        'voice': ['12_0', '12_1']
      },
      13: {
        'cut_in': [
          {
            'name': '13_0',
            'width': 570,
            'height': 634,
            'direction': 'left'
          }, {
            'name': '13_1',
            'width': 408,
            'height': 570,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': 'reason',
            'time': 94
          }
        ],
        'voice': ['13_0', '13_1']
      },
      14: {
        'cut_in': [
          {
            'name': '14_0',
            'width': 476,
            'height': 648,
            'direction': 'left'
          }, {
            'name': '14_1',
            'width': 650,
            'height': 570,
            'direction': 'right'
          }
        ],
        'bgm': [
          {
            'name': 'daring',
            'time': 91
          }
        ],
        'voice': ['14_0', '14_1']
      },
      15: {
        'cut_in': [
          {
            'name': '15_0',
            'width': 502,
            'height': 570,
            'direction': 'right'
          }, {
            'name': '15_1',
            'width': 601,
            'height': 638,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': 'rinrinrin',
            'time': 128
          }
        ],
        'voice': ['15_0', '15_1']
      },
      16: {
        'cut_in': [
          {
            'name': '16_0',
            'width': 438,
            'height': 570,
            'direction': 'right'
          }, {
            'name': '16_1',
            'width': 580,
            'height': 644,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': 'nawatobi',
            'time': 164
          }
        ],
        'voice': ['16_0', '16_1']
      },
      17: {
        'cut_in': [
          {
            'name': '17_0',
            'width': 465,
            'height': 705,
            'direction': 'left'
          }, {
            'name': '17_1',
            'width': 361,
            'height': 570,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': 'mahoutukai',
            'time': 105
          }
        ],
        'voice': ['17_0', '17_1']
      },
      18: {
        'cut_in': [
          {
            'name': '18_0',
            'width': 599,
            'height': 606,
            'direction': 'right'
          }, {
            'name': '18_1',
            'width': 380,
            'height': 675,
            'direction': 'left'
          }
        ],
        'bgm': [
          {
            'name': 'junai',
            'time': 127
          }
        ],
        'voice': ['18_0', '18_1']
      },
      19: {
        'cut_in': [
          {
            'name': '19_0',
            'width': 460,
            'height': 570,
            'direction': 'left'
          }, {
            'name': '19_1',
            'width': 670,
            'height': 650,
            'direction': 'right'
          }
        ],
        'bgm': [
          {
            'name': 'arihureta',
            'time': 93
          }
        ],
        'voice': ['19_0', '19_1']
      }
    };

    /*
    ユニットに関する素材
    20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:のぞえり、32:ほのりん、33:ことぱな、34:にこまき
     */
    this.unit_material_list = {
      20: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30
          }
        ]
      }
    };

    /*
    アイテムのリスト
     */
    this.item_list = {
      0: {
        'name': 'アイテム',
        'image': 'test_image',
        'discription': 'アイテムの説明',
        'price': 100,
        'durationSec': 30,
        'conditoin': '出現条件',
        'condFunc': function() {
          return true;
        }
      },
      1: {
        'name': 'ほげほげ',
        'image': 'test_image',
        'discription': 'ほげほげするよ<br>　ほげほげがほげほげになるよ',
        'price': 1000000000,
        'durationSec': 2,
        'conditoin': '絶対でないよ',
        'condFunc': function() {
          return false;
        }
      },
      11: {
        'name': '高坂穂乃果',
        'image': 'test_image',
        'discription': '部員に穂乃果を追加<br>　できるようになる',
        'price': 0,
        'conditoin': '穂乃果でスロットを3つ揃える',
        'condFunc': function() {
          return false;
        }
      }
    };
    this.tension_max = 500;
    this.now_muse_num = 0;
    this.isForceSlotHit = false;
    this.slotHitRate = 0;
    this.prev_muse = [];
  }


  /*
  落下アイテムの加速度
  掛け金が多いほど速くする、10000円で速すぎて取れないレベルまで上げる
   */

  slotSetting.prototype.setGravity = function() {
    var div, val;
    if (game.bet < 10) {
      val = 0.4;
    } else if (game.bet < 50) {
      val = 0.45;
    } else if (game.bet < 100) {
      val = 0.5;
    } else if (game.bet < 500) {
      val = 0.55;
    } else if (game.bet < 1000) {
      val = 0.6;
    } else if (game.bet < 10000) {
      val = 0.6 + Math.floor(game.bet / 100) / 100;
    } else if (game.bet < 100000) {
      val = 1.5 + Math.floor(game.bet / 1000) / 100;
    } else {
      val = 3;
    }
    div = 1 + Math.floor(2 * game.tension / this.tension_max) / 10;
    val = Math.floor(val * div * 100) / 100;
    if (100 < game.combo) {
      div = Math.floor((game.combo - 100) / 20) / 10;
      if (2 < div) {
        div = 2;
      }
      val += div;
    }
    return val;
  };


  /*
  テンションからスロットにμ’sが入るかどうかを返す
  初期値5％、テンションMAXで20％
  過去のフィーバー回数が少ないほど上方補正かける 0回:+12,1回:+8,2回:+4
  @return boolean
   */

  slotSetting.prototype.isAddMuse = function() {
    var random, rate, result;
    result = false;
    rate = Math.floor((game.tension / this.tension_max) * 15) + 5;
    if (game.past_fever_num <= 2) {
      rate += (3 - game.past_fever_num) * 4;
    }
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

  slotSetting.prototype.setMuseMember = function(force) {
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
  コンボ数 * 0.06 ％
  テンションMAXで+5補正
  過去のフィーバー回数が少ないほど上方補正かける 0回:+9,1回:+6,2回:+3
  最大値は20％
  フィーバー中は強制的に当たり
  @return boolean true:当たり
   */

  slotSetting.prototype.getIsForceSlotHit = function() {
    var random, rate, result;
    result = false;
    rate = Math.floor((game.combo * 0.06) + ((game.tension / this.tension_max) * 5));
    if (game.past_fever_num <= 2) {
      rate += (3 - game.past_fever_num) * 3;
    }
    if (rate > 20) {
      rate = 20;
    }
    if (game.debug.half_slot_hit === true) {
      rate = 50;
    }
    this.slotHitRate = rate;
    random = Math.floor(Math.random() * 100);
    if (random < rate || game.fever === true || game.debug.force_slot_hit === true) {
      result = true;
    }
    this.isForceSlotHit = result;
    return result;
  };


  /*
  スロットが回っている時に降ってくる掛け金の戻り分の額を計算
   */

  slotSetting.prototype.getReturnMoneyFallValue = function() {
    return Math.floor(game.bet * game.combo * 0.05);
  };


  /*
  スロットの当選金額を計算
  @param eye 当たったスロットの目
   */

  slotSetting.prototype.calcPrizeMoney = function(eye) {
    var div, ret_money, time;
    ret_money = game.bet * this.bairitu[eye];
    if (game.fever === true) {
      time = this.muse_material_list[game.fever_hit_eye]['bgm'][0]['time'];
      div = Math.floor(time / 30);
      if (div < 1) {
        div = 1;
      }
      ret_money = Math.floor(ret_money / div);
    }
    if (ret_money > 10000000000) {
      ret_money = 10000000000;
    }
    return ret_money;
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
    val = this.tension_max * -0.2;
    if (game.debug.fix_tention_item_fall_flg === true) {
      val = game.debug.fix_tention_item_fall_val;
    }
    return val;
  };

  slotSetting.prototype.setTensionMissItem = function() {
    var val;
    val = this.tension_max * -0.6;
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
    if (game.bet < 10) {
      rate_0 = 60;
      rate_1 = 80;
      rate_2 = 90;
      rate_3 = 95;
    } else if (game.bet < 100) {
      rate_0 = 20;
      rate_1 = 60;
      rate_2 = 80;
      rate_3 = 90;
    } else if (game.bet < 1000) {
      rate_0 = 10;
      rate_1 = 30;
      rate_2 = 60;
      rate_3 = 80;
    } else if (game.bet < 5000) {
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


  /*
  スロットの強制当たりが有効な時間を決める
  エフェクトが画面にイン、アウトする時間が合計0.6秒あるので
  実際はこれの返り値に+0.6追加される
   */

  slotSetting.prototype.setChanceTime = function() {
    var fixTime, randomTime;
    if (this.slotHitRate <= 10) {
      fixTime = 2;
      randomTime = 5;
    } else if (this.slotHitRate <= 15) {
      fixTime = 1.5;
      randomTime = 10;
    } else {
      fixTime = 1;
      randomTime = 15;
    }
    return fixTime + Math.floor(Math.random() * randomTime) / 10;
  };


  /*
  スロットの揃った目が全てμ’sなら役を判定して返します
  メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
  @return role
  ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
  31:のぞえり、32:ほのりん、33:ことぱな、34:にこまき
   */

  slotSetting.prototype.getHitRole = function(left, middle, right) {
    var items, lille, role;
    role = 20;
    lille = [left, middle, right];
    items = game.getDeduplicationList(lille);
    items = game.sortAsc(items);
    items = items.join(',');
    switch (items) {
      case '14,15,16':
        role = 21;
        break;
      case '11,12,13':
        role = 22;
        break;
      case '17,18,19':
        role = 23;
        break;
      case '11,12,16':
        role = 24;
        break;
      case '13,15,18':
        role = 25;
        break;
      case '14,17,19':
        role = 26;
        break;
      case '15,16,17':
        role = 27;
        break;
      case '13,14,19':
        role = 28;
        break;
      case '18,19':
        role = 31;
        break;
      case '11,15':
        role = 32;
        break;
      case '12,16':
        role = 33;
        break;
      case '14,17':
        role = 34;
        break;
      default:
        role = 20;
    }
    return role;
  };

  return slotSetting;

})(appNode);


/*
テストコード用
 */

Test = (function(_super) {
  __extends(Test, _super);

  function Test() {
    Test.__super__.constructor.apply(this, arguments);
    this.test_exe_flg = false;
  }


  /*
  ここにゲーム呼び出し時に実行するテストを書く
   */

  Test.prototype.testExe = function() {
    return this.testSetGravity();
  };

  Test.prototype.testGetHitRole = function() {
    var result;
    result = game.slot_setting.getHitRole(17, 17, 14);
    return console.log(result);
  };

  Test.prototype.testSetGravity = function() {
    var key, param, result, val, _results;
    param = [1, 5, 10, 50, 100, 500, 1000, 2000];
    _results = [];
    for (key in param) {
      val = param[key];
      console.log('bet:' + val);
      game.bet = val;
      result = game.slot_setting.setGravity();
      _results.push(console.log('gravity:' + result));
    }
    return _results;
  };

  return Test;

})(appNode);

mainScene = (function(_super) {
  __extends(mainScene, _super);

  function mainScene() {
    mainScene.__super__.constructor.apply(this, arguments);
    this.backgroundColor = '#93F0FF';
    this.keyList = {
      'left': false,
      'right': false,
      'jump': false,
      'up': false,
      'down': false,
      'pause': false
    };
    this.buttonList = {
      'left': false,
      'right': false,
      'jump': false,
      'up': false,
      'down': false,
      'pause': false
    };
    this.initial();
  }

  mainScene.prototype.initial = function() {
    return this.setGroup();
  };

  mainScene.prototype.setGroup = function() {
    this.gp_back_panorama = new gpBackPanorama();
    this.addChild(this.gp_back_panorama);
    this.gp_front_panorama = new gpFrontPanorama();
    this.addChild(this.gp_front_panorama);
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
    this.gp_slot.x = 55;
    return this.gp_slot.y = 130;
  };

  mainScene.prototype.onenterframe = function(e) {
    this.buttonPush();
    return this.tensionSetValueFever();
  };


  /*ボタン操作、物理キーとソフトキー両方に対応 */

  mainScene.prototype.buttonPush = function() {
    if (game.input.left === true || this.buttonList.left === true) {
      if (this.keyList.left === false) {
        this.keyList.left = true;
        this.gp_system.left_button.changePushColor();
      }
    } else {
      if (this.keyList.left === true) {
        this.keyList.left = false;
        this.gp_system.left_button.changePullColor();
      }
    }
    if (game.input.right === true || this.buttonList.right === true) {
      if (this.keyList.right === false) {
        this.keyList.right = true;
        this.gp_system.right_button.changePushColor();
      }
    } else {
      if (this.keyList.right === true) {
        this.keyList.right = false;
        this.gp_system.right_button.changePullColor();
      }
    }
    if (game.input.up === true || this.buttonList.up === true) {
      if (this.keyList.up === false) {
        this.keyList.up = true;
        this.gp_system.heigh_bet_button.changePushColor();
      }
    } else {
      if (this.keyList.up === true) {
        this.keyList.up = false;
        this.gp_system.heigh_bet_button.changePullColor();
      }
    }
    if (game.input.down === true || this.buttonList.down === true) {
      if (this.keyList.down === false) {
        this.keyList.down = true;
        this.gp_system.low_bet_button.changePushColor();
      }
    } else {
      if (this.keyList.down === true) {
        this.keyList.down = false;
        this.gp_system.low_bet_button.changePullColor();
      }
    }
    if (game.input.z === true || this.buttonList.jump === true) {
      if (this.keyList.jump === false) {
        this.keyList.jump = true;
        this.gp_system.jump_button.changePushColor();
      }
    } else {
      if (this.keyList.jump === true) {
        this.keyList.jump = false;
        this.gp_system.jump_button.changePullColor();
      }
    }
    if (game.input.x === true || this.buttonList.pause === true) {
      if (this.keyList.pause === false) {
        game.setPauseScene();
        return this.keyList.pause = true;
      }
    } else {
      if (this.keyList.pause = true) {
        return this.keyList.pause = false;
      }
    }
  };


  /*
  フィーバー中に一定時間でテンションが下がる
  テンションが0になったらフィーバーを解く
   */

  mainScene.prototype.tensionSetValueFever = function() {
    if (game.fever === true) {
      game.tensionSetValue(game.fever_down_tension);
      if (game.tension <= 0) {
        game.main_scene.gp_slot.upperFrame.frame = 0;
        game.bgmStop(game.main_scene.gp_slot.fever_bgm);
        this.gp_system.changeBetChangeFlg(true);
        this.gp_effect.feverEffectEnd();
        return game.fever = false;
      }
    }
  };

  return mainScene;

})(appScene);

pauseScene = (function(_super) {
  __extends(pauseScene, _super);

  function pauseScene() {
    pauseScene.__super__.constructor.apply(this, arguments);
    this.keyList = {
      'left': false,
      'right': false,
      'jump': false,
      'up': false,
      'down': false,
      'pause': false
    };
    this.buttonList = {
      'left': false,
      'right': false,
      'jump': false,
      'up': false,
      'down': false,
      'pause': false
    };
    this.pause_back = new pauseBack();
    this.pause_main_layer = new pauseMainLayer();
    this.pause_save_layer = new pauseSaveLayer();
    this.pause_item_buy_layer = new pauseItemBuyLayer();
    this.pause_item_use_layer = new pauseItemUseLayer();
    this.pause_member_set_layer = new pauseMemberSetLayer();
    this.pause_item_buy_select_layer = new pauseItemBuySelectLayer();
    this.addChild(this.pause_back);
    this.addChild(this.pause_main_layer);
  }

  pauseScene.prototype.setSaveMenu = function() {
    this.addChild(this.pause_save_layer);
    return game.saveGame();
  };

  pauseScene.prototype.removeSaveMenu = function() {
    return this.removeChild(this.pause_save_layer);
  };

  pauseScene.prototype.setItemBuyMenu = function() {
    return this.addChild(this.pause_item_buy_layer);
  };

  pauseScene.prototype.removeItemBuyMenu = function() {
    return this.removeChild(this.pause_item_buy_layer);
  };

  pauseScene.prototype.setItemUseMenu = function() {
    return this.addChild(this.pause_item_use_layer);
  };

  pauseScene.prototype.removeItemUseMenu = function() {
    return this.removeChild(this.pause_item_use_layer);
  };

  pauseScene.prototype.setMemberSetMenu = function() {
    return this.addChild(this.pause_member_set_layer);
  };

  pauseScene.prototype.removeMemberSetMenu = function() {
    return this.removeChild(this.pause_member_set_layer);
  };

  pauseScene.prototype.setItemBuySelectMenu = function(kind) {
    this.addChild(this.pause_item_buy_select_layer);
    return this.pause_item_buy_select_layer.setSelectItem(kind);
  };

  pauseScene.prototype.removeItemBuySelectMenu = function() {
    return this.removeChild(this.pause_item_buy_select_layer);
  };

  pauseScene.prototype.onenterframe = function(e) {
    return this._pauseKeyPush();
  };


  /*
  ポーズキーまたはポーズボタンを押した時の動作
   */

  pauseScene.prototype._pauseKeyPush = function() {
    if (game.input.x === true || this.buttonList.pause === true) {
      if (this.keyList.pause === false) {
        game.popPauseScene();
        return this.keyList.pause = true;
      }
    } else {
      if (this.keyList.pause = true) {
        return this.keyList.pause = false;
      }
    }
  };

  return pauseScene;

})(appScene);


/*
テスト用、空のシーン
 */

testScene = (function(_super) {
  __extends(testScene, _super);

  function testScene() {
    testScene.__super__.constructor.apply(this, arguments);
  }

  return testScene;

})(appScene);

titleScene = (function(_super) {
  __extends(titleScene, _super);

  function titleScene() {
    titleScene.__super__.constructor.apply(this, arguments);
    this.title_main_layer = new titleMainLayer();
    this.addChild(this.title_main_layer);
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
    FrontPanorama.__super__.constructor.call(this, game.width, 310);
    this.image = game.imageload("okujou");
    this.setPosition();
  }

  FrontPanorama.prototype.setPosition = function() {
    this.x = 0;
    return this.y = game.height - this.h;
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
    this.cut_in = cut_in_list[cut_in_random];
    return this.voices = setting.muse_material_list[muse_num]['voice'];
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
    game.main_scene.gp_stage_front.setItemFallFrm(6);
    this.set_age = this.age;
    this.fast = 0.5 * game.fps;
    this.slow = 2 * game.fps + this.fast;
    return this.voice = this._setVoice();
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
    if (this.voice !== false) {
      game.sePlay(this.voice);
    }
    val = Math.round((game.width / 4) / (2 * game.fps));
    if (this.cut_in['direction'] === 'left') {
      val *= -1;
    }
    return val;
  };

  cutIn.prototype._setVoice = function() {
    var random, voice;
    if (this.voices.length > 0) {
      random = Math.floor(Math.random() * this.voices.length);
      voice = game.soundload('voice/' + this.voices[random]);
    } else {
      voice = game.soundload('clear');
    }
    return voice;
  };

  return cutIn;

})(effect);


/*
演出
 */

performanceEffect = (function(_super) {
  __extends(performanceEffect, _super);

  function performanceEffect(w, h) {
    performanceEffect.__super__.constructor.call(this, w, h);
  }

  return performanceEffect;

})(effect);


/*
チャンス
 */

chanceEffect = (function(_super) {
  __extends(chanceEffect, _super);

  function chanceEffect() {
    chanceEffect.__super__.constructor.call(this, 237, 50);
    this.image = game.imageload("chance");
    this.y = 290;
    this.x = game.width;
    this.existTime = 2;
    this.sound = game.soundload('clear');
  }

  chanceEffect.prototype.onenterframe = function(e) {
    if (this.age - this.set_age === this.fast_age) {
      game.sePlay(this.sound);
      this.vx = this._setVxSlow();
    }
    if (this.age - this.set_age === this.slow_age) {
      this.vx = this._setVxFast();
    }
    this.x += this.vx;
    if (this.x + this.w < 0) {
      game.main_scene.gp_slot.endForceSlotHit();
      return game.main_scene.gp_effect.removeChild(this);
    }
  };

  chanceEffect.prototype.setInit = function() {
    this.existTime = game.slot_setting.setChanceTime();
    this.x = game.width;
    this.vx = this._setVxFast();
    this.set_age = this.age;
    this.fast_age = Math.round(0.3 * game.fps);
    return this.slow_age = Math.round(this.existTime * game.fps) + this.fast_age;
  };

  chanceEffect.prototype._setVxFast = function() {
    return Math.round(((game.width + this.w) / 2) / (0.3 * game.fps)) * -1;
  };

  chanceEffect.prototype._setVxSlow = function() {
    return Math.round(((game.width - this.w) / 4) / (this.existTime * game.fps)) * -1;
  };

  return chanceEffect;

})(performanceEffect);


/*
フィーバー
 */

feverEffect = (function(_super) {
  __extends(feverEffect, _super);

  function feverEffect() {
    feverEffect.__super__.constructor.call(this, 190, 50);
    this.image = game.imageload("fever");
    this.y = 290;
    this.x = (game.width - this.w) / 2;
    this.frame = 0;
  }

  return feverEffect;

})(performanceEffect);

feverOverlay = (function(_super) {
  __extends(feverOverlay, _super);

  function feverOverlay() {
    feverOverlay.__super__.constructor.apply(this, arguments);
    this.frame = 1;
    this.opacity_frm = Math.floor(100 / game.fps) / 100;
  }

  feverOverlay.prototype.setInit = function() {
    return this.opacity = 0;
  };

  feverOverlay.prototype.onenterframe = function(e) {
    this.opacity += this.opacity_frm;
    if (this.opacity < 0) {
      this.opacity = 0;
      this.opacity_frm *= -1;
    }
    if (1 < this.opacity) {
      this.opacity = 1;
      return this.opacity_frm *= -1;
    }
  };

  return feverOverlay;

})(feverEffect);


/*
キラキラ
 */

kirakiraEffect = (function(_super) {
  __extends(kirakiraEffect, _super);

  function kirakiraEffect() {
    kirakiraEffect.__super__.constructor.call(this, 50, 50);
    this.image = game.imageload("kira");
    this.flashPeriodFrm = game.fps;
    this.setInit();
  }

  kirakiraEffect.prototype.setInit = function() {
    var randomSize;
    this.x = Math.floor(Math.random() * game.width);
    this.y = Math.floor(Math.random() * game.height);
    this.randomPeriodFrm = Math.floor(Math.random() * 3 * game.fps);
    this.halfFrm = this.randomPeriodFrm + Math.round(this.flashPeriodFrm / 2);
    this.totalFrm = this.randomPeriodFrm + this.flashPeriodFrm;
    randomSize = Math.floor(Math.random() * 30) + 20;
    this.scaleV = Math.floor((randomSize / 50) * 200 / this.flashPeriodFrm) / 100;
    this.opacityV = Math.floor((Math.random() * 50 + 50) * 2 / this.flashPeriodFrm) / 100;
    this.scaleX = 0;
    this.scaleY = 0;
    return this.opacity = 0;
  };

  kirakiraEffect.prototype.onenterframe = function(e) {
    var unitAge;
    unitAge = this.age % this.totalFrm;
    if (unitAge < this.randomPeriodFrm) {

    } else if (unitAge < this.halfFrm) {
      this.scaleX += this.scaleV;
      this.scaleY += this.scaleV;
      return this.opacity += this.opacityV;
    } else if (unitAge < this.totalFrm) {
      this.scaleX -= this.scaleV;
      this.scaleY -= this.scaleV;
      this.opacity -= this.opacityV;
      if (this.scaleX < 0) {
        this.scaleX = 0;
      }
      if (this.scaleY < 0) {
        this.scaleY = 0;
      }
      if (this.opacity < 0) {
        return this.opacity = 0;
      }
    } else if (unitAge === 0) {
      return this.setInit();
    }
  };

  return kirakiraEffect;

})(performanceEffect);


/*
背景のレイヤーに表示するエフェクト
 */

panoramaEffect = (function(_super) {
  __extends(panoramaEffect, _super);

  function panoramaEffect(w, h) {
    panoramaEffect.__super__.constructor.call(this, w, h);
    this.x_init = 0;
    this.y_init = game.height - Math.floor(310 / 2);
  }

  panoramaEffect.prototype.setInit = function() {
    this.age = 0;
    this.x = this.x_init;
    return this.y = this.y_init;
  };

  return panoramaEffect;

})(backGround);


/*
進撃のことり
 */

bigKotori = (function(_super) {
  __extends(bigKotori, _super);

  function bigKotori() {
    bigKotori.__super__.constructor.call(this, 365, 360);
    this.image = game.imageload('big-kotori');
    this.x_init = -this.w;
    this.move_sec = 20;
    this.wait_sec = 20;
    this.v = Math.floor(this.w * 10 / (this.move_sec * game.fps)) / 10;
    this.wait_start_frm = this.move_sec * game.fps;
    this.wait_end_frm = (this.move_sec + this.wait_sec) * game.fps;
    this.move_end_frm = (this.move_sec * 2 + this.wait_sec) * game.fps;
  }

  bigKotori.prototype.onenterframe = function() {
    if (0 <= this.age && this.age < this.wait_start_frm) {
      this.x += this.v;
      return this.y -= this.v;
    } else if (this.wait_end_frm <= this.age && this.age < this.move_end_frm) {
      this.x -= this.v;
      return this.y += this.v;
    } else if (this.age === this.move_end_frm) {
      return game.main_scene.gp_back_panorama.endBigKotori();
    }
  };

  return bigKotori;

})(panoramaEffect);

appObject = (function(_super) {
  __extends(appObject, _super);


  /*
  制約
  ・objectは必ずstageに対して追加する
   */

  function appObject(w, h) {
    appObject.__super__.constructor.call(this, w, h);
    this.gravity = 1.2;
    this.friction = 1.7;
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
    this.jump_se = game.soundload('jump');
    this.isAir = true;
    this.vx = 0;
    this.vy = 0;
    this.ax = 3;
    this.mx = 7;
    this.my = 19;
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
      this.jumpSound();
      vy -= this.my;
      this.isAir = true;
    }
    return vy;
  };

  Character.prototype.jumpSound = function() {};


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
    if (game.main_scene.keyList.left === true) {
      if (this.moveFlg.left === false) {
        this.moveFlg.left = true;
      }
    } else {
      if (this.moveFlg.left === true) {
        this.moveFlg.left = false;
      }
    }
    if (game.main_scene.keyList.right === true) {
      if (this.moveFlg.right === false) {
        this.moveFlg.right = true;
      }
    } else {
      if (this.moveFlg.right === true) {
        this.moveFlg.right = false;
      }
    }
    if (game.main_scene.keyList.jump === true) {
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

  Player.prototype.jumpSound = function() {
    return game.sePlay(this.jump_se);
  };

  return Player;

})(Character);

Bear = (function(_super) {
  __extends(Bear, _super);

  function Bear() {
    Bear.__super__.constructor.call(this, 67, 65);
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
    this.miss_se = game.soundload('cancel');
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
      game.sePlay(this.miss_se);
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
    MacaroonCatch.__super__.constructor.call(this, 37, 37);
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
    OnionCatch.__super__.constructor.call(this, 37, 37);
    this.image = game.imageload("sweets");
    this.frame = 5;
    this.scaleX = 1.5;
    this.scaleY = 1.5;
  }

  OnionCatch.prototype.hitPlayer = function() {
    if (game.main_scene.gp_stage_front.player.intersect(this)) {
      game.sePlay(this.miss_se);
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
    Money.__super__.constructor.call(this, 26, 30);
    this.vx = 0;
    this.vy = 0;
    this.frame_init = 0;
    this.price = 1;
    this.gravity = 0.37;
    this.image = game.imageload("coin");
    this.catch_se = game.soundload("medal");
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
      return this.gravity = 1.5;
    }
  };


  /*
  プレイヤーに当たった時
   */

  Money.prototype.hitPlayer = function() {
    if (game.main_scene.gp_stage_front.player.intersect(this)) {
      game.sePlay(this.catch_se);
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
  }


  /*
  枠の無い長方形
  @param color 色
   */

  Slot.prototype.drawRect = function(color) {
    var surface;
    surface = new Surface(this.w, this.h);
    surface.context.fillStyle = color;
    surface.context.fillRect(0, 0, this.w, this.h, 10);
    surface.context.fill();
    return surface;
  };

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
    UnderFrame.__super__.constructor.call(this, 369, 123);
    this.image = this.drawRect('white');
  }

  return UnderFrame;

})(Frame);

UpperFrame = (function(_super) {
  __extends(UpperFrame, _super);

  function UpperFrame(w, h) {
    UpperFrame.__super__.constructor.call(this, 381, 135);
    this.image = game.imageload("frame");
    this.x = -6;
    this.y = -6;
  }

  return UpperFrame;

})(Frame);

Lille = (function(_super) {
  __extends(Lille, _super);

  function Lille(w, h) {
    Lille.__super__.constructor.call(this, 123, 123);
    this.image = game.imageload("lille");
    this.lotate_se = game.soundload('select');
    this.lilleArray = [];
    this.isRotation = false;
    this.nowEye = 0;
  }

  Lille.prototype.onenterframe = function(e) {
    if (this.isRotation === true) {
      this.eyeIncriment();
      return this.soundLotateSe();
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

  Lille.prototype.soundLotateSe = function() {};

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
    this.lilleArray = game.arrayCopy(game.slot_setting.lille_array_0[0]);
    this.eyeInit();
    this.x = 0;
  }

  return LeftLille;

})(Lille);

MiddleLille = (function(_super) {
  __extends(MiddleLille, _super);

  function MiddleLille() {
    MiddleLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.arrayCopy(game.slot_setting.lille_array_0[1]);
    this.eyeInit();
    this.x = 123;
  }

  return MiddleLille;

})(Lille);

RightLille = (function(_super) {
  __extends(RightLille, _super);

  function RightLille() {
    RightLille.__super__.constructor.apply(this, arguments);
    this.lilleArray = game.arrayCopy(game.slot_setting.lille_array_0[2]);
    this.eyeInit();
    this.x = 246;
  }

  RightLille.prototype.soundLotateSe = function() {
    if (this.age % 2 === 0) {
      return game.sePlay(this.lotate_se);
    }
  };

  return RightLille;

})(Lille);

System = (function(_super) {
  __extends(System, _super);

  function System(w, h) {
    System.__super__.constructor.call(this, w, h);
  }

  System.prototype._makeContext = function() {
    this.surface = new Surface(this.w, this.h);
    return this.context = this.surface.context;
  };


  /*
  枠の無い長方形
  @param color 色
   */

  System.prototype.drawRect = function(color) {
    this._makeContext();
    this.context.fillStyle = color;
    this.context.fillRect(0, 0, this.w, this.h, 10);
    this.context.fill();
    return this.surface;
  };


  /*
  枠のある長方形
  @param string strokeColor 枠の色
  @param string fillColor   色
  @param number thick       枠の太さ
   */

  System.prototype.drawStrokeRect = function(strokeColor, fillColor, thick) {
    this._makeContext();
    this.context.fillStyle = strokeColor;
    this.context.fillRect(0, 0, this.w, this.h);
    this.context.fillStyle = fillColor;
    this.context.fillRect(thick, thick, this.w - (thick * 2), this.h - (thick * 2));
    return this.surface;
  };


  /*
  左向きの三角形
  @param color 色
   */

  System.prototype.drawLeftTriangle = function(color) {
    this._makeContext();
    this.context.fillStyle = color;
    this.context.beginPath();
    this.context.moveTo(0, this.h / 2);
    this.context.lineTo(this.w, 0);
    this.context.lineTo(this.w, this.h);
    this.context.closePath();
    this.context.fill();
    return this.surface;
  };


  /*
  上向きの三角形
  @param color 色
   */

  System.prototype.drawUpTriangle = function(color) {
    this._makeContext();
    this.context.fillStyle = color;
    this.context.beginPath();
    this.context.moveTo(this.w / 2, 0);
    this.context.lineTo(this.w, this.h);
    this.context.lineTo(0, this.h);
    this.context.closePath();
    this.context.fill();
    return this.surface;
  };


  /*
  丸
  @param color 色
   */

  System.prototype.drawCircle = function(color) {
    this._makeContext();
    this.context.fillStyle = color;
    this.context.arc(this.w / 2, this.h / 2, this.w / 2, 0, Math.PI * 2, true);
    this.context.fill();
    return this.surface;
  };

  return System;

})(appSprite);

Button = (function(_super) {
  __extends(Button, _super);

  function Button(w, h) {
    Button.__super__.constructor.call(this, w, h);
  }

  Button.prototype.touchendEvent = function() {};

  return Button;

})(System);


/*
ポーズボタン
 */

pauseButton = (function(_super) {
  __extends(pauseButton, _super);

  function pauseButton() {
    pauseButton.__super__.constructor.call(this, 36, 36);
    this.image = game.imageload("pause");
    this.x = 430;
    this.y = 76;
  }

  pauseButton.prototype.ontouchend = function(e) {
    return game.setPauseScene();
  };

  return pauseButton;

})(Button);


/*
コントローラボタン
 */

controllerButton = (function(_super) {
  __extends(controllerButton, _super);

  function controllerButton() {
    controllerButton.__super__.constructor.call(this, 50, 50);
    this.color = "#888";
    this.pushColor = "#333";
    this.opacity = 0.4;
    this.x = 0;
    this.y = 660;
  }

  controllerButton.prototype.changePushColor = function() {
    return this.image = this.drawLeftTriangle(this.pushColor);
  };

  controllerButton.prototype.changePullColor = function() {
    return this.image = this.drawLeftTriangle(this.color);
  };

  return controllerButton;

})(Button);


/*
左ボタン
 */

leftButton = (function(_super) {
  __extends(leftButton, _super);

  function leftButton() {
    leftButton.__super__.constructor.apply(this, arguments);
    this.image = this.drawLeftTriangle(this.color);
    this.x = 30;
  }

  leftButton.prototype.ontouchstart = function() {
    return game.main_scene.buttonList.left = true;
  };

  leftButton.prototype.ontouchend = function() {
    return game.main_scene.buttonList.left = false;
  };

  return leftButton;

})(controllerButton);


/*
右ボタン
 */

rightButton = (function(_super) {
  __extends(rightButton, _super);

  function rightButton() {
    rightButton.__super__.constructor.apply(this, arguments);
    this.image = this.drawLeftTriangle(this.color);
    this.scaleX = -1;
    this.x = game.width - this.w - 30;
  }

  rightButton.prototype.ontouchstart = function() {
    return game.main_scene.buttonList.right = true;
  };

  rightButton.prototype.ontouchend = function() {
    return game.main_scene.buttonList.right = false;
  };

  return rightButton;

})(controllerButton);


/*
ジャンプボタン
 */

jumpButton = (function(_super) {
  __extends(jumpButton, _super);

  function jumpButton() {
    jumpButton.__super__.constructor.apply(this, arguments);
    this.image = this.drawCircle(this.color);
    this.x = (game.width - this.w) / 2;
  }

  jumpButton.prototype.ontouchstart = function() {
    return game.main_scene.buttonList.jump = true;
  };

  jumpButton.prototype.ontouchend = function() {
    return game.main_scene.buttonList.jump = false;
  };

  jumpButton.prototype.changePushColor = function() {
    return this.image = this.drawCircle(this.pushColor);
  };

  jumpButton.prototype.changePullColor = function() {
    return this.image = this.drawCircle(this.color);
  };

  return jumpButton;

})(controllerButton);


/*
掛け金変更ボタン
 */

betButton = (function(_super) {
  __extends(betButton, _super);

  function betButton() {
    betButton.__super__.constructor.call(this, 22, 22);
    this.color = "black";
    this.pushColor = "white";
    this.y = 7;
  }

  betButton.prototype.changePushColor = function() {
    return this.image = this.drawUpTriangle(this.pushColor);
  };

  betButton.prototype.changePullColor = function() {
    return this.image = this.drawUpTriangle(this.color);
  };

  return betButton;

})(Button);


/*
掛け金を増やすボタン
 */

heighBetButton = (function(_super) {
  __extends(heighBetButton, _super);

  function heighBetButton() {
    heighBetButton.__super__.constructor.apply(this, arguments);
    this.image = this.drawUpTriangle(this.color);
    this.x = 7;
  }

  heighBetButton.prototype.ontouchstart = function() {
    return game.main_scene.buttonList.up = true;
  };

  heighBetButton.prototype.ontouchend = function() {
    return game.main_scene.buttonList.up = false;
  };

  return heighBetButton;

})(betButton);


/*
掛け金を減らすボタン
 */

lowBetButton = (function(_super) {
  __extends(lowBetButton, _super);

  function lowBetButton() {
    lowBetButton.__super__.constructor.apply(this, arguments);
    this.image = this.drawUpTriangle(this.color);
    this.scaleY = -1;
    this.x = 121;
  }

  lowBetButton.prototype.setXposition = function() {
    return this.x = game.main_scene.gp_system.bet_text._boundWidth + this.w + 20;
  };

  lowBetButton.prototype.ontouchstart = function() {
    return game.main_scene.buttonList.down = true;
  };

  lowBetButton.prototype.ontouchend = function() {
    return game.main_scene.buttonList.down = false;
  };

  return lowBetButton;

})(betButton);

Dialog = (function(_super) {
  __extends(Dialog, _super);

  function Dialog(w, h) {
    Dialog.__super__.constructor.call(this, w, h);
  }


  /*
  ダイアログの描画
   */

  Dialog.prototype.drawDialog = function() {
    return this.drawStrokeRect('#aaaaaa', '#ffffff', 5);
  };

  return Dialog;

})(System);

pauseBack = (function(_super) {
  __extends(pauseBack, _super);

  function pauseBack(w, h) {
    pauseBack.__super__.constructor.call(this, game.width, game.height);
    this.image = this.drawRect('#000000');
    this.opacity = 0.8;
  }

  return pauseBack;

})(Dialog);

Param = (function(_super) {
  __extends(Param, _super);

  function Param(w, h) {
    Param.__super__.constructor.call(this, w, h);
  }

  return Param;

})(System);

TensionGaugeBack = (function(_super) {
  __extends(TensionGaugeBack, _super);

  function TensionGaugeBack(w, h) {
    TensionGaugeBack.__super__.constructor.call(this, 457, 19);
    this.image = this.drawRect('#FFFFFF');
    this.x = 11;
    this.y = 46;
  }

  return TensionGaugeBack;

})(Param);

TensionGauge = (function(_super) {
  __extends(TensionGauge, _super);

  function TensionGauge(w, h) {
    TensionGauge.__super__.constructor.call(this, 450, 11);
    this.image = this.drawRect('#6EB7DB');
    this.x = 15;
    this.y = 50;
    this.setValue();
  }

  TensionGauge.prototype.setValue = function() {
    var tension;
    tension = 0;
    if (game.tension !== 0) {
      tension = game.tension / game.slot_setting.tension_max;
    }
    this.scaleX = tension;
    this.x = 15 - ((this.w - tension * this.w) / 2);
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

ItemSlot = (function(_super) {
  __extends(ItemSlot, _super);

  function ItemSlot() {
    ItemSlot.__super__.constructor.call(this, 55, 55);
    this.image = this.drawCircle('#aaa');
    this.x = 5;
    this.y = 70;
  }

  return ItemSlot;

})(Param);

ItemGaugeBack = (function(_super) {
  __extends(ItemGaugeBack, _super);

  function ItemGaugeBack() {
    ItemGaugeBack.__super__.constructor.call(this, 50, 8);
    this.image = this.drawRect('#333');
    this.x = 8;
    this.y = 112;
  }

  return ItemGaugeBack;

})(Param);

ItemGauge = (function(_super) {
  __extends(ItemGauge, _super);

  function ItemGauge() {
    ItemGauge.__super__.constructor.call(this, 50, 8);
    this.image = this.drawRect('#A6E39D');
    this.x = 8;
    this.y = 112;
  }

  return ItemGauge;

})(Param);

//# sourceMappingURL=main.js.map
