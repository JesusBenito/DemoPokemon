import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/api/api_detailPokemon.dart';

import '../../../model/model_detailPokemon.dart';

class FooterAvatar extends StatefulWidget {
  final String name;
  const FooterAvatar({Key? key, required this.name}) : super(key: key);
  @override
  _FooterAvatarState createState() => _FooterAvatarState(name);
}

class _FooterAvatarState extends State<FooterAvatar> {
  PokemonDetailRequestModel? requestModel = PokemonDetailRequestModel();
  String? _name;
  _FooterAvatarState(this._name);
  List<String> servicesList = ["abilities", "moves", "stats"];
  List? abilities;

  @override
  void initState() {
    super.initState();
    _getDetailPokemon();
  }

  void _getDetailPokemon() async {
    setState(() {
      requestModel?.name = _name;
    });
    APIDetailPokemons apiService = APIDetailPokemons();
    apiService.post(requestModel!).then((value){
      setState(() {
        abilities = value.abilities;
      });
      print(abilities);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: _getListData()),
          ),
          Container(
            child: (abilities == null)
                ? const CircularProgressIndicator(color: Colors.deepOrange,)
                :ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: abilities!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Text("ability: "+abilities![index]['ability']['name'],style: const TextStyle(color: Colors.deepOrange),),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }


  _getListData() {
    List<Widget> widgets = [];
    for (int i = 0; i < 2; i++) {
      widgets.add(Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              FlatButton(
                  onPressed: () => {},
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Text(servicesList[i],style: const TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                      const Text("_______",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold))
                    ],
                  )),
            ],
          )));
    }
    return widgets;
  }
}
