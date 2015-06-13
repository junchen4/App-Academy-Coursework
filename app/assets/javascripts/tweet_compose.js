$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$charsLeft = this.$el.find(".chars-left");
  this.$textarea = this.$el.find("textarea")
  this.$mention = this.$el.find(".add-mentioned-user");
  var ulID = this.$el.data("tweets-ul");
  this.$ul = $(ulID);
  this.$el.on("submit", this.submit.bind(this));
  this.$textarea.on("input", this.charsLeft.bind(this));
  this.$mention.on("click", this.addMentionedUser.bind(this));

};

$.TweetCompose.prototype.render = function (data) {
  var content = JSON.stringify(data["content"]);
  var li = $("<li>"+ content + "</li>")
  this.$ul.prepend(li);

};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var inputs = $(event.currentTarget).serialize();

  $.ajax({
      url: "/tweets",
      type: "POST",
      dataType: "JSON",
      data: inputs,
      success: function (data) {
        this.clearInput();
        this.render(data);
    //    this.renderResults(data);
      }.bind(this)
  });
}

$.TweetCompose.prototype.clearInput = function() {
  this.$textarea.val("");
}

$.TweetCompose.prototype.charsLeft = function (event) {
  var length = $(event.currentTarget).val().length;
  var leftover = 140 - length;
  this.$charsLeft.text(leftover);
}

$.TweetCompose.prototype.addMentionedUser = function (event) {
    var $script = $(this.$el.find("script").html());
    this.$el.find(".mentioned-users").append($script);
    console.log($script);
}

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};
