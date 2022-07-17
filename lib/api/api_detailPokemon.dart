import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/model_detailPokemon.dart';



class APIDetailPokemons{

  Future<PokemonDetailResponseModel> post(PokemonDetailRequestModel requestModel) async{
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/"+requestModel.name!),
        headers: {"Content-Type": "application/json"});

    return PokemonDetailResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

  }
}
