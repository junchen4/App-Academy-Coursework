NewsReader.Views.NewFeed = Backbone.View.extend({
  template: JST['newFeed'],

  events: {
    "submit form": "createFeed"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  createFeed: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON();
    var feed = new NewsReader.Models.Feed();
    feed.save({feed: data.form}, {
      success: function () {
        this.collection.add(feed);
        Backbone.history.navigate("#", {trigger: true});
      }.bind(this)
    })
  }
});
