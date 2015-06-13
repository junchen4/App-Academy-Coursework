$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find("ul");
  this.$input.on("input", this.handleInput.bind(this));
};

$.UsersSearch.prototype.renderResults = function (data) {
  this.$ul.children().remove();
  var follow = {true: "followed", false: "unfollowed"};
  var i;
  for(i = 0; i < data.length ; i++) {
    var li = $("<li><a href=\"/users/" + data[i].id + "\">" + data[i].username + "</a></li>")
    var button = $("<button> </button>")
    var options = {userId: data[i].id, followState: follow[data[i].followed]};
    this.$ul.append(li).append(button);
    button.followToggle(options)
  }
};

$.UsersSearch.prototype.handleInput = function (event) {
  var inputData = {query: this.$input.val()};

  $.ajax({
      url: "/users/search",
      type: "GET",
      dataType: "JSON",
      data: inputData,
      success: function (data) {
        console.log(data[0]);
        this.renderResults(data);
      }.bind(this)
  });
}

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};
