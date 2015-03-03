Pokedex.RootView.prototype.addToyToList = function (toy) {
  var content = JST["toyListItem"]({toy: toy});

  var $li = $('<li class="toy-list-item">');
  $li.data('id', toy.get('id'));
  $li.data('pokemon-id', toy.get('pokemon_id'));

  $li.append(content)

  this.$pokeDetail.find(".toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  this.$toyDetail.empty();

  var content = JST["toyDetail"]({toy: toy, pokes: this.pokes});

  this.$toyDetail.html(content);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $target = $(event.target);

  var toyId = $target.data('id');
  var pokemonId = $target.data('pokemon-id');

  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);

  this.renderToyDetail(toy);
};
