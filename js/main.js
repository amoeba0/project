var BackPanorama, Bear, Button, Catch, Character, Debug, Dialog, Floor, Frame, FrontPanorama, Guest, HundredMoney, HundredThousandMoney, Item, ItemGauge, ItemGaugeBack, ItemSlot, LeftLille, Lille, LoveliveGame, MacaroonCatch, MiddleLille, Money, OneMillionMoney, OneMoney, OnionCatch, Panorama, Param, Player, RightLille, Slot, System, TenMillionMoney, TenMoney, TenThousandMoney, TensionGauge, TensionGaugeBack, Test, ThousandMoney, UnderFrame, UpperFrame, appDomLayer, appGame, appGroup, appHtml, appLabel, appNode, appObject, appScene, appSprite, backGround, baseByuButtonHtml, baseCancelButtonHtml, baseDialogHtml, baseItemHtml, baseOkButtonHtml, baseRecordItemHtml, baseSetButtonHtml, betButton, betText, bigKotori, buttonHtml, buyItemButtonHtml, buyItemHtml, buyMemberHtml, buyTrophyItemHtml, catchAndSlotGame, chanceEffect, comboText, comboUnitText, controllerButton, cutIn, dialogCloseButton, dialogHtml, discriptionTextDialogHtml, effect, explosionEffect, feverEffect, feverOverlay, gpBackPanorama, gpEffect, gpFrontPanorama, gpPanorama, gpSlot, gpStage, gpSystem, heighBetButton, imageHtml, itemBuyBuyButtonHtml, itemBuyCancelButtonHtml, itemBuyDialogCloseButton, itemBuyDialogHtml, itemBuySelectDialogHtml, itemCatchEffect, itemDiscription, itemHtml, itemItemBuyDiscription, itemNameDiscription, itemUseCancelButtonHtml, itemUseDialogCloseButton, itemUseDialogHtml, itemUseDiscription, itemUseSelectDialogHtml, itemUseSetButtonHtml, jumpButton, kirakiraEffect, leftButton, longTitleDiscription, lowBetButton, mainScene, memberHtml, memberItemBuyDiscription, memberSetDialogCloseButton, memberSetDialogHtml, memberSetDiscription, memberUseCancelButtonHtml, memberUseSelectDialogHtml, memberUseSetButtonHtml, menuDialogHtml, modal, moneyText, panoramaEffect, pauseBack, pauseBaseRecordSelectLayer, pauseButton, pauseItemBuyLayer, pauseItemBuySelectLayer, pauseItemUseLayer, pauseItemUseSelectLayer, pauseMainLayer, pauseMainMenuButtonHtml, pauseMemberSetLayer, pauseMemberUseSelectLayer, pauseRecordLayer, pauseRecordSelectLayer, pauseSaveLayer, pauseScene, pauseTrophySelectLayer, performanceEffect, recordButtonHtml, recordDialogCloseButton, recordDialogHtml, recordDiscription, recordItemHtml, recordOkButtonHtml, recordSelectDialogHtml, returnGameButtonHtml, rightButton, saveDialogHtml, saveGameButtonHtml, saveOkButtonHtml, selectDialogHtml, selectItemImage, setItemHtml, setMemberButtonHtml, setMemberHtml, slotSetting, stageBack, stageFront, startGameButtonHtml, systemHtml, testScene, text, titleDiscription, titleMainLayer, titleMenuButtonHtml, titleScene, trophyDiscription, trophyItemBuyDiscription, trophyItemHtml, trophyOkButtonHtml, useHaveDiscription, useItemButtonHtml, useItemHtml, useMemberHtml, useSetDiscription,
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
    if (this.isSumaho() === false) {
      this.scale = 1;
    }
    this.is_server = false;
    this.mute = false;
    this.imgList = [];
    this.soundList = [];
    this.nowPlayBgm = null;
    this.loadedFile = [];
  }


  /*
      画像の呼び出し
   */

  appGame.prototype.imageload = function(img) {
    var callImg;
    callImg = this.assets["images/" + img + ".png"];
    if (callImg === void 0) {
      callImg = null;
    }
    return callImg;
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
    if (bgm_loop == null) {
      bgm_loop = false;
    }
    if (bgm !== void 0) {
      bgm.play();
      this.nowPlayBgm = bgm;
      if (bgm_loop === true) {
        if (this.is_server === true) {
          return bgm.src.loop = true;
        } else {
          return bgm._element.loop = true;
        }
      }
    }
  };


  /*
  BGMを止める
   */

  appGame.prototype.bgmStop = function(bgm) {
    if (bgm !== void 0) {
      bgm.stop();
      return this.nowPlayBgm = null;
    }
  };


  /*
  BGMの中断
   */

  appGame.prototype.bgmPause = function(bgm) {
    if (bgm !== void 0) {
      return bgm.pause();
    }
  };


  /*
  現在再生中のBGMを一時停止する
   */

  appGame.prototype.nowPlayBgmPause = function() {
    if (this.nowPlayBgm !== null) {
      return this.bgmPause(this.nowPlayBgm);
    }
  };


  /*
  現在再生中のBGMを再開する
   */

  appGame.prototype.nowPlayBgmRestart = function(bgm_loop) {
    if (bgm_loop == null) {
      bgm_loop = false;
    }
    if (this.nowPlayBgm !== null) {
      return this.bgmPlay(this.nowPlayBgm, bgm_loop);
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
  enchant.jsのload関数をラッピング
  ロード終了後にloadedFileにロードしたファイルを置いておいて、ロード済みかどうかの判別に使う
   */

  appGame.prototype.appLoad = function(file) {
    return this.load(file);
  };


  /*
  ロード済みのファイルを記憶しておく
   */

  appGame.prototype.setLoadedFile = function(file) {
    return this.loadedFile.push(file);
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


  /*
  配列から指定の値を削除して詰めて返す
  @param arr    対象の配列
  @param target 削除する値
  @return array
   */

  appGame.prototype.arrayValueDel = function(arr, target) {
    arr.some(function(v, i) {
      if (v === target) {
        return arr.splice(i, 1);
      }
    });
    return arr;
  };


  /*
  数値の単位を漢数字で区切る
   */

  appGame.prototype.toJPUnit = function(num) {
    var count, i, kName, n, n_, ptr, str;
    str = num + '';
    n = '';
    n_ = '';
    count = 0;
    ptr = 0;
    kName = ['', '万', '億', '兆', '京', '垓'];
    i = str.length - 1;
    while (i >= 0) {
      n_ = str.charAt(i) + n_;
      count++;
      if (count % 4 === 0 && i !== 0) {
        if (n_ !== '0000') {
          n = n_ + kName[ptr] + n;
        }
        n_ = '';
        ptr += 1;
      }
      if (i === 0) {
        n = n_ + kName[ptr] + n;
      }
      i--;
    }
    return n;
  };


  /*
  ユーザーエージェントの判定
   */

  appGame.prototype.userAgent = function() {
    var mobile, pc, tablet, u;
    u = window.navigator.userAgent.toLowerCase();
    mobile = {
      0: u.indexOf('windows') !== -1 && u.indexOf('phone') !== -1 || u.indexOf('iphone') !== -1 || u.indexOf('ipod') !== -1 || u.indexOf('android') !== -1 && u.indexOf('mobile') !== -1 || u.indexOf('firefox') !== -1 && u.indexOf('mobile') !== -1 || u.indexOf('blackberry') !== -1,
      iPhone: u.indexOf('iphone') !== -1,
      Android: u.indexOf('android') !== -1 && u.indexOf('mobile') !== -1
    };
    tablet = u.indexOf('windows') !== -1 && u.indexOf('touch') !== -1 || u.indexOf('ipad') !== -1 || u.indexOf('android') !== -1 && u.indexOf('mobile') === -1 || u.indexOf('firefox') !== -1 && u.indexOf('tablet') !== -1 || u.indexOf('kindle') !== -1 || u.indexOf('silk') !== -1 || u.indexOf('playbook') !== -1;
    pc = !mobile[0] && !tablet;
    return {
      Mobile: mobile,
      Tablet: tablet,
      PC: pc
    };
  };


  /*
  スマホかタブレットならtrueを返す
   */

  appGame.prototype.isSumaho = function() {
    var rslt, ua;
    ua = this.userAgent();
    rslt = false;
    if (ua.Mobile[0] === true || ua.Tablet === true) {
      rslt = true;
    }
    return rslt;
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

  appSprite.prototype._makeContext = function() {
    this.surface = new Surface(this.w, this.h);
    return this.context = this.surface.context;
  };


  /*
  枠の無い長方形
  @param color 色
   */

  appSprite.prototype.drawRect = function(color) {
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

  appSprite.prototype.drawStrokeRect = function(strokeColor, fillColor, thick) {
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

  appSprite.prototype.drawLeftTriangle = function(color) {
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

  appSprite.prototype.drawUpTriangle = function(color) {
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

  appSprite.prototype.drawCircle = function(color) {
    this._makeContext();
    this.context.fillStyle = color;
    this.context.arc(this.w / 2, this.h / 2, this.w / 2, 0, Math.PI * 2, true);
    this.context.fill();
    return this.surface;
  };

  return appSprite;

})(Sprite);

pauseItemBuyLayer = (function(_super) {
  __extends(pauseItemBuyLayer, _super);

  function pauseItemBuyLayer() {
    var i, _i, _j, _k;
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
    this.trophy_list = {};
    for (i = _k = 21; _k <= 24; i = ++_k) {
      this.trophy_list[i] = new buyTrophyItemHtml(i - 21, i);
    }
    this.setItemList();
    this.resetItemList();
    this.item_title = new itemItemBuyDiscription();
    this.addChild(this.item_title);
    this.member_title = new memberItemBuyDiscription();
    this.addChild(this.member_title);
    this.trophy_title = new trophyItemBuyDiscription();
    this.addChild(this.trophy_title);
  }

  pauseItemBuyLayer.prototype.setItemList = function() {
    var item_key, item_val, member_key, member_val, trophy_key, trophy_val, _ref, _ref1, _ref2, _results;
    _ref = this.item_list;
    for (item_key in _ref) {
      item_val = _ref[item_key];
      this.addChild(item_val);
      item_val.setPosition();
    }
    _ref1 = this.member_list;
    for (member_key in _ref1) {
      member_val = _ref1[member_key];
      this.addChild(member_val);
      member_val.setPosition();
    }
    _ref2 = this.trophy_list;
    _results = [];
    for (trophy_key in _ref2) {
      trophy_val = _ref2[trophy_key];
      this.addChild(trophy_val);
      _results.push(trophy_val.setPosition());
    }
    return _results;
  };

  pauseItemBuyLayer.prototype.resetItemList = function() {
    var i, master_list, _i;
    master_list = game.slot_setting.item_list;
    for (i = _i = 1; _i <= 19; i = ++_i) {
      if (master_list[i] === void 0) {
        master_list[i] = master_list[0];
      }
    }
    this._resetItemList(this.item_list, master_list);
    return this._resetItemList(this.member_list, master_list);
  };

  pauseItemBuyLayer.prototype._resetItemList = function(item_list, master_list) {
    var item_key, item_val, _results;
    _results = [];
    for (item_key in item_list) {
      item_val = item_list[item_key];
      if (master_list[item_key].condFunc() === false || master_list[item_key].price > game.money) {
        item_val.opacity = 0.5;
      } else {
        item_val.opacity = 1;
      }
      if (game.item_have_now.indexOf(parseInt(item_key)) !== -1) {
        item_val.opacity = 0;
        item_val.is_exist = false;
        _results.push(item_val.changeNotButton());
      } else {
        _results.push(void 0);
      }
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
    this.buy_button = new itemBuyBuyButtonHtml();
    this.item_name = new itemNameDiscription();
    this.item_image = new selectItemImage();
    this.item_discription = new itemDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.item_image);
    this.addChild(this.item_name);
    this.addChild(this.item_discription);
    this.addChild(this.cancel_button);
    this.addChild(this.buy_button);
    this.item_kind = 0;
    this.item_options = [];
  }

  pauseItemBuySelectLayer.prototype.setSelectItem = function(kind) {
    var discription;
    this.item_kind = kind;
    this.item_options = game.slot_setting.item_list[kind];
    if (this.item_options === void 0) {
      this.item_options = game.slot_setting.item_list[0];
    }
    this.item_name.setText(this.item_options.name);
    this.item_image.setImage(this.item_options.image);
    discription = this._setDiscription();
    this.item_discription.setText(discription);
    return this._setButton();
  };

  pauseItemBuySelectLayer.prototype._setDiscription = function() {
    var text;
    text = '効果：' + this.item_options.discription;
    if (this.item_options.durationSec !== void 0) {
      text += '<br>持続時間：' + this.item_options.durationSec + '秒';
    }
    if (this.item_options.condFunc() === true || 20 < this.item_kind) {
      text += '<br>値段：' + game.toJPUnit(this.item_options.price) + '円' + '(所持金' + game.toJPUnit(game.money) + '円)';
    }
    if (this.item_options.condFunc() === false || 20 < this.item_kind) {
      text += '<br>出現条件：' + this.item_options.conditoin;
    }
    return text;
  };

  pauseItemBuySelectLayer.prototype._setButton = function() {
    if (this.item_options.condFunc() === true && game.money >= this.item_options.price) {
      this.cancel_button.setBuyPossiblePosition();
      return this.buy_button.setBuyPossiblePosition();
    } else {
      this.cancel_button.setBuyImpossiblePositon();
      return this.buy_button.setBuyImpossiblePositon();
    }
  };


  /*
  アイテムの購入
   */

  pauseItemBuySelectLayer.prototype.buyItem = function() {
    game.money -= this.item_options.price;
    game.item_have_now.push(this.item_kind);
    game.pause_scene.removeItemBuySelectMenu();
    game.pause_scene.pause_item_buy_layer.resetItemList();
    return game.main_scene.gp_system.money_text.setValue();
  };

  return pauseItemBuySelectLayer;

})(appDomLayer);

pauseItemUseLayer = (function(_super) {
  __extends(pauseItemUseLayer, _super);

  function pauseItemUseLayer() {
    var i, _i, _j, _ref;
    pauseItemUseLayer.__super__.constructor.apply(this, arguments);
    this.max_set_item_num = 1;
    this.dialog = new itemUseDialogHtml();
    this.close_button = new itemUseDialogCloseButton();
    this.menu_title = new itemUseDiscription();
    this.set_title = new useSetDiscription();
    this.have_title = new useHaveDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.close_button);
    this.addChild(this.menu_title);
    this.addChild(this.set_title);
    this.addChild(this.have_title);
    this.item_list = {};
    this.set_item_list = {};
    for (i = _i = 1; _i <= 9; i = ++_i) {
      this.item_list[i] = new useItemHtml(i);
    }
    for (i = _j = 1, _ref = this.max_set_item_num; 1 <= _ref ? _j <= _ref : _j >= _ref; i = 1 <= _ref ? ++_j : --_j) {
      this.set_item_list[i] = new setItemHtml(i);
      this.addChild(this.set_item_list[i]);
    }
    this.setItemList();
    this.dspSetItemList();
  }

  pauseItemUseLayer.prototype.setItemList = function() {
    var item_key, item_val, _ref, _results;
    _ref = this.item_list;
    _results = [];
    for (item_key in _ref) {
      item_val = _ref[item_key];
      this.addChild(item_val);
      _results.push(item_val.setPosition());
    }
    return _results;
  };

  pauseItemUseLayer.prototype.resetItemList = function() {
    var item_key, item_val, _ref, _results;
    _ref = this.item_list;
    _results = [];
    for (item_key in _ref) {
      item_val = _ref[item_key];
      if (game.item_set_now.indexOf(parseInt(item_key)) !== -1) {
        item_val.opacity = 0;
        item_val.changeNotButton();
        _results.push(item_val.is_exist = false);
      } else if (game.item_have_now.indexOf(parseInt(item_key)) !== -1) {
        item_val.opacity = 1;
        item_val.removeDomClass('grayscale', true);
        item_val.changeIsButton();
        _results.push(item_val.is_exist = true);
      } else {
        item_val.opacity = 0.5;
        item_val.addDomClass('grayscale', true);
        item_val.changeNotButton();
        _results.push(item_val.is_exist = false);
      }
    }
    return _results;
  };

  pauseItemUseLayer.prototype.dspSetItemList = function() {
    var item_key, item_val, _ref, _results;
    this.resetItemList();
    _ref = this.set_item_list;
    _results = [];
    for (item_key in _ref) {
      item_val = _ref[item_key];
      item_val.setPosition();
      if (game.item_set_now[item_key - 1] !== void 0) {
        _results.push(item_val.setItemKind(game.item_set_now[item_key - 1]));
      } else {
        _results.push(item_val.setItemKind(0));
      }
    }
    return _results;
  };

  return pauseItemUseLayer;

})(appDomLayer);

pauseItemUseSelectLayer = (function(_super) {
  __extends(pauseItemUseSelectLayer, _super);

  function pauseItemUseSelectLayer() {
    pauseItemUseSelectLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new itemUseSelectDialogHtml();
    this.cancel_button = new itemUseCancelButtonHtml();
    this.set_button = new itemUseSetButtonHtml();
    this.item_name = new itemNameDiscription();
    this.item_image = new selectItemImage();
    this.item_discription = new itemDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.cancel_button);
    this.addChild(this.set_button);
    this.addChild(this.item_image);
    this.addChild(this.item_name);
    this.addChild(this.item_discription);
  }

  pauseItemUseSelectLayer.prototype.setSelectItem = function(kind) {
    var discription;
    this.set_button.setText(kind);
    this.item_kind = kind;
    this.item_options = game.slot_setting.item_list[kind];
    if (this.item_options === void 0) {
      this.item_options = game.slot_setting.item_list[0];
    }
    this.item_name.setText(this.item_options.name);
    this.item_image.setImage(this.item_options.image);
    discription = this._setDiscription();
    return this.item_discription.setText(discription);
  };

  pauseItemUseSelectLayer.prototype._setDiscription = function() {
    var text;
    text = '効果：' + this.item_options.discription;
    if (this.item_options.durationSec !== void 0) {
      text += '<br>持続時間：' + this.item_options.durationSec + '秒';
    }
    return text;
  };

  pauseItemUseSelectLayer.prototype.setItem = function() {
    this._itemSet(this.item_kind);
    game.main_scene.gp_system.itemDsp();
    game.pause_scene.pause_item_use_layer.dspSetItemList();
    return game.pause_scene.removeItemUseSelectMenu();
  };

  pauseItemUseSelectLayer.prototype._itemSet = function(kind) {
    if (game.item_set_now.indexOf(parseInt(kind)) === -1) {
      if (game.pause_scene.pause_item_use_layer.max_set_item_num <= game.item_set_now.length) {
        game.item_set_now.shift();
      }
      return game.item_set_now.push(kind);
    } else {
      game.item_set_now = game.arrayValueDel(game.item_set_now, kind);
      return game.main_scene.gp_system.prevItem = 0;
    }
  };

  return pauseItemUseSelectLayer;

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
    this.record_button = new recordButtonHtml();
    this.addChild(this.return_game_button);
    this.addChild(this.save_game_button);
    this.addChild(this.buy_item_button);
    this.addChild(this.use_item_button);
    this.addChild(this.set_member_button);
    this.addChild(this.record_button);
    this.y = -20;
  }

  return pauseMainLayer;

})(appDomLayer);

pauseMemberSetLayer = (function(_super) {
  __extends(pauseMemberSetLayer, _super);

  function pauseMemberSetLayer() {
    var i, _i, _j, _ref;
    pauseMemberSetLayer.__super__.constructor.apply(this, arguments);
    this.max_set_member_num = 3;
    this.dialog = new memberSetDialogHtml();
    this.close_button = new memberSetDialogCloseButton();
    this.menu_title = new memberSetDiscription();
    this.set_title = new useSetDiscription();
    this.have_title = new useHaveDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.close_button);
    this.addChild(this.menu_title);
    this.addChild(this.set_title);
    this.addChild(this.have_title);
    this.member_list = {};
    this.set_member_list = {};
    for (i = _i = 11; _i <= 19; i = ++_i) {
      this.member_list[i] = new useMemberHtml(i);
    }
    for (i = _j = 1, _ref = this.max_set_member_num; 1 <= _ref ? _j <= _ref : _j >= _ref; i = 1 <= _ref ? ++_j : --_j) {
      this.set_member_list[i] = new setMemberHtml(i);
      this.addChild(this.set_member_list[i]);
    }
    this.setItemList();
    this.dispSetMemberList();
  }

  pauseMemberSetLayer.prototype.setItemList = function() {
    var member_key, member_val, _ref, _results;
    _ref = this.member_list;
    _results = [];
    for (member_key in _ref) {
      member_val = _ref[member_key];
      this.addChild(member_val);
      _results.push(member_val.setPosition());
    }
    return _results;
  };

  pauseMemberSetLayer.prototype.resetItemList = function() {
    var member_key, member_val, _ref, _results;
    _ref = this.member_list;
    _results = [];
    for (member_key in _ref) {
      member_val = _ref[member_key];
      if (game.member_set_now.indexOf(parseInt(member_key)) !== -1) {
        member_val.opacity = 0;
        member_val.changeNotButton();
        _results.push(member_val.is_exist = false);
      } else if (game.item_have_now.indexOf(parseInt(member_key)) !== -1) {
        member_val.opacity = 1;
        member_val.removeDomClass('grayscale', true);
        member_val.changeIsButton();
        _results.push(member_val.is_exist = true);
      } else {
        member_val.opacity = 0.5;
        member_val.addDomClass('grayscale', true);
        member_val.changeNotButton();
        _results.push(member_val.is_exist = false);
      }
    }
    return _results;
  };

  pauseMemberSetLayer.prototype.dispSetMemberList = function() {
    var member_key, member_val, _ref, _results;
    this.resetItemList();
    _ref = this.set_member_list;
    _results = [];
    for (member_key in _ref) {
      member_val = _ref[member_key];
      member_val.setPosition();
      if (game.member_set_now[member_key - 1] !== void 0) {
        member_val.setItemKind(game.member_set_now[member_key - 1]);
        member_val.opacity = 1;
        _results.push(member_val.disabled = false);
      } else {
        if (member_key === '1' && game.slot_setting.now_muse_num !== 0) {
          member_val.setItemKind(game.slot_setting.now_muse_num);
          member_val.opacity = 0.5;
          member_val.disabled = true;
          _results.push(member_val.changeNotButton());
        } else {
          member_val.setItemKind(10);
          member_val.opacity = 1;
          _results.push(member_val.disabled = false);
        }
      }
    }
    return _results;
  };

  return pauseMemberSetLayer;

})(appDomLayer);

pauseMemberUseSelectLayer = (function(_super) {
  __extends(pauseMemberUseSelectLayer, _super);

  function pauseMemberUseSelectLayer() {
    pauseMemberUseSelectLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new memberUseSelectDialogHtml();
    this.cancel_button = new memberUseCancelButtonHtml();
    this.set_button = new memberUseSetButtonHtml();
    this.item_name = new itemNameDiscription();
    this.item_image = new selectItemImage();
    this.item_discription = new itemDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.cancel_button);
    this.addChild(this.set_button);
    this.addChild(this.item_image);
    this.addChild(this.item_name);
    this.addChild(this.item_discription);
  }

  pauseMemberUseSelectLayer.prototype.setSelectItem = function(kind) {
    var discription;
    this.set_button.setText(kind);
    this.item_kind = kind;
    this.item_options = game.slot_setting.item_list[kind];
    if (this.item_options === void 0) {
      this.item_options = game.slot_setting.item_list[0];
    }
    this.item_name.setText(this.item_options.name);
    this.item_image.setImage(this.item_options.image);
    discription = this._setDiscription();
    return this.item_discription.setText(discription);
  };

  pauseMemberUseSelectLayer.prototype._setDiscription = function() {
    var text;
    text = '効果：' + this.item_options.discription;
    return text;
  };

  pauseMemberUseSelectLayer.prototype.setMember = function() {
    this._memberSet(this.item_kind);
    game.pause_scene.pause_member_set_layer.dispSetMemberList();
    return game.pause_scene.removeMemberUseSelectMenu();
  };

  pauseMemberUseSelectLayer.prototype._memberSet = function(kind) {
    if (game.member_set_now.indexOf(parseInt(kind)) === -1) {
      if (game.pause_scene.pause_member_set_layer.max_set_member_num <= game.member_set_now.length) {
        game.member_set_now.shift();
      }
      return game.member_set_now.push(kind);
    } else {
      return game.member_set_now = game.arrayValueDel(game.member_set_now, kind);
    }
  };

  return pauseMemberUseSelectLayer;

})(appDomLayer);

pauseRecordLayer = (function(_super) {
  __extends(pauseRecordLayer, _super);

  function pauseRecordLayer() {
    var i, kind, position, _i, _j, _len, _ref;
    pauseRecordLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new recordDialogHtml();
    this.close_button = new recordDialogCloseButton();
    this.record_title = new recordDiscription();
    this.trophy_title = new trophyDiscription();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.close_button);
    this.addChild(this.record_title);
    this.addChild(this.trophy_title);
    this.recordList = {};
    this.trophyList = {};
    this.bgmList = game.slot_setting.bgm_list;
    this.bgmList = game.slot_setting.bgm_list;
    _ref = this.bgmList;
    for (position = _i = 0, _len = _ref.length; _i < _len; position = ++_i) {
      kind = _ref[position];
      this.recordList[position] = new recordItemHtml(position, kind);
    }
    for (i = _j = 21; _j <= 24; i = ++_j) {
      this.trophyList[i] = new trophyItemHtml(i - 21, i);
    }
    this.setRecordList();
    this.setTrophyList();
  }

  pauseRecordLayer.prototype.setRecordList = function() {
    var record_key, record_val, _ref, _results;
    _ref = this.recordList;
    _results = [];
    for (record_key in _ref) {
      record_val = _ref[record_key];
      this.addChild(record_val);
      _results.push(record_val.setPosition());
    }
    return _results;
  };

  pauseRecordLayer.prototype.setTrophyList = function() {
    var trophy_key, trophy_val, _ref, _results;
    _ref = this.trophyList;
    _results = [];
    for (trophy_key in _ref) {
      trophy_val = _ref[trophy_key];
      this.addChild(trophy_val);
      _results.push(trophy_val.setPosition());
    }
    return _results;
  };

  return pauseRecordLayer;

})(appDomLayer);

pauseBaseRecordSelectLayer = (function(_super) {
  __extends(pauseBaseRecordSelectLayer, _super);

  function pauseBaseRecordSelectLayer() {
    pauseBaseRecordSelectLayer.__super__.constructor.apply(this, arguments);
    this.dialog = new recordSelectDialogHtml();
    this.item_name = new itemNameDiscription();
    this.item_image = new selectItemImage();
    this.item_discription = new itemDiscription();
  }

  return pauseBaseRecordSelectLayer;

})(appDomLayer);

pauseRecordSelectLayer = (function(_super) {
  __extends(pauseRecordSelectLayer, _super);

  function pauseRecordSelectLayer() {
    pauseRecordSelectLayer.__super__.constructor.apply(this, arguments);
    this.ok_button = new recordOkButtonHtml();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.ok_button);
    this.addChild(this.item_image);
    this.addChild(this.item_name);
    this.addChild(this.item_discription);
  }

  pauseRecordSelectLayer.prototype.setSelectItem = function(kind) {
    var discription;
    this.item_options = game.slot_setting.muse_material_list[kind].bgm[0];
    this.item_name.setText(this.item_options.title);
    this.item_image.setImage(this.item_options.image);
    discription = this._setDiscription();
    return this.item_discription.setText(discription);
  };

  pauseRecordSelectLayer.prototype._setDiscription = function() {
    var text;
    text = 'ユニット：' + this.item_options.unit;
    return text;
  };

  return pauseRecordSelectLayer;

})(pauseBaseRecordSelectLayer);

pauseTrophySelectLayer = (function(_super) {
  __extends(pauseTrophySelectLayer, _super);

  function pauseTrophySelectLayer() {
    pauseTrophySelectLayer.__super__.constructor.apply(this, arguments);
    this.ok_button = new trophyOkButtonHtml();
    this.addChild(this.modal);
    this.addChild(this.dialog);
    this.addChild(this.ok_button);
    this.addChild(this.item_image);
    this.addChild(this.item_name);
    this.addChild(this.item_discription);
  }

  pauseTrophySelectLayer.prototype.setSelectItem = function(kind) {
    var discription;
    this.item_options = game.slot_setting.item_list[kind];
    this.item_name.setText(this.item_options.name);
    this.item_image.setImage(this.item_options.image);
    discription = this._setDiscription();
    return this.item_discription.setText(discription);
  };

  pauseTrophySelectLayer.prototype._setDiscription = function() {
    var text;
    text = '効果：' + this.item_options.discription;
    text += '<br>値段：' + game.toJPUnit(this.item_options.price) + '円';
    text += '<br>出現条件：' + this.item_options.conditoin;
    return text;
  };

  return pauseTrophySelectLayer;

})(pauseBaseRecordSelectLayer);

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
    this.imgList = ['chun', 'sweets', 'lille', 'okujou', 'sky', 'coin', 'frame', 'pause', 'chance', 'fever', 'kira', 'big-kotori', 'heart', 'explosion', 'items', 'coin_pla'];
    this.soundList = ['dicision', 'medal', 'select', 'start', 'cancel', 'jump', 'clear', 'explosion', 'bgm/bgm1'];
    this.keybind(90, 'z');
    this.keybind(88, 'x');
    this.preloadAll();
    this.money_init = 100;
    this.fever = false;
    this.fever_down_tension = 0;
    this.item_kind = 0;
    this.fever_hit_eye = 0;
    this.now_item = 0;
    this.already_added_material = [];
    this.money = 0;
    this.bet = 1;
    this.combo = 0;
    this.tension = 0;
    this.item_point = 500;
    this.past_fever_num = 0;
    this.next_add_member_key = 0;
    this.item_have_now = [];
    this.item_set_now = [];
    this.member_set_now = [];
    this.prev_fever_muse = [];
    this.money = this.money_init;
  }

  LoveliveGame.prototype.onload = function() {
    this.title_scene = new titleScene();
    this.main_scene = new mainScene();
    this.pause_scene = new pauseScene();
    this.loadGame();
    if (this.test.test_exe_flg === true) {
      this.test_scene = new testScene();
      this.pushScene(this.test_scene);
      return this.test.testExe();
    } else {
      if (this.debug.force_main_flg === true) {
        this.bgmPlay(this.main_scene.bgm, true);
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
  現在セットされているメンバーをもとに素材をロードします
   */

  LoveliveGame.prototype.musePreLoadByMemberSetNow = function() {
    var roles;
    roles = this.getRoleByMemberSetNow();
    return this.musePreLoadMulti(roles);
  };


  /*
  現在セットされているメンバーをもとに組み合わせ可能な役の一覧を全て取得します
   */

  LoveliveGame.prototype.getRoleByMemberSetNow = function() {
    var roles, tmp;
    roles = game.arrayCopy(this.member_set_now);
    tmp = this.member_set_now;
    roles.push(this.slot_setting.getHitRole(tmp[0], tmp[1], tmp[2]));
    roles.push(this.slot_setting.getHitRole(tmp[1], tmp[1], tmp[2]));
    roles.push(this.slot_setting.getHitRole(tmp[0], tmp[0], tmp[2]));
    roles.push(this.slot_setting.getHitRole(tmp[0], tmp[0], tmp[1]));
    roles = this.getDeduplicationList(roles);
    roles = this.arrayValueDel(roles, 20);
    return roles;
  };


  /*
  配列で指定して複数のμ’ｓ素材を一括でロードします
  @param array nums 配列でロードする素材番号の指定
   */

  LoveliveGame.prototype.musePreLoadMulti = function(nums) {
    var key, val, _results;
    _results = [];
    for (key in nums) {
      val = nums[key];
      if (this.already_added_material.indexOf(val) === -1) {
        _results.push(this.musePreLoad(val));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };


  /*
  スロットにμ’ｓを挿入するときに必要なカットイン画像や音楽を予めロードしておく
  @param number num ロードする素材番号の指定
   */

  LoveliveGame.prototype.musePreLoad = function(num) {
    var key, material, muse_num, val, _ref, _ref1;
    if (num == null) {
      num = 0;
    }
    if (num === 0) {
      muse_num = this.slot_setting.now_muse_num;
    } else {
      muse_num = num;
    }
    this.already_added_material.push(muse_num);
    if (this.slot_setting.muse_material_list[muse_num] !== void 0) {
      material = this.slot_setting.muse_material_list[muse_num];
      if (material['cut_in'] !== void 0 && material['cut_in'].length > 0) {
        _ref = material['cut_in'];
        for (key in _ref) {
          val = _ref[key];
          this.appLoad('images/cut_in/' + val.name + '.png');
        }
      }
      if (material['voice'] !== void 0 && material['voice'].length > 0) {
        _ref1 = material['voice'];
        for (key in _ref1) {
          val = _ref1[key];
          this.appLoad('sounds/voice/' + val + '.mp3');
        }
      }
      if (material['bgm'] !== void 0 && material['bgm'].length > 0) {
        return this.appLoad('sounds/bgm/' + material['bgm'][0]['name'] + '.mp3');
      }
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
  現在アイテムがセットされているかを確認する
   */

  LoveliveGame.prototype.isItemSet = function(kind) {
    var rslt;
    rslt = false;
    if (game.item_set_now.indexOf(kind) !== -1) {
      rslt = true;
    }
    return rslt;
  };


  /*
  アイテムの効果を発動する
   */

  LoveliveGame.prototype.itemUseExe = function() {
    if (this.isItemSet(1)) {
      this.main_scene.gp_stage_front.player.setMxUp();
    } else {
      this.main_scene.gp_stage_front.player.resetMxUp();
    }
    if (this.isItemSet(3)) {
      return this.main_scene.gp_stage_front.player.setMyUp();
    } else {
      return this.main_scene.gp_stage_front.player.resetMyUp();
    }
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
  @param number hit_eye     当たった目の番号
   */

  LoveliveGame.prototype.tensionSetValueSlotHit = function(hit_eye) {
    var val;
    val = this.slot_setting.setTensionSlotHit(hit_eye);
    return this.tensionSetValue(val);
  };


  /*
  ポーズシーンをセットする
   */

  LoveliveGame.prototype.setPauseScene = function() {
    this.pause_scene.keyList.pause = true;
    this.pushScene(this.pause_scene);
    this.pause_scene.pause_item_buy_layer.resetItemList();
    return this.nowPlayBgmPause();
  };


  /*
  ポーズシーンをポップする
   */

  LoveliveGame.prototype.popPauseScene = function() {
    this.pause_scene.buttonList.pause = false;
    this.main_scene.keyList.pause = true;
    this.popScene(this.pause_scene);
    return this.nowPlayBgmRestart();
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
    }
    return this._gameInitSetting();
  };


  /*
  ロードするデータの空の値
   */

  LoveliveGame.prototype._defaultLoadData = function(key) {
    var data, ret;
    data = {
      'money': 0,
      'bet': 0,
      'combo': 0,
      'tension': 0,
      'past_fever_num': 0,
      'item_point': 0,
      'prev_muse': '[]',
      'now_muse_num': 0,
      'next_add_member_key': 0,
      'left_lille': '[]',
      'middle_lille': '[]',
      'right_lille': '[]',
      'item_have_now': '[]',
      'item_set_now': '[]',
      'member_set_now': '[]',
      'prev_fever_muse': '[]'
    };
    ret = null;
    if (data[key] === void 0) {
      console.error(key + 'のデータのロードに失敗しました。');
      ret = data[key];
    }
    return ret;
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
      'item_point': this.item_point,
      'prev_muse': JSON.stringify(this.slot_setting.prev_muse),
      'now_muse_num': this.slot_setting.now_muse_num,
      'next_add_member_key': this.next_add_member_key,
      'left_lille': JSON.stringify(this.main_scene.gp_slot.left_lille.lilleArray),
      'middle_lille': JSON.stringify(this.main_scene.gp_slot.middle_lille.lilleArray),
      'right_lille': JSON.stringify(this.main_scene.gp_slot.right_lille.lilleArray),
      'item_have_now': JSON.stringify(this.item_have_now),
      'item_set_now': JSON.stringify(this.item_set_now),
      'member_set_now': JSON.stringify(this.member_set_now),
      'prev_fever_muse': JSON.stringify(this.prev_fever_muse)
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
      this.bet = this._loadStorage('bet', 'num');
      this.combo = this._loadStorage('combo', 'num');
      this.tension = this._loadStorage('tension', 'num');
      this.past_fever_num = this._loadStorage('past_fever_num', 'num');
      this.item_point = this._loadStorage('item_point', 'num');
      this.next_add_member_key = this._loadStorage('next_add_member_key', 'num');
      this.slot_setting.prev_muse = this._loadStorage('prev_muse', 'json');
      this.slot_setting.now_muse_num = this._loadStorage('now_muse_num', 'num');
      this.main_scene.gp_slot.left_lille.lilleArray = this._loadStorage('left_lille', 'json');
      this.main_scene.gp_slot.middle_lille.lilleArray = this._loadStorage('middle_lille', 'json');
      this.main_scene.gp_slot.right_lille.lilleArray = this._loadStorage('right_lille', 'json');
      this.item_have_now = this._loadStorage('item_have_now', 'json');
      this.item_set_now = this._loadStorage('item_set_now', 'json');
      this.member_set_now = this._loadStorage('member_set_now', 'json');
      return this.prev_fever_muse = this._loadStorage('prev_fever_muse', 'json');
    }
  };


  /*
  ローカルストレージから指定のキーの値を取り出して返す
  @param string key ロードするデータのキー
  @param string type ロードするデータのタイプ（型） num json
   */

  LoveliveGame.prototype._loadStorage = function(key, type) {
    var ret, val;
    ret = null;
    val = this.local_storage.getItem(key);
    if (val === null) {
      ret = this._defaultLoadData(key);
    } else {
      switch (type) {
        case 'num':
          ret = parseInt(val);
          break;
        case 'json':
          ret = JSON.parse(val);
          break;
        default:
          ret = val;
      }
    }
    return ret;
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
    this.item_point = data.item_point;
    this.next_add_member_key = data.next_add_member_key;
    this.slot_setting.prev_muse = data.prev_muse;
    this.slot_setting.now_muse_num = data.now_muse_num;
    this.item_have_now = data.item_have_now;
    this.item_set_now = data.item_set_now;
    this.prev_fever_muse = data.prev_fever_muse;
    return this.member_set_now = data.member_set_now;
  };


  /*
  ゲームロード後の画面表示等の初期値設定
   */

  LoveliveGame.prototype._gameInitSetting = function() {
    var sys;
    if (this.slot_setting.now_muse_num === 0) {
      this.slot_setting.setMuseMember();
    }
    this.musePreLoad();
    sys = this.main_scene.gp_system;
    sys.money_text.setValue();
    sys.bet_text.setValue();
    sys.combo_text.setValue();
    sys.tension_gauge.setValue();
    sys.itemDsp();
    this.pause_scene.pause_item_buy_layer.resetItemList();
    this.pause_scene.pause_item_use_layer.dspSetItemList();
    this.pause_scene.pause_member_set_layer.dispSetMemberList();
    this.slot_setting.setMemberItemPrice();
    this.slot_setting.setItemPointValue();
    this.musePreLoadByMemberSetNow();
    return this.itemUseExe();
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
    this.item_catch_effect = [];
  }

  gpEffect.prototype.cutInSet = function(num) {
    var setting;
    if (num == null) {
      num = 0;
    }
    setting = game.slot_setting;
    if (setting.muse_material_list[setting.now_muse_num] !== void 0) {
      this.cut_in = new cutIn(num);
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

  gpEffect.prototype.setItemChatchEffect = function(x, y) {
    var i, _i, _results;
    this.item_catch_effect = [];
    _results = [];
    for (i = _i = 1; _i <= 4; i = ++_i) {
      this.item_catch_effect.push(new itemCatchEffect(i, x, y));
      _results.push(this.addChild(this.item_catch_effect[i - 1]));
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
    this.back_effect_rate = 200;
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
        this.forceHitLeftLille();
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


  /*
  確率で左のスロットを強制的にμ'sにする
   */

  gpSlot.prototype.forceHitLeftLille = function() {
    var target, tmp_eye;
    target = this.left_lille;
    if (this.isForceSlotHit === true && game.slot_setting.isForceFever() === true) {
      tmp_eye = this._searchMuseEye(target);
      if (tmp_eye !== 0) {
        target.nowEye = tmp_eye;
        return target.frameChange();
      }
    }
  };


  /*
  スロットが強制的に当たりになるようにリールから左のリールの当たり目と同じ目を探して配列のキーを返す
  左の当たり目がμ’ｓならリールからμ’ｓの目をランダムで取り出して返す
   */

  gpSlot.prototype._searchEye = function(target) {
    var key, result, val, _ref;
    result = 0;
    if (this.leftSlotEye < 10) {
      _ref = target.lilleArray;
      for (key in _ref) {
        val = _ref[key];
        if (val === this.leftSlotEye) {
          result = key;
        }
      }
    } else {
      result = this._searchMuseEye(target);
    }
    return result;
  };


  /*
  リールからμ'sを探してきてそのキーを返します
  リールにμ'sがいなければランダムでキーを返します
  @pram target
   */

  gpSlot.prototype._searchMuseEye = function(target) {
    var arr, key, random_key, result, val, _ref;
    arr = [];
    _ref = target.lilleArray;
    for (key in _ref) {
      val = _ref[key];
      if (val > 10) {
        arr.push(key);
      }
    }
    if (arr.length > 0) {
      random_key = Math.floor(arr.length * Math.random());
      result = arr[random_key];
    } else {
      result = Math.floor(this.left_lille.lilleArray.length * Math.random());
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
      prize_money = game.slot_setting.calcPrizeMoney(this.middle_lille.lilleArray[this.middle_lille.nowEye]);
      game.tensionSetValueSlotHit(this.hit_role);
      this._feverStart(this.hit_role);
      if (this.hit_role === 1) {
        member = game.slot_setting.getAddMuseNum();
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
    if (this.hit_role > 10) {
      game.prev_fever_muse.push(this.hit_role);
      game.slot_setting.setMemberItemPrice();
    }
    return hit_flg;
  };


  /*
  フィーバーを開始する
   */

  gpSlot.prototype._feverStart = function(hit_eye) {
    if (game.fever === false) {
      if ((11 <= hit_eye && hit_eye <= 19) || (21 <= hit_eye)) {
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
    game.bgmStop(game.main_scene.bgm);
    return game.bgmPlay(this.fever_bgm, false);
  };


  /*
  揃った目の役からフィーバーのBGMを返す
   */

  gpSlot.prototype._getFeverBgm = function(hit_role) {
    var bgms, material, random;
    material = game.slot_setting.muse_material_list;
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
    return game.main_scene.gp_effect.cutInSet(num);
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
    this.left_lille.lilleArray = this._slotAddMuseAllUnit(this.left_lille.lilleArray[this.left_lille.nowEye], this.left_lille);
    this.middle_lille.lilleArray = this._slotAddMuseAllUnit(this.middle_lille.lilleArray[this.middle_lille.nowEye], this.middle_lille);
    return this.right_lille.lilleArray = this._slotAddMuseAllUnit(this.right_lille.lilleArray[this.right_lille.nowEye], this.right_lille);
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
    this.explotion_effect = new explosionEffect();
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
      if (game.isItemSet(2) === false) {
        this._missCatchFall();
      }
      return this.missItemFallSycleNow = 0;
    }
  };


  /*
  キャッチアイテムをランダムな位置から降らせる
   */

  stageFront.prototype._catchFall = function() {
    if (game.bet > game.money) {
      game.bet = 1;
      game.main_scene.gp_system.bet_text.setValue();
    }
    if (game.money >= game.bet) {
      this.catchItems.push(new MacaroonCatch());
      this.addChild(this.catchItems[this.nowCatchItemsNum]);
      this.catchItems[this.nowCatchItemsNum].setPosition();
      this.nowCatchItemsNum += 1;
      game.money -= game.bet;
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

  stageFront.prototype.setExplosionEffect = function(x, y) {
    this.addChild(this.explotion_effect);
    return this.explotion_effect.setInit(x, y);
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
      100000: 0,
      1000000: 0,
      10000000: 0
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
      100000: 0,
      1000000: 0,
      10000000: 0
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
    if (value < 100000000) {
      this.prizeMoneyFallIntervalFrm = 4;
    } else if (value < 1000000000) {
      this.prizeMoneyFallIntervalFrm = 2;
    } else {
      this.prizeMoneyFallIntervalFrm = 1;
    }
    this.prizeMoneyItemsNum = this._calcMoneyItemsNum(value, true);
    this.prizeMoneyItemsInstance = this._setMoneyItemsInstance(this.prizeMoneyItemsNum, true);
    if (this.prizeMoneyItemsNum[10000000] > 1000) {
      this.oneSetMoney = Math.floor(this.prizeMoneyItemsNum[10000000] / 1000);
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
        if (this.prizeMoneyItemsInstance[this.nowPrizeMoneyItemsNum] !== void 0) {
          this.addChild(this.prizeMoneyItemsInstance[this.nowPrizeMoneyItemsNum]);
          this.prizeMoneyItemsInstance[this.nowPrizeMoneyItemsNum].setPosition();
          this.nowPrizeMoneyItemsNum += 1;
          if (this.nowPrizeMoneyItemsNum === this.prizeMoneyItemsInstance.length) {
            this.nowPrizeMoneyItemsNum = 0;
            _results.push(this.isFallPrizeMoney = false);
          } else {
            _results.push(void 0);
          }
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
      100000: 0,
      1000000: 0,
      10000000: 0
    };
    if (value <= 20) {
      ret_data[1] = value;
      ret_data[10] = 0;
      ret_data[100] = 0;
      ret_data[1000] = 0;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
      ret_data[1000000] = 0;
      ret_data[10000000] = 0;
    } else if (value < 100) {
      ret_data[1] = game.getDigitNum(value, 1) + 10;
      ret_data[10] = game.getDigitNum(value, 2) - 1;
      ret_data[100] = 0;
      ret_data[1000] = 0;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
      ret_data[1000000] = 0;
      ret_data[10000000] = 0;
    } else if (value < 1000) {
      ret_data[1] = game.getDigitNum(value, 1);
      ret_data[10] = game.getDigitNum(value, 2) + 10;
      ret_data[100] = game.getDigitNum(value, 3) - 1;
      ret_data[1000] = 0;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
      ret_data[1000000] = 0;
      ret_data[10000000] = 0;
    } else if (value < 10000) {
      ret_data[1] = game.getDigitNum(value, 1);
      ret_data[10] = game.getDigitNum(value, 2);
      ret_data[100] = game.getDigitNum(value, 3) + 10;
      ret_data[1000] = game.getDigitNum(value, 4) - 1;
      ret_data[10000] = 0;
      ret_data[100000] = 0;
      ret_data[1000000] = 0;
      ret_data[10000000] = 0;
    } else if (value < 100000) {
      ret_data[1] = 0;
      ret_data[10] = game.getDigitNum(value, 2);
      ret_data[100] = game.getDigitNum(value, 3);
      ret_data[1000] = game.getDigitNum(value, 4) + 10;
      ret_data[10000] = game.getDigitNum(value, 5) - 1;
      ret_data[100000] = 0;
      ret_data[1000000] = 0;
      ret_data[10000000] = 0;
    } else if (value < 1000000) {
      ret_data[1] = 0;
      ret_data[10] = 0;
      ret_data[100] = game.getDigitNum(value, 3);
      ret_data[1000] = game.getDigitNum(value, 4);
      ret_data[10000] = game.getDigitNum(value, 5) + 10;
      ret_data[100000] = game.getDigitNum(value, 6) - 1;
      ret_data[1000000] = 0;
      ret_data[10000000] = 0;
    } else if (value < 10000000) {
      ret_data[1] = 0;
      ret_data[10] = 0;
      ret_data[100] = 0;
      ret_data[1000] = game.getDigitNum(value, 4);
      ret_data[10000] = game.getDigitNum(value, 5);
      ret_data[100000] = game.getDigitNum(value, 6) + 10;
      ret_data[1000000] = game.getDigitNum(value, 7) - 1;
      ret_data[10000000] = 0;
    } else {
      ret_data[1] = 0;
      ret_data[10] = 0;
      ret_data[100] = 0;
      ret_data[1000] = 0;
      ret_data[10000] = game.getDigitNum(value, 5);
      ret_data[100000] = game.getDigitNum(value, 6);
      ret_data[1000000] = game.getDigitNum(value, 7) + 10;
      ret_data[10000000] = Math.floor(value / 10000000);
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
    var i, ret_data, _i, _j, _k, _l, _m, _n, _o, _p, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;
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
    if (itemsNum[1000000] > 0) {
      for (i = _o = 1, _ref6 = itemsNum[1000000]; 1 <= _ref6 ? _o <= _ref6 : _o >= _ref6; i = 1 <= _ref6 ? ++_o : --_o) {
        ret_data.push(new OneMillionMoney(isHoming));
      }
    }
    if (itemsNum[10000000] > 0) {
      for (i = _p = 1, _ref7 = itemsNum[10000000]; 1 <= _ref7 ? _p <= _ref7 : _p >= _ref7; i = 1 <= _ref7 ? ++_p : --_p) {
        ret_data.push(new TenMillionMoney(isHoming));
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
    } else if (val < 1000000) {
      val = Math.floor(val / 100000) * 100000;
    } else if (val < 10000000) {
      val = Math.floor(val / 1000000) * 1000000;
    } else {
      val = Math.floor(val / 10000000) * 10000000;
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
    this.prevItem = 0;
  }

  gpSystem.prototype.onenterframe = function(e) {
    this._betSetting();
    return this._setItemPoint();
  };


  /*
  キーの上下を押して掛け金を設定する
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
      } else if (bet < 1000000) {
        val = 100000;
      } else if (bet < 10000000) {
        val = 1000000;
      } else if (bet < 100000000) {
        val = 10000000;
      } else {
        val = 100000000;
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
      } else if (bet <= 1000000) {
        val = -100000;
      } else if (bet <= 10000000) {
        val = -1000000;
      } else if (bet <= 100000000) {
        val = -10000000;
      } else {
        val = -100000000;
      }
    }
    game.bet += val;
    if (game.bet < 1) {
      game.bet = 1;
    } else if (game.bet > game.money) {
      game.bet -= val;
    } else if (game.bet > 100000000000) {
      game.bet = 100000000000;
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


  /*
  セットしているアイテムを表示する
   */

  gpSystem.prototype.itemDsp = function() {
    if (game.item_set_now[0] !== void 0) {
      this.item_slot.frame = game.item_set_now[0];
      return game.now_item = game.item_set_now[0];
    } else {
      this.item_slot.frame = 0;
      return game.now_item = 0;
    }
  };


  /*
  リアルタイムでアイテムゲージの増減をします
  アイテムスロットが空なら一定時間で回復し、全回復したら前にセットしていたアイテムを自動的にセットします
  アイテムスロットにアイテムが入っていたら、入っているアイテムによって一定時間で減少し、全てなくなったら自動的にアイテムを解除します
   */

  gpSystem.prototype._setItemPoint = function() {
    if (game.now_item === 0) {
      if (game.item_point < game.slot_setting.item_point_max) {
        game.item_point = Math.floor(1000 * (game.item_point + game.slot_setting.item_point_value[0])) / 1000;
        if (game.slot_setting.item_point_max < game.item_point) {
          game.item_point = game.slot_setting.item_point_max;
          if (this.prevItem !== 0) {
            game.item_set_now.push(this.prevItem);
            this.itemDsp();
            game.pause_scene.pause_item_use_layer.dspSetItemList();
            game.itemUseExe();
          }
        }
      }
    } else {
      if (0 < game.item_point) {
        game.item_point = Math.floor(1000 * (game.item_point - game.slot_setting.item_point_value[game.now_item])) / 1000;
        if (game.item_point < 0) {
          game.item_point = 0;
          this._resetItem();
        }
      }
    }
    this.item_gauge.scaleX = Math.floor(100 * (game.item_point / game.slot_setting.item_point_max)) / 100;
    return this.item_gauge.x = this.item_gauge.initX - Math.floor(this.item_gauge.w * (1 - this.item_gauge.scaleX) / 2);
  };

  gpSystem.prototype._resetItem = function() {
    this.prevItem = game.now_item;
    game.item_set_now = [];
    this.itemDsp();
    game.pause_scene.pause_item_use_layer.dspSetItemList();
    return game.itemUseExe();
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
    var tmp_cls, val, _i, _len, _ref;
    tmp_cls = '';
    _ref = this["class"];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      val = _ref[_i];
      tmp_cls += val + ' ';
    }
    if (this.is_button === true) {
      tmp_cls += 'image-button';
    }
    return this._element.innerHTML = '<img src="images/html/' + this.image_name + '.png" class="' + tmp_cls + '"></img>';
  };

  systemHtml.prototype.changeNotButton = function() {
    this.is_button = false;
    return this.setImageHtml();
  };

  systemHtml.prototype.changeIsButton = function() {
    this.is_button = true;
    return this.setImageHtml();
  };

  systemHtml.prototype.addDomClass = function(cls, isImg) {
    if (isImg == null) {
      isImg = false;
    }
    if (this["class"].indexOf(cls) === -1) {
      this["class"].push(cls);
      return this._setHtml(isImg);
    }
  };

  systemHtml.prototype.removeDomClass = function(cls, isImg) {
    var key, val, _i, _len, _ref;
    if (isImg == null) {
      isImg = false;
    }
    _ref = this["class"];
    for (key = _i = 0, _len = _ref.length; _i < _len; key = ++_i) {
      val = _ref[key];
      if (val === cls) {
        this["class"].splice(key, 1);
      }
    }
    return this._setHtml(isImg);
  };

  systemHtml.prototype._setHtml = function(isImg) {
    if (isImg == null) {
      isImg = false;
    }
    if (isImg === true) {
      return this.setImageHtml();
    } else {
      return this.setHtml();
    }
  };

  return systemHtml;

})(appHtml);

buttonHtml = (function(_super) {
  __extends(buttonHtml, _super);

  function buttonHtml(width, height) {
    buttonHtml.__super__.constructor.call(this, width, height);
    this["class"] = ['base-button'];
    this.dicisionSe = game.soundload('dicision');
    this.cancelSe = game.soundload('cancel');
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
    game.sePlay(this.cancelSe);
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
    game.sePlay(this.dicisionSe);
    return game.pause_scene.setSaveMenu();
  };

  return saveGameButtonHtml;

})(pauseMainMenuButtonHtml);

buyItemButtonHtml = (function(_super) {
  __extends(buyItemButtonHtml, _super);

  function buyItemButtonHtml() {
    buyItemButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 300;
    this.text = 'アイテムを買う';
    this.setHtml();
  }

  buyItemButtonHtml.prototype.touchendEvent = function() {
    game.sePlay(this.dicisionSe);
    return game.pause_scene.setItemBuyMenu();
  };

  return buyItemButtonHtml;

})(pauseMainMenuButtonHtml);

useItemButtonHtml = (function(_super) {
  __extends(useItemButtonHtml, _super);

  function useItemButtonHtml() {
    useItemButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 400;
    this.text = '魔法をセットする';
    this.setHtml();
  }

  useItemButtonHtml.prototype.touchendEvent = function() {
    game.sePlay(this.dicisionSe);
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
    game.sePlay(this.dicisionSe);
    return game.pause_scene.setMemberSetMenu();
  };

  return setMemberButtonHtml;

})(pauseMainMenuButtonHtml);

recordButtonHtml = (function(_super) {
  __extends(recordButtonHtml, _super);

  function recordButtonHtml() {
    recordButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 600;
    this.text = '実績を確認する';
    this.setHtml();
  }

  recordButtonHtml.prototype.touchendEvent = function() {
    game.sePlay(this.dicisionSe);
    return game.pause_scene.setRecordMenu();
  };

  return recordButtonHtml;

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
    game.sePlay(this.dicisionSe);
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

recordOkButtonHtml = (function(_super) {
  __extends(recordOkButtonHtml, _super);

  function recordOkButtonHtml() {
    recordOkButtonHtml.__super__.constructor.apply(this, arguments);
    this.x = 170;
    this.y = 480;
  }

  recordOkButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeRecordSelectMenu();
  };

  return recordOkButtonHtml;

})(baseOkButtonHtml);

trophyOkButtonHtml = (function(_super) {
  __extends(trophyOkButtonHtml, _super);

  function trophyOkButtonHtml() {
    trophyOkButtonHtml.__super__.constructor.apply(this, arguments);
    this.x = 170;
    this.y = 480;
  }

  trophyOkButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeTrophySelectmenu();
  };

  return trophyOkButtonHtml;

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
    game.sePlay(this.cancelSe);
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
    this.y = 500;
  }

  itemBuyCancelButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeItemBuySelectMenu();
  };

  itemBuyCancelButtonHtml.prototype.setBuyImpossiblePositon = function() {
    return this.x = 170;
  };

  itemBuyCancelButtonHtml.prototype.setBuyPossiblePosition = function() {
    return this.x = 250;
  };

  return itemBuyCancelButtonHtml;

})(baseCancelButtonHtml);


/*
アイテム使用のキャンセルボタン
 */

itemUseCancelButtonHtml = (function(_super) {
  __extends(itemUseCancelButtonHtml, _super);

  function itemUseCancelButtonHtml() {
    itemUseCancelButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 500;
    this.x = 250;
  }

  itemUseCancelButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeItemUseSelectMenu();
  };

  return itemUseCancelButtonHtml;

})(baseCancelButtonHtml);


/*
部員使用のキャンセルボタン
 */

memberUseCancelButtonHtml = (function(_super) {
  __extends(memberUseCancelButtonHtml, _super);

  function memberUseCancelButtonHtml() {
    memberUseCancelButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 500;
    this.x = 250;
  }

  memberUseCancelButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.removeMemberUseSelectMenu();
  };

  return memberUseCancelButtonHtml;

})(baseCancelButtonHtml);


/*
購入ボタン
 */

baseByuButtonHtml = (function(_super) {
  __extends(baseByuButtonHtml, _super);

  function baseByuButtonHtml() {
    baseByuButtonHtml.__super__.constructor.call(this, 150, 45);
    this["class"].push('base-buy-button');
    this.text = '購入';
    this.setHtml();
  }

  baseByuButtonHtml.prototype.ontouchend = function(e) {
    game.sePlay(this.dicisionSe);
    return this.touchendEvent();
  };

  return baseByuButtonHtml;

})(buttonHtml);


/*
アイテム購入の購入ボタン
 */

itemBuyBuyButtonHtml = (function(_super) {
  __extends(itemBuyBuyButtonHtml, _super);

  function itemBuyBuyButtonHtml() {
    itemBuyBuyButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 500;
  }

  itemBuyBuyButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.pause_item_buy_select_layer.buyItem();
  };

  itemBuyBuyButtonHtml.prototype.setBuyImpossiblePositon = function() {
    return this.x = -200;
  };

  itemBuyBuyButtonHtml.prototype.setBuyPossiblePosition = function() {
    return this.x = 70;
  };

  return itemBuyBuyButtonHtml;

})(baseByuButtonHtml);


/*
セットボタン
 */

baseSetButtonHtml = (function(_super) {
  __extends(baseSetButtonHtml, _super);

  function baseSetButtonHtml() {
    baseSetButtonHtml.__super__.constructor.call(this, 150, 45);
    this["class"].push('base-set-button');
    this.text = 'セット';
    this.setHtml();
  }

  baseSetButtonHtml.prototype.ontouchend = function(e) {
    game.sePlay(this.dicisionSe);
    return this.touchendEvent();
  };

  return baseSetButtonHtml;

})(buttonHtml);


/*
アイテム使用のセットボタン
 */

itemUseSetButtonHtml = (function(_super) {
  __extends(itemUseSetButtonHtml, _super);

  function itemUseSetButtonHtml() {
    itemUseSetButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 500;
    this.x = 70;
  }

  itemUseSetButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.pause_item_use_select_layer.setItem();
  };

  itemUseSetButtonHtml.prototype.setText = function(kind) {
    if (game.item_set_now.indexOf(parseInt(kind)) !== -1) {
      this.text = '解除';
      return this.setHtml();
    } else {
      this.text = 'セット';
      return this.setHtml();
    }
  };

  return itemUseSetButtonHtml;

})(baseSetButtonHtml);


/*
部員使用のセットボタン
 */

memberUseSetButtonHtml = (function(_super) {
  __extends(memberUseSetButtonHtml, _super);

  function memberUseSetButtonHtml() {
    memberUseSetButtonHtml.__super__.constructor.apply(this, arguments);
    this.y = 500;
    this.x = 70;
  }

  memberUseSetButtonHtml.prototype.touchendEvent = function() {
    return game.pause_scene.pause_member_use_select_layer.setMember();
  };

  memberUseSetButtonHtml.prototype.setText = function(kind) {
    if (game.member_set_now.indexOf(parseInt(kind)) !== -1) {
      this.text = '解除';
      return this.setHtml();
    } else {
      this.text = 'セット';
      return this.setHtml();
    }
  };

  return memberUseSetButtonHtml;

})(baseSetButtonHtml);


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
    game.sePlay(this.dicisionSe);
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
    this.cancelSe = game.soundload('cancel');
  }

  return dialogCloseButton;

})(systemHtml);

itemBuyDialogCloseButton = (function(_super) {
  __extends(itemBuyDialogCloseButton, _super);

  function itemBuyDialogCloseButton() {
    itemBuyDialogCloseButton.__super__.constructor.apply(this, arguments);
    this.y = 70;
  }

  itemBuyDialogCloseButton.prototype.ontouchend = function() {
    game.sePlay(this.cancelSe);
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
    game.sePlay(this.cancelSe);
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
    game.sePlay(this.cancelSe);
    return game.pause_scene.removeMemberSetMenu();
  };

  return memberSetDialogCloseButton;

})(dialogCloseButton);

recordDialogCloseButton = (function(_super) {
  __extends(recordDialogCloseButton, _super);

  function recordDialogCloseButton() {
    recordDialogCloseButton.__super__.constructor.apply(this, arguments);
    this.y = 70;
  }

  recordDialogCloseButton.prototype.ontouchend = function() {
    game.sePlay(this.cancelSe);
    return game.pause_scene.removeRecordMenu();
  };

  return recordDialogCloseButton;

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

  function menuDialogHtml(width, height) {
    if (width == null) {
      width = 420;
    }
    if (height == null) {
      height = 460;
    }
    menuDialogHtml.__super__.constructor.call(this, width, height);
    this.text = '　';
    this.classPush();
    this.x = 25;
    this.y = 80;
    this.setHtml();
  }

  menuDialogHtml.prototype.classPush = function() {
    return this["class"].push('base-dialog-menu');
  };

  return menuDialogHtml;

})(baseDialogHtml);

itemBuyDialogHtml = (function(_super) {
  __extends(itemBuyDialogHtml, _super);

  function itemBuyDialogHtml() {
    itemBuyDialogHtml.__super__.constructor.call(this, 420, 500);
    this.y = 50;
  }

  itemBuyDialogHtml.prototype.classPush = function() {
    return this["class"].push('base-dialog-high');
  };

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

recordDialogHtml = (function(_super) {
  __extends(recordDialogHtml, _super);

  function recordDialogHtml() {
    recordDialogHtml.__super__.constructor.call(this, 420, 500);
    this.y = 50;
  }

  recordDialogHtml.prototype.classPush = function() {
    return this["class"].push('base-dialog-high');
  };

  return recordDialogHtml;

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

itemUseSelectDialogHtml = (function(_super) {
  __extends(itemUseSelectDialogHtml, _super);

  function itemUseSelectDialogHtml() {
    itemUseSelectDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return itemUseSelectDialogHtml;

})(selectDialogHtml);

memberUseSelectDialogHtml = (function(_super) {
  __extends(memberUseSelectDialogHtml, _super);

  function memberUseSelectDialogHtml() {
    memberUseSelectDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return memberUseSelectDialogHtml;

})(selectDialogHtml);

recordSelectDialogHtml = (function(_super) {
  __extends(recordSelectDialogHtml, _super);

  function recordSelectDialogHtml() {
    recordSelectDialogHtml.__super__.constructor.apply(this, arguments);
  }

  return recordSelectDialogHtml;

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

  function titleDiscription(width, height) {
    if (width == null) {
      width = 400;
    }
    if (height == null) {
      height = 20;
    }
    titleDiscription.__super__.constructor.call(this, width, height);
    this["class"].push('title-discription');
  }

  return titleDiscription;

})(discriptionTextDialogHtml);

itemItemBuyDiscription = (function(_super) {
  __extends(itemItemBuyDiscription, _super);

  function itemItemBuyDiscription() {
    itemItemBuyDiscription.__super__.constructor.call(this, 100, 20);
    this.x = 220;
    this.y = 80;
    this.text = '魔法';
    this.setHtml();
  }

  return itemItemBuyDiscription;

})(titleDiscription);

memberItemBuyDiscription = (function(_super) {
  __extends(memberItemBuyDiscription, _super);

  function memberItemBuyDiscription() {
    memberItemBuyDiscription.__super__.constructor.apply(this, arguments);
    this.x = 220;
    this.y = 310;
    this.text = '部員';
    this.setHtml();
  }

  return memberItemBuyDiscription;

})(titleDiscription);

trophyItemBuyDiscription = (function(_super) {
  __extends(trophyItemBuyDiscription, _super);

  function trophyItemBuyDiscription() {
    trophyItemBuyDiscription.__super__.constructor.apply(this, arguments);
    this.x = 200;
    this.y = 530;
    this.text = 'トロフィー';
    this.setHtml();
  }

  return trophyItemBuyDiscription;

})(titleDiscription);

useSetDiscription = (function(_super) {
  __extends(useSetDiscription, _super);

  function useSetDiscription() {
    useSetDiscription.__super__.constructor.apply(this, arguments);
    this.x = 180;
    this.y = 170;
    this.text = 'セット中';
    this.setHtml();
  }

  return useSetDiscription;

})(titleDiscription);

useHaveDiscription = (function(_super) {
  __extends(useHaveDiscription, _super);

  function useHaveDiscription() {
    useHaveDiscription.__super__.constructor.apply(this, arguments);
    this.x = 170;
    this.y = 370;
    this.text = '所持リスト';
    this.setHtml();
  }

  return useHaveDiscription;

})(titleDiscription);

recordDiscription = (function(_super) {
  __extends(recordDiscription, _super);

  function recordDiscription() {
    recordDiscription.__super__.constructor.call(this, 100, 200);
    this.x = 200;
    this.y = 80;
    this.text = '楽曲';
    this.setHtml();
  }

  return recordDiscription;

})(titleDiscription);

trophyDiscription = (function(_super) {
  __extends(trophyDiscription, _super);

  function trophyDiscription() {
    trophyDiscription.__super__.constructor.apply(this, arguments);
    this.x = 170;
    this.y = 520;
    this.text = 'トロフィー';
    this.setHtml();
  }

  return trophyDiscription;

})(titleDiscription);

itemNameDiscription = (function(_super) {
  __extends(itemNameDiscription, _super);

  function itemNameDiscription() {
    itemNameDiscription.__super__.constructor.apply(this, arguments);
    this.x = 50;
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
    itemDiscription.__super__.constructor.call(this, 390, 150);
    this.x = 50;
    this.y = 340;
  }

  itemDiscription.prototype.setText = function(text) {
    this.text = text;
    return this.setHtml();
  };

  return itemDiscription;

})(discriptionTextDialogHtml);

longTitleDiscription = (function(_super) {
  __extends(longTitleDiscription, _super);

  function longTitleDiscription() {
    longTitleDiscription.__super__.constructor.call(this, 250, 20);
    this["class"].push('head-title-discription');
  }

  return longTitleDiscription;

})(discriptionTextDialogHtml);

itemUseDiscription = (function(_super) {
  __extends(itemUseDiscription, _super);

  function itemUseDiscription() {
    itemUseDiscription.__super__.constructor.apply(this, arguments);
    this.x = 120;
    this.y = 110;
    this.text = '魔法をセットする';
    this.setHtml();
  }

  return itemUseDiscription;

})(longTitleDiscription);

memberSetDiscription = (function(_super) {
  __extends(memberSetDiscription, _super);

  function memberSetDiscription() {
    memberSetDiscription.__super__.constructor.apply(this, arguments);
    this.x = 120;
    this.y = 110;
    this.text = '部員を編成する';
    this.setHtml();
  }

  return memberSetDiscription;

})(longTitleDiscription);

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
    this.positionX = 0;
    this.positoin_kind = this.item_kind;
    this.dicisionSe = game.soundload('dicision');
  }

  baseItemHtml.prototype.setPosition = function() {
    if (this.positoin_kind <= 4) {
      this.y = this.positionY;
      return this.x = 80 * (this.positoin_kind - 1) + 70 + this.positionX;
    } else {
      this.y = this.positionY + 80;
      return this.x = 80 * (this.positoin_kind - 5) + 30 + this.positionX;
    }
  };

  baseItemHtml.prototype.dispItemBuySelectDialog = function(kind) {
    return game.pause_scene.setItemBuySelectMenu(kind);
  };

  baseItemHtml.prototype.dispItemUseSelectDialog = function(kind) {
    return game.pause_scene.setItemUseSelectMenu(kind);
  };

  baseItemHtml.prototype.dispMemberUseSelectDialog = function(kind) {
    return game.pause_scene.setMemberUseSelectMenu(kind);
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
    this.image_name = 'item_' + kind;
    this.setImageHtml();
  }

  return itemHtml;

})(baseItemHtml);

buyItemHtml = (function(_super) {
  __extends(buyItemHtml, _super);

  function buyItemHtml(kind) {
    buyItemHtml.__super__.constructor.call(this, kind);
    this.positionY = 110;
    this.is_exist = true;
  }

  buyItemHtml.prototype.ontouchend = function() {
    if (this.is_exist === true) {
      game.sePlay(this.dicisionSe);
      return this.dispItemBuySelectDialog(this.item_kind);
    }
  };

  return buyItemHtml;

})(itemHtml);

useItemHtml = (function(_super) {
  __extends(useItemHtml, _super);

  function useItemHtml(kind) {
    useItemHtml.__super__.constructor.call(this, kind);
    this.positionY = 400;
    this.is_exist = false;
  }

  useItemHtml.prototype.ontouchend = function() {
    if (this.is_exist === true) {
      game.sePlay(this.dicisionSe);
      return this.dispItemUseSelectDialog(this.item_kind);
    }
  };

  return useItemHtml;

})(itemHtml);

setItemHtml = (function(_super) {
  __extends(setItemHtml, _super);

  function setItemHtml(position) {
    setItemHtml.__super__.constructor.call(this, position);
    this.kind = 0;
    this.positionY = 210;
    this.positionX = 200;
    this.positoin_kind = position - 1;
    this._setImage(0);
  }

  setItemHtml.prototype.setItemKind = function(kind) {
    this.kind = kind;
    this._setImage(kind);
    if (kind !== 0) {
      return this.changeIsButton();
    } else {
      return this.changeNotButton();
    }
  };

  setItemHtml.prototype._setImage = function(kind) {
    this.image_name = 'item_' + kind;
    return this.setImageHtml();
  };

  setItemHtml.prototype.ontouchend = function() {
    if (this.kind !== 0) {
      game.sePlay(this.dicisionSe);
      return game.pause_scene.setItemUseSelectMenu(this.kind);
    }
  };

  return setItemHtml;

})(baseItemHtml);


/*
部員
 */

memberHtml = (function(_super) {
  __extends(memberHtml, _super);

  function memberHtml(kind) {
    memberHtml.__super__.constructor.call(this, kind);
    this.image_name = 'item_' + kind;
    this.setImageHtml();
    this.positoin_kind = this.item_kind - 10;
  }

  return memberHtml;

})(baseItemHtml);

buyMemberHtml = (function(_super) {
  __extends(buyMemberHtml, _super);

  function buyMemberHtml(kind) {
    buyMemberHtml.__super__.constructor.call(this, kind);
    this.positionY = 340;
    this.is_exist = true;
  }

  buyMemberHtml.prototype.ontouchend = function() {
    if (this.is_exist === true) {
      game.sePlay(this.dicisionSe);
      return this.dispItemBuySelectDialog(this.item_kind);
    }
  };

  return buyMemberHtml;

})(memberHtml);

useMemberHtml = (function(_super) {
  __extends(useMemberHtml, _super);

  function useMemberHtml(kind) {
    useMemberHtml.__super__.constructor.call(this, kind);
    this.positionY = 400;
    this.is_exist = false;
  }

  useMemberHtml.prototype.ontouchend = function() {
    if (this.is_exist === true) {
      game.sePlay(this.dicisionSe);
      return this.dispMemberUseSelectDialog(this.item_kind);
    }
  };

  return useMemberHtml;

})(memberHtml);

setMemberHtml = (function(_super) {
  __extends(setMemberHtml, _super);

  function setMemberHtml(position) {
    setMemberHtml.__super__.constructor.call(this, position);
    this.kind = 0;
    this.disabled = false;
    this.positionY = 210;
    this.positionX = 120;
    this.positoin_kind = position - 1;
    this._setImage(10);
  }

  setMemberHtml.prototype.setItemKind = function(kind) {
    this.kind = kind;
    this._setImage(kind);
    if (kind !== 10) {
      return this.changeIsButton();
    } else {
      return this.changeNotButton();
    }
  };

  setMemberHtml.prototype._setImage = function(kind) {
    this.image_name = 'item_' + kind;
    return this.setImageHtml();
  };

  setMemberHtml.prototype.ontouchend = function() {
    if (this.kind !== 10 && this.disabled === false) {
      game.sePlay(this.dicisionSe);
      return game.pause_scene.setMemberUseSelectMenu(this.kind);
    }
  };

  return setMemberHtml;

})(baseItemHtml);

selectItemImage = (function(_super) {
  __extends(selectItemImage, _super);

  function selectItemImage() {
    selectItemImage.__super__.constructor.call(this, 100, 100);
    this.x = 200;
    this.y = 180;
    this.is_button = false;
  }

  selectItemImage.prototype.setImage = function(image) {
    this.image_name = image;
    return this.setImageHtml();
  };

  return selectItemImage;

})(imageHtml);

baseRecordItemHtml = (function(_super) {
  __extends(baseRecordItemHtml, _super);

  function baseRecordItemHtml(position, kind) {
    baseRecordItemHtml.__super__.constructor.call(this, 100, 100);
    this.position = position;
    this.kind = kind;
    this.image_name = 'test_image2';
    this.setImageHtml();
    this.scaleX = 0.65;
    this.scaleY = 0.65;
    this.positionY = 0;
    this.positionX = 0;
    this.dicisionSe = game.soundload('dicision');
  }

  baseRecordItemHtml.prototype.setPosition = function() {
    this.y = this.positionY + (Math.floor(this.position / 5) + 1) * 75;
    return this.x = 75 * (this.position % 5) + this.positionX;
  };

  return baseRecordItemHtml;

})(systemHtml);

recordItemHtml = (function(_super) {
  __extends(recordItemHtml, _super);

  function recordItemHtml(position, kind) {
    recordItemHtml.__super__.constructor.call(this, position, kind);
    this.positionY = 40;
    this.positionX = 35;
  }

  recordItemHtml.prototype.ontouchend = function() {
    game.sePlay(this.dicisionSe);
    return game.pause_scene.setRecordSelectMenu(this.kind);
  };

  return recordItemHtml;

})(baseRecordItemHtml);

trophyItemHtml = (function(_super) {
  __extends(trophyItemHtml, _super);

  function trophyItemHtml(position, kind) {
    trophyItemHtml.__super__.constructor.call(this, position, kind);
    this.positionY = 480;
    this.positionX = 75;
  }

  trophyItemHtml.prototype.ontouchend = function() {
    game.sePlay(this.dicisionSe);
    return game.pause_scene.setTrophySelectMenu(this.kind);
  };

  return trophyItemHtml;

})(baseRecordItemHtml);

buyTrophyItemHtml = (function(_super) {
  __extends(buyTrophyItemHtml, _super);

  function buyTrophyItemHtml(position, kind) {
    buyTrophyItemHtml.__super__.constructor.call(this, position, kind);
    this.positionY = 480;
    this.positionX = 75;
    this.item_kind = kind;
    this.is_exist = true;
  }

  buyTrophyItemHtml.prototype.ontouchend = function() {
    if (this.is_exist === true) {
      game.sePlay(this.dicisionSe);
      return this.dispItemBuySelectDialog(this.item_kind);
    }
  };

  buyTrophyItemHtml.prototype.dispItemBuySelectDialog = function(kind) {
    return game.pause_scene.setItemBuySelectMenu(kind);
  };

  return buyTrophyItemHtml;

})(baseRecordItemHtml);

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
    this.text = this.zandaka_text + game.toJPUnit(game.money) + this.yen_text;
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
    this.text = this.kakekin_text + game.toJPUnit(game.bet) + this.yen_text;
  }

  betText.prototype.setValue = function() {
    this.text = this.kakekin_text + game.toJPUnit(game.bet) + this.yen_text;
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
    this.force_main_flg = true;
    this.force_pause_flg = false;
    this.not_load_flg = false;
    this.test_load_flg = false;
    this.test_load_val = {
      'money': 1234567890,
      'bet': 1000000,
      'combo': 10,
      'tension': 100,
      'past_fever_num': 0,
      'item_point': 50,
      'next_add_member_key': 0,
      'prev_muse': [],
      'now_muse_num': 15,
      'item_have_now': [],
      'item_set_now': [],
      'member_set_now': [],
      'prev_fever_muse': []
    };
    this.lille_flg = false;
    this.lille_array = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]];

    /*
    @lille_array = [
        [11, 11, 11, 11, 11, 11, 11, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [12, 12, 12, 12, 12, 12, 12, 12, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [13, 13, 13, 13, 13, 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]
     */
    this.item_flg = false;
    this.fix_tention_item_catch_flg = false;
    this.fix_tention_item_fall_flg = false;
    this.fix_tention_slot_hit_flg = false;
    this.force_slot_hit = false;
    this.half_slot_hit = false;
    this.force_fever = false;
    this.fix_tention_item_catch_val = 50;
    this.fix_tention_item_fall_val = 0;
    this.fix_tention_slot_hit_flg = 200;
    if (this.force_pause_flg === true) {
      this.force_main_flg = true;
    }
    if (this.test_load_flg === true) {
      this.not_load_flg = false;
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
    ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
    31:ほのりん、32:ことぱな、33:にこのぞ、34:のぞえり、35:まきりん、36:うみえり、37:ことうみ、38:にこまき
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
            'time': 107,
            'title': '夢なき夢は夢じゃない',
            'unit': '高坂穂乃果',
            'image': 'test_image2'
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
            'time': 98,
            'title': 'ぶる～べりぃとれいん',
            'unit': '南ことり',
            'image': 'test_image2'
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
            'time': 94,
            'title': '勇気のReason',
            'unit': '園田海未',
            'image': 'test_image2'
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
            'time': 91,
            'title': 'Darling！！',
            'unit': '西木野真姫',
            'image': 'test_image2'
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
            'time': 128,
            'title': '恋のシグナルRin rin rin！',
            'unit': '星空凛',
            'image': 'test_image2'
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
            'time': 164,
            'title': 'なわとび',
            'unit': '小泉花陽',
            'image': 'test_image2'
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
            'time': 105,
            'title': 'まほうつかいはじめました',
            'unit': '矢澤にこ',
            'image': 'test_image2'
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
            'time': 127,
            'title': '純愛レンズ',
            'unit': '東條希',
            'image': 'test_image2'
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
            'time': 93,
            'title': 'ありふれた悲しみの果て',
            'unit': '絢瀬絵里',
            'image': 'test_image2'
          }
        ],
        'voice': ['19_0', '19_1']
      },
      20: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': 'ユニット',
            'image': 'test_image2'
          }
        ]
      },
      21: {
        'bgm': [
          {
            'name': 'hello_hoshi',
            'time': 93,
            'title': 'Hello，星を数えて ',
            'unit': '1年生<br>（星空凛、西木野真姫、小泉花陽）',
            'image': 'test_image2'
          }
        ]
      },
      22: {
        'bgm': [
          {
            'name': 'future_style',
            'time': 94,
            'title': 'Future style',
            'unit': '2年生<br>（高坂穂乃果、南ことり、園田海未）',
            'image': 'test_image2'
          }
        ]
      },
      23: {
        'bgm': [
          {
            'name': 'hatena_heart',
            'time': 84,
            'title': '？←HEARTBEAT',
            'unit': '3年生<br>（絢瀬絵里、東條希、矢澤にこ）',
            'image': 'test_image2'
          }
        ]
      },
      24: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': 'Printemps<br>(高坂穂乃果、南ことり、小泉花陽)',
            'image': 'test_image2'
          }
        ]
      },
      25: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': 'lily white<br>(園田海未、星空凛、東條希)',
            'image': 'test_image2'
          }
        ]
      },
      26: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': 'BiBi<br>(絢瀬絵里、西木野真姫、矢澤にこ)',
            'image': 'test_image2'
          }
        ]
      },
      27: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': 'にこりんぱな<br>(矢澤にこ、星空凛、小泉花陽)',
            'image': 'test_image2'
          }
        ]
      },
      28: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '<br>園田海未、西木野真姫、絢瀬絵里',
            'image': 'test_image2'
          }
        ]
      },
      31: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '高坂穂乃果、星空凛',
            'image': 'test_image2'
          }
        ]
      },
      32: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '南ことり、小泉花陽',
            'image': 'test_image2'
          }
        ]
      },
      33: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '矢澤にこ、東條希',
            'image': 'test_image2'
          }
        ]
      },
      34: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '東條希、絢瀬絵里',
            'image': 'test_image2'
          }
        ]
      },
      35: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '西木野真姫、星空凛',
            'image': 'test_image2'
          }
        ]
      },
      36: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '園田海未、絢瀬絵里',
            'image': 'test_image2'
          }
        ]
      },
      37: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '南ことり、園田海未',
            'image': 'test_image2'
          }
        ]
      },
      38: {
        'bgm': [
          {
            'name': 'zenkai_no_lovelive',
            'time': 30,
            'title': 'タイトル',
            'unit': '矢澤にこ、西木野真姫',
            'image': 'test_image2'
          }
        ]
      }
    };
    this.bgm_list = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 31, 32, 33, 34, 35, 36, 37, 38];

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
        'name': 'テンション上がるにゃー！',
        'image': 'item_1',
        'discription': '移動速度が上がる',
        'price': 500000,
        'durationSec': 60,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(1);
        }
      },
      2: {
        'name': 'チーズケーキ鍋',
        'image': 'item_2',
        'discription': 'チーズケーキしか降ってこなくなる<br>ニンニクは降ってこなくなる',
        'price': 10000,
        'durationSec': 120,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(2);
        }
      },
      3: {
        'name': 'ぴょんぴょこぴょんぴょん',
        'image': 'item_3',
        'discription': 'ジャンプ力が上がる',
        'price': 100000,
        'durationSec': 60,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(3);
        }
      },
      4: {
        'name': 'くすくす大明神',
        'image': 'item_4',
        'discription': 'コンボ数に関わらず<br>たくさんのコインが降ってくるようになる',
        'price': 50000,
        'durationSec': 120,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(4);
        }
      },
      5: {
        'name': '完っ全にフルハウスね',
        'image': 'item_5',
        'discription': '3回に1回の確率で<br>CHANCE!!状態になる',
        'price': 10000000,
        'durationSec': 120,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(5);
        }
      },
      6: {
        'name': 'チョットマッテテー',
        'image': 'item_6',
        'discription': 'おやつが降ってくる速度が<br>ちょっとだけ遅くなる',
        'price': 5000000,
        'durationSec': 60,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(6);
        }
      },
      7: {
        'name': 'ファイトだよっ',
        'image': 'item_7',
        'discription': 'スロットに当たった時に<br>得られる金額が2倍になる',
        'price': 1000000,
        'durationSec': 120,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(7);
        }
      },
      8: {
        'name': 'ラブアローシュート',
        'image': 'item_8',
        'discription': 'おやつが近くに落ちてくる',
        'price': 1000000000,
        'durationSec': 60,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(8);
        }
      },
      9: {
        'name': '認められないわぁ',
        'image': 'item_9',
        'discription': 'アイテムを落としてもコンボが減らず<br>テンションも下がらないようになる',
        'price': 100000000,
        'durationSec': 60,
        'conditoin': '',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(9);
        }
      },
      11: {
        'name': '高坂穂乃果',
        'image': 'item_11',
        'discription': '部員に穂乃果を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '穂乃果でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(11);
        }
      },
      12: {
        'name': '南ことり',
        'image': 'item_12',
        'discription': '部員にことりを追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': 'ことりでスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(12);
        }
      },
      13: {
        'name': '園田海未',
        'image': 'item_13',
        'discription': '部員に海未を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '海未でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(13);
        }
      },
      14: {
        'name': '西木野真姫',
        'image': 'item_14',
        'discription': '部員に真姫を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '真姫でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(14);
        }
      },
      15: {
        'name': '星空凛',
        'image': 'item_15',
        'discription': '部員に凛を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '凛でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(15);
        }
      },
      16: {
        'name': '小泉花陽',
        'image': 'item_16',
        'discription': '部員に花陽を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '花陽でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(16);
        }
      },
      17: {
        'name': '矢澤にこ',
        'image': 'item_17',
        'discription': '部員ににこを追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': 'にこでスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(17);
        }
      },
      18: {
        'name': '東條希',
        'image': 'item_18',
        'discription': '部員に希を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '希でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(18);
        }
      },
      19: {
        'name': '絢瀬絵里',
        'image': 'item_19',
        'discription': '部員に絵里を追加できるようになる<br>（セット中の部員がスロットに出現するようになります。部員を１人もセットしていないと、スロットに出現する部員はランダムで決まります。）',
        'price': 0,
        'conditoin': '絵里でスロットを3つ揃える',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(19);
        }
      },
      21: {
        'name': 'ブロンズことり',
        'image': 'test_image2',
        'discription': '移動速度とジャンプ力がアップする',
        'price': 10000000,
        'conditoin': '100コンボ達成する',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(21);
        }
      },
      22: {
        'name': 'シルバーことり',
        'image': 'test_image2',
        'discription': '魔法のスロットが1つ増える',
        'price': 1000000000,
        'conditoin': 'ソロ楽曲9曲を全て達成する',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(22);
        }
      },
      23: {
        'name': 'ゴールドことり',
        'image': 'test_image2',
        'discription': '魔法のスロットが1つ増える',
        'price': 10000000000,
        'conditoin': '200コンボ達成する',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(22);
        }
      },
      24: {
        'name': 'プラチナことり',
        'image': 'test_image2',
        'discription': 'このゲームの全てを極めた証',
        'price': 1000000000000,
        'conditoin': '全楽曲25曲を全て達成する',
        'condFunc': function() {
          return game.slot_setting.itemConditinon(22);
        }
      }
    };
    this.member_item_price = [1000, 10000, 100000, 500000, 1000000, 5000000, 10000000, 50000000, 100000000];
    this.tension_max = 500;
    this.isForceSlotHit = false;
    this.slotHitRate = 0;
    this.item_point_max = 500;
    this.item_point_recovery_sec = 60;
    this.item_point_value = [
      {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
        9: 0
      }
    ];
    this.prize_div = 1;
    this.item_gravity = 0;
    this.prev_muse = [];
    this.now_muse_num = 0;
  }

  slotSetting.prototype.setItemPointValue = function() {
    var i, _i, _results;
    this.item_point_value[0] = Math.floor(this.item_point_max * 1000 / (this.item_point_recovery_sec * game.fps)) / 1000;
    _results = [];
    for (i = _i = 1; _i <= 9; i = ++_i) {
      _results.push(this.item_point_value[i] = Math.floor(this.item_point_max * 1000 / (this.item_list[i].durationSec * game.fps)) / 1000);
    }
    return _results;
  };


  /*
  落下アイテムの加速度
  掛け金が多いほど速くする、10000円で速すぎて取れないレベルまで上げる
   */

  slotSetting.prototype.setGravity = function() {
    var div, val;
    if (game.bet < 10) {
      val = 0.35;
      this.prize_div = 1;
    } else if (game.bet < 50) {
      val = 0.40;
      this.prize_div = 1;
    } else if (game.bet < 100) {
      val = 0.44;
      this.prize_div = 1;
    } else if (game.bet < 500) {
      val = 0.48;
      this.prize_div = 0.9;
    } else if (game.bet < 1000) {
      val = 0.5;
      this.prize_div = 0.9;
    } else if (game.bet < 5000) {
      val = 0.53;
      this.prize_div = 0.8;
    } else if (game.bet < 10000) {
      val = 0.55;
      this.prize_div = 0.8;
    } else if (game.bet < 100000) {
      val = 0.55 + Math.floor(game.bet / 10000) / 100;
      this.prize_div = Math.floor(700 - (game.bet / 500)) / 1000;
    } else if (game.bet < 1000000) {
      val = 0.65 + Math.floor(game.bet / 10000) / 100;
      this.prize_div = Math.floor(500 - (game.bet / 5000)) / 1000;
    } else {
      val = 2;
      this.prize_div = 0.3;
    }
    div = 1;
    val = Math.floor(val * div * 100) / 100;
    if (100 < game.combo) {
      div = Math.floor((game.combo - 100) / 20) / 10;
      if (2 < div) {
        div = 2;
      }
      val += div;
    }
    if (game.isItemSet(6)) {
      val = Math.floor(val * 0.7 * 100) / 100;
    }
    this.item_gravity = val;
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
    game.pause_scene.pause_member_set_layer.dispSetMemberList();
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
  コンボ数 * 0.1 ％
  テンションMAXで+15補正
  過去のフィーバー回数が少ないほど上方補正かける 0回:+9,1回:+6,2回:+3
  最大値は30％
  フィーバー中は強制的に当たり
  @return boolean true:当たり
   */

  slotSetting.prototype.getIsForceSlotHit = function() {
    var random, rate, result;
    result = false;
    rate = Math.floor((game.combo * 0.1) + ((game.tension / this.tension_max) * 15));
    if (game.past_fever_num <= 2) {
      rate += (3 - game.past_fever_num) * 3;
    }
    if (rate > 30 || game.isItemSet(5) || game.main_scene.gp_back_panorama.now_back_effect_flg === true) {
      rate = 30;
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
    var up;
    up = game.combo;
    if (game.isItemSet(4) && game.combo < 100) {
      up = 100;
    }
    return Math.floor(game.bet * up * 0.03);
  };


  /*
  スロットの当選金額を計算
  @param eye 当たったスロットの目
   */

  slotSetting.prototype.calcPrizeMoney = function(eye) {
    var div, ret_money, time;
    ret_money = Math.floor(game.bet * this.bairitu[eye] * this.prize_div);
    if (game.fever === true) {
      time = this.muse_material_list[game.fever_hit_eye]['bgm'][0]['time'];
      div = Math.floor(time / 90);
      if (div < 1) {
        div = 1;
      }
      ret_money = Math.floor(ret_money / div);
    }
    if (game.isItemSet(7) || game.main_scene.gp_back_panorama.now_back_effect_flg === true) {
      ret_money *= 2;
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
    val = (game.item_kind + 2) * this._getTensionCorrect();
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
  所持金と掛け金の比でテンションの増値に補正を加える
   */

  slotSetting.prototype._getTensionCorrect = function() {
    var quo, val;
    quo = Math.round(game.money / game.bet);
    val = 1;
    if (quo <= 10) {
      val = 3;
    } else if (quo <= 30) {
      val = 2;
    } else if (quo <= 60) {
      val = 1.5;
    } else if (quo <= 200) {
      val = 1;
    } else if (quo <= 600) {
      val = 0.75;
    } else if (quo <= 1000) {
      val = 0.5;
    } else if (quo <= 10000) {
      val = 0.25;
    } else {
      val = 0.1;
    }
    return val;
  };


  /*
  アイテムを落とした時のテンションゲージの増減値を決める
   */

  slotSetting.prototype.setTensionItemFall = function() {
    var val;
    if (game.debug.fix_tention_item_fall_flg === true) {
      val = game.debug.fix_tention_item_fall_val;
    } else {
      if (game.isItemSet(9)) {
        val = 0;
      } else {
        val = this.tension_max * this._getTensionDownCorrect();
      }
    }
    return val;
  };

  slotSetting.prototype.setTensionMissItem = function() {
    var val;
    if (game.debug.fix_tention_item_fall_flg === true) {
      val = game.debug.fix_tention_item_fall_val;
    } else {
      val = Math.ceil(this.tension_max * (this._getTensionDownCorrect() - 0.2));
    }
    return val;
  };

  slotSetting.prototype._getTensionDownCorrect = function() {
    var val;
    val = -0.1;
    if (game.bet < 10000) {
      val = -0.1;
    } else if (game.bet < 1000000) {
      val = -0.2;
    } else {
      val = -0.3;
    }
    return val;
  };


  /*
  スロットが当たったのテンションゲージの増減値を決める
  @param number hit_eye     当たった目の番号
   */

  slotSetting.prototype.setTensionSlotHit = function(hit_eye) {
    var val;
    val = this._getTensionCorrect() * this.tension_max * 0.1;
    if (val > this.tension_max * 0.5) {
      val = this.tension_max * 0.5;
    } else if (val < this.tension_max * 0.05) {
      val = this.tension_max * 0.05;
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
    if (game.debug.lille_flg === false) {
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
    }
  };


  /*
  落下するアイテムの種類を決める
  @return 0から4のどれか
   */

  slotSetting.prototype.getCatchItemFrame = function() {
    var rate, val;
    val = 0;
    rate = Math.round(Math.random() * 100);
    if (rate < 20) {
      val = 0;
    } else if (rate < 40) {
      val = 1;
    } else if (rate < 60) {
      val = 2;
    } else if (rate < 80) {
      val = 3;
    } else {
      val = 4;
    }
    if (game.isItemSet(2)) {
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
    var fixTime, randomTime, ret;
    if (this.slotHitRate <= 10) {
      fixTime = 2;
      randomTime = 5;
    } else if (this.slotHitRate <= 20) {
      fixTime = 1.5;
      randomTime = 10;
    } else {
      fixTime = 1;
      randomTime = 15;
    }
    fixTime += Math.floor((1 - this.item_gravity) * 10) / 10;
    ret = fixTime + Math.floor(Math.random() * randomTime) / 10;
    return ret;
  };


  /*
  スロットの揃った目が全てμ’sなら役を判定して返します
  メンバー:11:高坂穂乃果、12:南ことり、13：園田海未、14：西木野真姫、15：星空凛、16：小泉花陽、17：矢澤にこ、18：東條希、19：絢瀬絵里
  @return role
  ユニット(役):20:該当なし、21:１年生、22:2年生、23:3年生、24:printemps、25:liliwhite、26:bibi、27:にこりんぱな、28:ソルゲ、
  31:ほのりん、32:ことぱな、33:にこのぞ、34:のぞえり、35:まきりん、36:うみえり、37:ことうみ、38:にこまき
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
      case '11,15':
        role = 31;
        break;
      case '12,16':
        role = 32;
        break;
      case '17,18':
        role = 33;
        break;
      case '18,19':
        role = 34;
        break;
      case '14,15':
        role = 35;
        break;
      case '13,14':
        role = 36;
        break;
      case '12,13':
        role = 37;
        break;
      case '14,17':
        role = 38;
        break;
      default:
        role = 20;
    }
    return role;
  };


  /*
  アイテムの出現条件を返す
  @param num アイテムの番号
  @return boolean
   */

  slotSetting.prototype.itemConditinon = function(num) {
    var rslt;
    rslt = false;
    if (num < 10) {
      rslt = true;
    } else if (num < 20) {
      if (game.prev_fever_muse.indexOf(parseInt(num)) !== -1) {
        rslt = true;
      }
    } else {
      rslt = false;
    }
    return rslt;
  };


  /*
  μ’ｓメンバーの値段を決める
   */

  slotSetting.prototype.setMemberItemPrice = function() {
    var cnt, key, list, val, _results;
    cnt = 0;
    list = game.getDeduplicationList(game.prev_fever_muse);
    _results = [];
    for (key in list) {
      val = list[key];
      if (11 <= val && val <= 19) {
        if (0 === this.item_list[val].price) {
          this.item_list[val].price = this.member_item_price[cnt];
        }
        _results.push(cnt++);
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };


  /*
  現在セットされているメンバーから次にスロットに挿入するμ’ｓメンバーを決めて返します
   */

  slotSetting.prototype.getAddMuseNum = function() {
    var member, ret;
    member = game.member_set_now;
    if (member.length === 0) {
      ret = this.now_muse_num;
    } else {
      ret = member[game.next_add_member_key];
      game.next_add_member_key += 1;
      if (member[game.next_add_member_key] === void 0) {
        game.next_add_member_key = 0;
      }
    }
    return ret;
  };


  /*
  チャンスの時に強制的にフィーバーにする
   */

  slotSetting.prototype.isForceFever = function() {
    var random, rate, result;
    rate = Math.floor(game.combo / 4) + 10;
    if (game.past_fever_num === 0 && rate >= 50) {
      rate = 50;
    } else if (game.past_fever_num === 1 && rate >= 40) {
      rate = 40;
    } else if (game.past_fever_num === 2 && rate >= 30) {
      rate = 30;
    } else if (game.past_fever_num === 3 && rate >= 20) {
      rate = 20;
    } else {
      rate = 5;
    }
    result = false;
    random = Math.floor(Math.random() * 100);
    if (game.debug.foece_fever === true || random <= rate) {
      result = true;
    }
    return result;
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
    result = game.slot_setting.getHitRole(11, 11, 12);
    return console.log(result);
  };

  Test.prototype.testSetGravity = function() {
    var key, param, result, val, _results;
    param = [1, 5, 10, 50, 100, 500, 1000, 2000, 8000, 9000, 10000, 20000, 80000, 90000, 100000, 200000, 800000, 900000, 1000000];
    _results = [];
    for (key in param) {
      val = param[key];
      console.log('****************');
      console.log('bet:' + val);
      game.bet = val;
      result = game.slot_setting.setGravity();
      console.log('gravity:' + result);
      console.log('div:' + game.slot_setting.prize_div);
      _results.push(console.log('prize:' + game.slot_setting.prize_div * val * 50));
    }
    return _results;
  };

  Test.prototype.viewItemList = function() {
    game.prev_fever_muse.push(15);
    game.prev_fever_muse.push(11);
    game.slot_setting.setMemberItemPrice();
    return console.log(game.slot_setting.item_list);
  };

  Test.prototype.testCutin = function() {
    var i, _i, _results;
    _results = [];
    for (i = _i = 1; _i <= 100; i = ++_i) {
      _results.push(game.main_scene.gp_effect.cutInSet());
    }
    return _results;
  };

  Test.prototype.preLoadMulti = function() {
    game.member_set_now = [17, 18, 19];
    game.musePreLoadByMemberSetNow();
    return console.log(game.already_added_material);
  };

  Test.prototype.addMuse = function() {
    var i, num, _i, _results;
    game.member_set_now = [];
    _results = [];
    for (i = _i = 1; _i <= 6; i = ++_i) {
      num = game.slot_setting.getAddMuseNum();
      _results.push(console.log(num));
    }
    return _results;
  };

  Test.prototype.moneyFormat = function() {
    return console.log(game.toJPUnit(12000012340000));
  };

  Test.prototype.itemCatchTension = function() {
    var val;
    game.past_fever_num = 0;
    game.tension = 400;
    val = game.slot_setting.setTensionItemCatch();
    return console.log(val);
  };

  Test.prototype.chanceTime = function() {
    var val;
    val = game.slot_setting.setChanceTime();
    return console.log(val);
  };

  Test.prototype.forceFever = function() {
    game.combo = 200;
    return game.slot_setting.isForceFever();
  };

  Test.prototype.tensionUp = function() {
    var key, param, result, val, _results;
    game.money = 300;
    game.item_kind = 1;
    param = [1, 2, 3, 5, 10, 30, 50, 100];
    console.log('所持金：' + game.money);
    console.log('おやつ：' + game.item_kind);
    console.log('*******************');
    _results = [];
    for (key in param) {
      val = param[key];
      game.bet = val;
      console.log('掛け金：' + game.bet);
      result = game.slot_setting.setTensionItemCatch();
      console.log('アイテム取得：' + result);
      result = game.slot_setting.setTensionSlotHit(3);
      console.log('スロット当たり：' + result);
      result = game.slot_setting.setTensionItemFall();
      console.log('アイテム落下：' + result);
      result = game.slot_setting.setTensionMissItem();
      console.log('ニンニク：' + result);
      _results.push(console.log('*******************'));
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
    this.bgm = game.soundload("bgm/bgm1");
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
        game.bgmPlay(this.bgm, true);
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
    this.pause_item_use_select_layer = new pauseItemUseSelectLayer();
    this.pause_member_use_select_layer = new pauseMemberUseSelectLayer();
    this.pause_record_layer = new pauseRecordLayer();
    this.pause_record_select_layer = new pauseRecordSelectLayer();
    this.pause_trophy_select_layer = new pauseTrophySelectLayer();
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
    this.pause_item_use_layer.resetItemList();
    return this.addChild(this.pause_item_use_layer);
  };

  pauseScene.prototype.removeItemUseMenu = function() {
    return this.removeChild(this.pause_item_use_layer);
  };

  pauseScene.prototype.setMemberSetMenu = function() {
    this.pause_member_set_layer.resetItemList();
    return this.addChild(this.pause_member_set_layer);
  };

  pauseScene.prototype.removeMemberSetMenu = function() {
    this.removeChild(this.pause_member_set_layer);
    return game.musePreLoadByMemberSetNow();
  };

  pauseScene.prototype.setItemBuySelectMenu = function(kind) {
    this.addChild(this.pause_item_buy_select_layer);
    return this.pause_item_buy_select_layer.setSelectItem(kind);
  };

  pauseScene.prototype.removeItemBuySelectMenu = function() {
    return this.removeChild(this.pause_item_buy_select_layer);
  };

  pauseScene.prototype.setItemUseSelectMenu = function(kind) {
    this.addChild(this.pause_item_use_select_layer);
    return this.pause_item_use_select_layer.setSelectItem(kind);
  };

  pauseScene.prototype.removeItemUseSelectMenu = function() {
    this.removeChild(this.pause_item_use_select_layer);
    return game.itemUseExe();
  };

  pauseScene.prototype.setMemberUseSelectMenu = function(kind) {
    this.addChild(this.pause_member_use_select_layer);
    return this.pause_member_use_select_layer.setSelectItem(kind);
  };

  pauseScene.prototype.removeMemberUseSelectMenu = function() {
    return this.removeChild(this.pause_member_use_select_layer);
  };

  pauseScene.prototype.setRecordMenu = function() {
    return this.addChild(this.pause_record_layer);
  };

  pauseScene.prototype.removeRecordMenu = function() {
    return this.removeChild(this.pause_record_layer);
  };

  pauseScene.prototype.setRecordSelectMenu = function(kind) {
    this.addChild(this.pause_record_select_layer);
    return this.pause_record_select_layer.setSelectItem(kind);
  };

  pauseScene.prototype.removeRecordSelectMenu = function() {
    return this.removeChild(this.pause_record_select_layer);
  };

  pauseScene.prototype.setTrophySelectMenu = function(kind) {
    this.addChild(this.pause_trophy_select_layer);
    return this.pause_trophy_select_layer.setSelectItem(kind);
  };

  pauseScene.prototype.removeTrophySelectmenu = function() {
    return this.removeChild(this.pause_trophy_select_layer);
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

  function cutIn(num) {
    if (num == null) {
      num = 0;
    }
    this._callCutIn(num);
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

  cutIn.prototype._callCutIn = function(num) {
    var cut_in_list, cut_in_random, muse_num, setting;
    setting = game.slot_setting;
    if (num === 0) {
      muse_num = setting.now_muse_num;
    } else {
      muse_num = num;
    }
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


/*
アイテムを取った時、弾けるエフェクト
 */

itemCatchEffect = (function(_super) {
  __extends(itemCatchEffect, _super);

  function itemCatchEffect(num, x, y) {
    var scale_init, unit, view_sec, vy_init;
    itemCatchEffect.__super__.constructor.call(this, 50, 47);
    this.image = game.imageload('heart');
    view_sec = 1;
    this.vx = Math.floor((80 * 10) / (view_sec * game.fps)) / 10;
    if (num % 2 === 0) {
      this.vx *= -1;
    }
    this.opacityV = Math.floor(100 / (view_sec * game.fps)) / 100;
    unit = Math.floor((num - 1) / 2);
    this.gravity = 0.9 + unit * 0.4;
    vy_init = -10 - unit * 6;
    scale_init = 0.2;
    this.scaleV = Math.floor(((1 - scale_init - (unit * 0.1)) * 100) / (view_sec * game.fps)) / 100;
    this.scaleX = scale_init;
    this.scaleY = scale_init;
    this.opacity = 1;
    this.x = x + 5;
    this.y = y;
    this.vy = vy_init;
  }

  itemCatchEffect.prototype.onenterframe = function() {
    this.x += this.vx;
    this.vy += this.gravity;
    this.y += this.vy;
    this.opacity -= this.opacityV;
    this.scaleX += this.scaleV;
    this.scaleY += this.scaleV;
    if (this.opacity < 0) {
      return this.remove();
    }
  };

  itemCatchEffect.prototype.remove = function() {
    return game.main_scene.gp_effect.removeChild(this);
  };

  return itemCatchEffect;

})(performanceEffect);


/*
爆発
 */

explosionEffect = (function(_super) {
  __extends(explosionEffect, _super);

  function explosionEffect() {
    explosionEffect.__super__.constructor.call(this, 100, 100);
    this.image = game.imageload('explosion');
    this.explosion_se = game.soundload('explosion');
    this.view_frm = Math.floor(0.6 * game.fps);
    this.view_frm_half = Math.floor(this.view_frm / 2);
    this.vy = Math.floor(50 * 10 / this.view_frm) / 10;
    this.opacityV = Math.floor(100 / this.view_frm_half) / 100;
    this.scale_init = 0.2;
    this.scaleV = Math.floor(((1 - this.scale_init) * 100) / this.view_frm_half) / 100;
  }

  explosionEffect.prototype.setInit = function(x, y) {
    this.x = x - 10;
    this.y = y - 30;
    this.scaleX = this.scale_init;
    this.scaleY = this.scale_init;
    this.opacity = 1;
    this.age = 0;
    return game.sePlay(this.explosion_se);
  };

  explosionEffect.prototype.onenterframe = function() {
    if (this.age <= this.view_frm) {
      this.y -= this.vy;
      if (this.age <= this.view_frm_half) {
        this.scaleX += this.scaleV;
        this.scaleY += this.scaleV;
      } else {
        this.opacity -= this.opacityV;
      }
    }
    if (this.opacity < 0) {
      return this.remove();
    }
  };

  explosionEffect.prototype.remove = function() {
    return game.main_scene.gp_stage_front.removeChild(this);
  };

  return explosionEffect;

})(performanceEffect);

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
    this.ax_init = 3;
    this.ax_up = 5;
    this.mx_init = 7;
    this.mx_up = 11;
    this.my_init = 19;
    this.my_up = 24;
    this.friction_init = 1.7;
    this.friction_up = 2.7;
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

  Character.prototype.setMxUp = function() {
    this.mx = this.mx_up;
    this.ax = this.ax_up;
    return this.friction = this.friction_up;
  };

  Character.prototype.resetMxUp = function() {
    this.mx = this.mx_init;
    this.ax = this.ax_init;
    return this.friction = this.friction_init;
  };

  Character.prototype.setMyUp = function() {
    return this.my = this.my_up;
  };

  Character.prototype.resetMyUp = function() {
    return this.my = this.my_init;
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
      game.main_scene.gp_effect.setItemChatchEffect(this.x, this.y);
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
      if (game.isItemSet(9) === false) {
        game.combo = 0;
      }
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
    if (game.isItemSet(8)) {
      ret_x = Math.floor(game.main_scene.gp_stage_front.player.x + (game.width * 0.5 * Math.random()) - (game.width * 0.25));
      if (ret_x < 0) {
        ret_x = 0;
      }
      if (ret_x > (game.width - this.w)) {
        ret_x = game.width - this.w;
      }
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
      game.main_scene.gp_stage_front.setExplosionEffect(this.x, this.y);
      game.sePlay(this.miss_se);
      game.main_scene.gp_stage_front.removeChild(this);
      game.tensionSetValueMissItemCatch();
      game.main_scene.gp_stage_front.player.vx = 0;
      return game.main_scene.gp_stage_front.player.vy = 0;
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

  function Money(isHoming, width, height) {
    Money.__super__.constructor.call(this, width, height);
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
    OneMoney.__super__.constructor.call(this, isHoming, 26, 30);
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
    TenMoney.__super__.constructor.call(this, isHoming, 26, 30);
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
    HundredMoney.__super__.constructor.call(this, isHoming, 26, 30);
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
    ThousandMoney.__super__.constructor.call(this, isHoming, 26, 30);
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
    TenThousandMoney.__super__.constructor.call(this, isHoming, 26, 30);
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
    HundredThousandMoney.__super__.constructor.call(this, isHoming, 26, 30);
    this.price = 100000;
    this.frame = 8;
    this.frame_init = 8;
  }

  return HundredThousandMoney;

})(Money);


/*
100万円
@param boolean isHoming trueならコインがホーミングする
 */

OneMillionMoney = (function(_super) {
  __extends(OneMillionMoney, _super);

  function OneMillionMoney(isHoming) {
    OneMillionMoney.__super__.constructor.call(this, isHoming, 30, 30);
    this.image = game.imageload("coin_pla");
    this.price = 1000000;
    this.frame = 8;
    this.frame_init = 8;
  }

  return OneMillionMoney;

})(Money);


/*
1000万円
@param boolean isHoming trueならコインがホーミングする
 */

TenMillionMoney = (function(_super) {
  __extends(TenMillionMoney, _super);

  function TenMillionMoney(isHoming) {
    TenMillionMoney.__super__.constructor.call(this, isHoming, 30, 30);
    this.image = game.imageload("coin_pla");
    this.price = 10000000;
    this.frame = 8;
    this.frame_init = 8;
  }

  return TenMillionMoney;

})(Money);

Slot = (function(_super) {
  __extends(Slot, _super);

  function Slot(w, h) {
    Slot.__super__.constructor.call(this, w, h);
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
    this.image = game.imageload("items");
    this.frame = 0;
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
    ItemGauge.__super__.constructor.call(this, 51, 8);
    this.image = this.drawRect('#A6E39D');
    this.initX = 7;
    this.x = this.initX;
    this.y = 112;
  }

  return ItemGauge;

})(Param);

//# sourceMappingURL=main.js.map
