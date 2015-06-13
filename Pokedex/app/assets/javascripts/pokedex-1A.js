Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
//  this.$pokemon = $(pokemon.get("name"));
//  var name_content = JSON.stringify(this.$pokemon);
  var $li = $('<li class="poke-list-item"> </li>');
  $li.append(pokemon.get('name') + pokemon.get('poke_type'));
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {


};
