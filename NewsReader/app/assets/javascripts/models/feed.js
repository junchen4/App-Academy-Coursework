NewsReader.Models.Feed = Backbone.Model.extend ({
  urlRoot: '/api/feeds',

  parse: function (resp) {
    if(resp.latest_entries) {
      this.entries().set(resp.latest_entries);
      delete resp.latest_entries;
    }
    return resp;
  },

  entries: function () {
    if (!this._entries) {
      this._entries = new NewsReader.Collections.Entries([], {feed: this});
    }
    return this._entries;
  }
});
