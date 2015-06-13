Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail"
  },

  pokemonDetail: function (id, callback) {
    console.log(callback);
    console.log(id);

    if (typeof this._pokemonIndex !== "undefined"){
      if (typeof callback !== "undefined")
      {
        callback();
      }
      var allPokemon = this._pokemonIndex.collection;

      var pokeId = id;

      var current_pokemon = allPokemon.get(pokeId)
      var pokemonName = current_pokemon.get("name");

      var pokeView = new Pokedex.Views.PokemonDetail({
        model: current_pokemon
      });
      $("#pokedex .pokemon-detail").empty();
      pokeView.refreshPokemon(callback);
      $("#pokedex .pokemon-detail").append(pokeView.$el);
    }
    else {
      console.log("hit the else")
      this.pokemonIndex(this.pokemonDetail.bind(this, id));
      // this.pokemonIndex(function () {alert("callback");});

    }

  },

  pokemonIndex: function (callback) {
    var that = this
    callback();
    $(function () {
      var pokemonIndex = new Pokedex.Views.PokemonIndex();
      pokemonIndex.refreshPokemon(callback);
      that._pokemonIndex = pokemonIndex
      $("#pokedex .pokemon-list").html(pokemonIndex.$el);
    });
  },

  toyDetail: function (pokemonId, toyId) {
  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
