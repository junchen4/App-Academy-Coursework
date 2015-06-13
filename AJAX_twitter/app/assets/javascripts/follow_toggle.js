
$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  this.$el.on("click", this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  if(this.followState === "following"){
    // this.$el.prop("disabled", true);
  }
  else if (this.followState === "unfollowing") {
    this.followState = "unfollowed";
    // this.$el.prop("disabled", true);
  }

  if(this.followState === "unfollowed") {
    this.$el.html("follow!");
  }
  else if(this.followState === "followed") {
    this.$el.html("unfollow!");
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  var type, fstate;
  if (this.followState === "following" || this.followState === "unfollowing"){
    return;
  }
  if (this.followState === "unfollowed") {
    type = "post";
    fstate = "followed";
    this.followState = "following";
    // this.render();
  }
  else if (this.followState === "followed") {
    type = "delete";
    fstate = "unfollowed";
    this.followState = "unfollowing";
    // this.render();
  }


  $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: type,
      dataType: "JSON",
      success: function (data) {
        this.followState = fstate;
        this.render();
      }.bind(this)
  });
}

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};
