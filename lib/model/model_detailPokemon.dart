/// [Description] Model Change Location
/// [Author] Jesus Benito <jesus.benito@wundertec.com

class PokemonDetailResponseModel {
  List<dynamic>? abilities;

  PokemonDetailResponseModel({this.abilities});

  factory PokemonDetailResponseModel.fromJson(Map<String, dynamic> parsedJson){
    return PokemonDetailResponseModel(
      abilities: parsedJson['abilities'],
    );
  }
}


class PokemonDetailRequestModel {
  String? name;

  PokemonDetailRequestModel(
      {this.name});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name
    };

    return map;
  }
}


