Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li': 'selectPokemonFromList'
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
    this.collection.fetch({
      success: that.render.bind(that)
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

    var current_pokemon = this.collection.get(pokeId)
    var pokemonName = current_pokemon.get("name");
    console.log(pokemonName);

    var pokeView = new Pokedex.Views.PokemonDetail({
      model: current_pokemon
    });
    $("#pokedex .pokemon-detail").empty();
    $("#pokedex .pokemon-detail").append(pokeView.$el);

    pokeView.render();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
  },

  refreshPokemon: function (options) {
  },

  render: function () {
    var content = JST["pokemonDetail"]({pokemon: this.model})
    this.$el.html(content)
    console.log(content);
  },

  selectToyFromList: function (event) {
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
  }
});


$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
