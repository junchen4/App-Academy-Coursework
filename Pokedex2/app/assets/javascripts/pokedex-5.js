Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li.poke-list-item': 'selectPokemonFromList',
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon({});
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    var that = this;
    var boundRender = this.render.bind(this)
    this.collection.fetch({
      success: function() {
        boundRender();
        console.log("options: " + options)
        options();
      }
    })
  },

  render: function () {
    this.$el.empty();
    var that = this
    this.collection.each(function (pokemon) {
      that.addPokemonToList(pokemon);
    })
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.target);

    var pokeId = $target.data('id');
    //
    // var current_pokemon = this.collection.get(pokeId)
    // var pokemonName = current_pokemon.get("name");
    // console.log(pokemonName);
    //
    // var pokeView = new Pokedex.Views.PokemonDetail({
    //   model: current_pokemon
    // });
    // $("#pokedex .pokemon-detail").empty();
    // pokeView.refreshPokemon();
    // $("#pokedex .pokemon-detail").append(pokeView.$el);

    Backbone.history.navigate("/pokemon/" + pokeId, { trigger: true });

  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click li.toys': 'selectToyFromList'
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: function (model, resp) {
        that.render();
      }
    })
  },

  render: function () {
    var content = JST["pokemonDetail"]({pokemon: this.model})
    this.$el.html(content);
    var that = this;

    this.model.toys().each(function (toy) {
      var toyContent = JST["toyListItem"]({toy: toy});
      that.$el.append(toyContent);
      that.$el.append($("<br>"));
    })
  },

  selectToyFromList: function (event) {
    console.log("clicked");
    var toyView = new Pokedex.Views.ToyDetail({
    });
    $("#pokedex .toy-detail").html(toyView.$el);
    // var correctRender = toyView.render.bind(this);
    // correctRender(event);

    toyView.render(this, event);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function (that, event) {
    var toyIdx = $(event.target).data('toy-id');
    var current_toy = that.model.toys().get(toyIdx);
    var content = JST["toyDetail"]({toy: current_toy, pokes: []});
    this.$el.html(content);


  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
