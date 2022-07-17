import 'package:flutter/material.dart';

import 'footerPokemon.dart';
import 'headerPokemon.dart';


class detailPokemon extends StatefulWidget {
  final String name, urlImg;
  const detailPokemon({Key? key, required this.name, required this.urlImg}) : super(key: key);


  @override
  _detailPokemonState createState() => _detailPokemonState(name,urlImg);


}

class _detailPokemonState extends State<detailPokemon> {
  String? _name,_urlImg;
  _detailPokemonState(this._name,this._urlImg);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Column(
            children: [
              HeaderHome(name:_name!,urlImg: _urlImg!),
              FooterAvatar(name:_name!),
            ]),
      ),
    );
  }
}
