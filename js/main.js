var myClass;

myClass = (function() {
  function myClass() {}

  myClass.prototype.hello = function() {
    return console.log("Hello World!");
  };

  return myClass;

})();

var cls;

cls = new myClass();

cls.hello();
