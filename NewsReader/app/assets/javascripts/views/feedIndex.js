NewsReader.Views.FeedIndex = Backbone.View.extend({
  tagName: 'section',

  className: 'feed-index',

  template: JST['feedIndex'],

  events: {
    "click button.feed-delete": "deleteFeed"
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    var content = this.template({feeds: this.collection});
    this.$el.html(content);

    return this;
  },

  deleteFeed: function (event) {
    console.log("deleting")
    var id = $(event.currentTarget).data("feed-id");
    this.collection.get(id).destroy({
      success: function () {
        this.render();
      }.bind(this)
    });
  }
});
