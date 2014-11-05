(function() {
  window.myClass = (function() {
    var hello;

    function myClass() {}

    hello = function() {
      return console.log("Hello World!");
    };

    return myClass;

  })();

}).call(this);

(function() {
  hello();

}).call(this);
