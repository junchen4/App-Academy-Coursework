NewsReader.Routers.AppRouter = Backbone.Router.extend({
  routes: {
    "": "feedIndex",
    "feeds/new": "newFeed",
    "feeds/:id": "feedShow"
  },

  initialize: function () {
    this._feeds = new NewsReader.Collections.Feeds();
    this._feeds.fetch();
  },

  newFeed: function () {
    this.removeView();

    this.view = new NewsReader.Views.NewFeed({collection: this._feeds});
    $('#content').html(this.view.render().$el);
  },

  feedIndex: function () {
    this.removeView();

    this.view = new NewsReader.Views.FeedIndex({collection: this._feeds});
    $('#content').html(this.view.render().$el);
  },

  feedShow: function (id) {
    this.removeView();

    var feed = this._feeds.getOrFetch(id);
    this.view = new NewsReader.Views.FeedShow({model: feed});
    $('#content').html(this.view.render().$el);
    feed.entries().fetch();
  },

  removeView: function () {
    this.view && this.view.remove();
  }
});
