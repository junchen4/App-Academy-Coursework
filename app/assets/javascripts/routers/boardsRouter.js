TrelloClone.Routers.BoardsRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$rootEl;
  },

  routes: {
    "": "showIndex",
    "boards/new": "newBoard",
    "boards/:id": "showBoard"
  },

  showIndex: function () {
    TrelloClone.Collections.boards.fetch(); //not going to be done fetching, so below runs, but fetches twice

    var boardsView = new TrelloClone.Views.BoardsIndex({collection: TrelloClone.Collections.boards});
    this.$el.html(boardsView.render().$el);
  },

  newBoard: function () {
    var newModel = new TrelloClone.Models.Board();
    var newBoardView = new TrelloClone.Views.NewBoard({collection: TrelloClone.Collections.boards, model: newModel});
    this.$el.html(newBoardView.render().$el);
  },

  showBoard: function (id) {
    var boardModel = TrelloClone.Collections.boards.getOrFetch(id);
    var boardShowView = new TrelloClone.Views.BoardShow({model: boardModel});
    this.$el.html(boardShowView.render().$el);
  }

});
