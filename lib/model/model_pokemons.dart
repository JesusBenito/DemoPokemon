/// [Description] Model Change Location
/// [Author] Jesus Benito <jesus.benito@wundertec.com

class PokemonsResponseModel {
  List? pokemons;


  PokemonsResponseModel({this.pokemons});

  factory PokemonsResponseModel.fromJson(Map<String, dynamic> parsedJson){
    return PokemonsResponseModel(
      pokemons: parsedJson['results'],
    );
  }
}

class PokemonDetailResponseModel {
  int? id;


  PokemonDetailResponseModel({this.id});

  factory PokemonDetailResponseModel.fromJson(Map<String, dynamic> parsedJson){
    return PokemonDetailResponseModel(
      id: parsedJson['results'],
    );
  }
}


