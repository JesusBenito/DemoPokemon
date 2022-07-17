import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:item_selector/item_selector.dart';
import 'package:pokemon/api/api_pokemon.dart';
import 'package:sqflite/sqflite.dart';
import '../../../constants.dart';
import '../../components/rounded_button.dart';
import '../../components/text_field_container.dart';
import '../../flutterStorage/StorageFlutter.dart';
import '../../sqflite/database_helper.dart';
import '../Pokedex/HomeScreen.dart';
import '../User/components/drag_select_grid.dart';
import 'components/background.dart';
import 'components/detailPokemon.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();


}

class _HomeState extends State<HomeScreen> {
  TextEditingController namePokedex = TextEditingController();
  List? pokemons;
  int? selectedIndex;
  final controller = DragSelectGridViewController();
  Database? db;
  String? textValidator;
  @override
  void initState() {
    super.initState();
    _getPokemons();
    controller.addListener(scheduleRebuild);

  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  void scheduleRebuild() => setState(() {});

  void _getPokemons() async {
    db = await PokedexDatabase.instance.database;
    APIPokemons apiService = APIPokemons();
    apiService.post().then((value){
      setState(() {
        pokemons = value.pokemons;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Pokedex'),
            ),
            ListTile(
              title: const Text('Equipos'),
              textColor: Colors.amber,
              selectedColor: Colors.amber,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PokedexScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Pokémon",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,

      ),
      body: Background(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // implement GridView.builder
            child: Container(
              child: (pokemons == null)
              ? const CircularProgressIndicator(color: Colors.deepOrange,)
              :ItemSelectionController(
                  child: DragSelectGridView(
                    gridController: controller,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: pokemons!.length,
                      itemBuilder: (BuildContext ctx, index, selected) {
                      return SelectableItem(
                        index: index,
                        color: Colors.blue,
                        selected: selected,
                        contextLogin: context,
                        child: GestureDetector(
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
                                        child: Text(pokemons![index]['name'],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                                  ],
                                ),
                                Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+(index+1).toString()+".png")
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> detailPokemon(name:pokemons![index]['name'],urlImg:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+(index+1).toString()+".png")));
                          },
                        ),
                      );
                      }),
              ),
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () {
          if(controller.value.selectedIndexes.length == 6){
            showAlertDialogConfirm(context);
          }else{
            showAlertDialog(context);
          }
        },
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      color: Colors.green,
      child: Text("Aceptar",style: const TextStyle(color: Colors.white),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 20),),
      content: const Text("Seleccion a 6 pokemones para agregar un equipo",textAlign: TextAlign.center),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialogConfirm(BuildContext context) {
    // Create button
    Widget cancelButton = FlatButton(
      color: Colors.red,
      child: const Text("Cancelar",style: TextStyle(color: Colors.white),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = FlatButton(
      color: Colors.green,
      child: const Text("Aceptar",style: TextStyle(color: Colors.white),),
      onPressed: () {
        int idPokedex;
        if(namePokedex.text.isNotEmpty){
          PokedexDatabase.instance.insertPokedex(namePokedex.text);
          PokedexDatabase.instance.getIdPokedex().then((value){
            for(var item in controller.value.selectedIndexes){
              PokedexDatabase.instance.insertPokemon(item, value[0]['id']);
            }
            Navigator.of(context).pop();
            showAlertDialogCreate(context);

          });

        }else{

        }

      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Crear Equipo",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 20),),
      content: TextField(
        controller: namePokedex,
        cursorColor: kPrimaryColor,
        decoration: const InputDecoration(
          hintText: "Nombre",
          border: UnderlineInputBorder(),
          labelStyle: TextStyle(
              color: kPrimaryColor
          ),
        ),
      ),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogCreate(BuildContext context) {
    // Create button
    Widget cancelButton = FlatButton(
      color: Colors.red,
      child: const Text("Aceptar",style: TextStyle(color: Colors.white),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    
    AlertDialog alert = AlertDialog(
      title: const Text("El equipo se creó con éxito",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 20),),
      content: Image.network("https://cdn.pixabay.com/photo/2016/01/20/18/59/confirmation-1152155_960_720.png",height: 100,),
      actions: [
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
