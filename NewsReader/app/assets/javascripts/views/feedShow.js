NewsReader.Views.FeedShow = Backbone.View.extend ({
  template: JST['feedShow'],

  events: {
    "click button.feed-refresh": "refreshFeed"
  },

  initialize: function () {
    this.listenTo(this.model.entries(), "sync", this.render);
  },

  render: function () {
    this.removeEntries();
    var content = this.template({entries: this.model.entries()});
    this.$el.html(content);

    this.model.entries().each(function (entry) {
      var entryItem = new NewsReader.Views.EntryShow({model: entry});
      this.$el.find('.feed-entries').append(entryItem.render().$el);

      this.entryItems.push(entryItem);
    }.bind(this));

    return this;
  },

  removeEntries: function () {
    if(this.entryItems) {
      this.entryItems.forEach(function (item) {
        item.remove();
      });
    }

    this.entryItems = [];
  },

  remove: function () {
    this.removeEntries();
  },

  refreshFeed: function (event) {
    event.preventDefault();

    this.model.entries().fetch();
  }
});
