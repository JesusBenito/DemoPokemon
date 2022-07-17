import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/model_pokemons.dart';



class APIPokemons{

  Future<PokemonsResponseModel> post() async{

    try {
      final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=150"),
          headers: {"Content-Type": "application/json"});

      return PokemonsResponseModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } on Error catch (e) {
      const jsonData = '{"status": 501}';
      return PokemonsResponseModel.fromJson(json.decode(jsonData));
    }


  }
}
