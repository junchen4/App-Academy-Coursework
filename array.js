var myUniq = function(array) {
  var new_array = []

  for (var i = 0; i < array.length; i++) {
    if (new_array.length === 0) {
      new_array.push(array[i]);
    }

    var unique = true;
    for (var j = 0; j < new_array.length; j++) {
      if (array[i] === new_array[j]) {
        unique = false;
        break;
      }
    }

    if (unique) {
      new_array.push(array[i]);
    }
  }

  return new_array;
};

var output = myUniq([1,2,2,4,1,4]);
console.log(output);

/////////////////////////////////////////////////

var two_sum = function (array) {
  var pairs = [];

  array.forEach(function (x, i) {
    array.forEach(function (y, j) {

      if (j <= i){
        return;
      }

      if (x + y === 0){
        pairs.push([i,j]);
      }
    });
  });

  return pairs;
};

var output = two_sum([1,2,4,3,-5,-4,-3,2,1,-1,-1,-1])
console.log(output)

////////////////////////////////////////////////

var my_transpose = function (array) {
  var new_array = [];
  for(var i = 0; i < array.length; i++){
    var row = [];
    for(var j = 0; j < array.length; j++){
      row.push(array[j][i])
    }
    new_array.push(row);
  }
  return new_array;
};

/////////////////////////////////////////////////////

Array.prototype.myEach = function(func) {
  for(var i = 0; i < this.length; i++){
    el = this[i];
    (func(el))
  }
};

Array.prototype.myMap = function(func) {
  var output_arr = [];

  for(var i = 0; i < this.length; i++){
    el = this[i];
    output_arr.push(func(el));
  }

  return (output_arr);
};

Array.prototype.myInject = function (num) {
  var accumulator = num;

  for(var i = 0; i < this.length; i++){
    el = this[i];
    accumulator += el;
  }

  return accumulator
};


myEach([1,2,3,4], function (el) { console.log("hi" + el) })

var add2 = function (num) {
  console.log (num + 2);
};

var mapAdd2 = function (num) {
  return (num + 2);
};

//////////////////////////////////////////////////////

Array.prototype.bubbleSort  = function () {
  var sorted = false;

  while (!sorted) {
    sorted = true;

    for (var idx = 0; idx < this.length; idx++) {
      if (idx === this.length - 1) {
        continue;
      }

      var el = this[idx];
      if ( el > this[idx + 1] ) {
        sorted = false;

        this[idx] = this[idx + 1];
        this[idx + 1] = el;
      }
    }
  }

  return this;
};
