NewsReader.Views.EntryShow = Backbone.View.extend({
  tagName: 'li',

  className: 'feed-entry',

  template: JST['entryShow'],

  render: function () {
    var content = this.template({entry: this.model});
    this.$el.html(content);
    return this;
  }

});
