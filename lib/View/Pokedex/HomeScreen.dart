import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../sqflite/database_helper.dart';



class PokedexScreen extends StatefulWidget {
  const PokedexScreen({Key? key}) : super(key: key);


  @override
  _PokedexState createState() => _PokedexState();


}

class _PokedexState extends State<PokedexScreen> {
  Database? db;
  List? pokedex;
  List? pokemons;
  final controller = DragSelectGridViewController();
  final nuevoObjeto = {};
  @override
  void initState() {
    super.initState();
    _getPokemons();
  }


  Future<void> _getPokemons() async {
    db = await PokedexDatabase.instance.database;
    PokedexDatabase.instance.getPokedexs().then((value){
      for(var item in value){
        PokedexDatabase.instance.getPokemons(item['idPokedex']).then((value2) {
            pokemons = value2;
            pokemons?.forEach((e) {
              if(!nuevoObjeto.containsKey(e['idPokedex'])){
                nuevoObjeto[e['idPokedex']] = {
                  'pokemons': []
                };
              }
              setState(() {
                nuevoObjeto[e['idPokedex']]['pokemons'].add({
                  'idPokemon': e['idPokemon']
                });
              });
            });
        });
      }
      setState(() {
        pokedex = value;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokedex",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: (pokedex == null)?
          const CircularProgressIndicator(color: Colors.amber,)
          : DragSelectGridView(
              gridController: controller,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: pokedex!.length,
              itemBuilder: (BuildContext ctx, index, selected) {
                print(nuevoObjeto);
                return GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: selected == true ? Colors.blue : Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10,top: 5),
                                child: Text(pokedex![index]['name'],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Pokebola-pokeball-png-0.png/800px-Pokebola-pokeball-png-0.png",height: 50,),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){

                  },
                );
              }),
        ),
      ),

    );
  }

}
