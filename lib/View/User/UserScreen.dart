import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokemon/View/Home/HomeScreen.dart';
import '../../../constants.dart';
import '../../components/rounded_button.dart';
import '../../components/text_field_container.dart';
import '../../flutterStorage/StorageFlutter.dart';
import 'components/background.dart';



class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);


  @override
  _BodyLoginState createState() => _BodyLoginState();


}

class _BodyLoginState extends State<UserScreen> {
  TextEditingController user = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Registra un usuario",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepOrange),
            ),
            Image.asset(
              "assets/images/logo.jpeg",
              height: size.height * 0.30,
            ),
            SizedBox(height: size.height * 0.03),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 12.0, bottom: 26.0),
                  child: Column(
                    children: [
                      TextFieldContainer(
                        child: TextFormField(
                          controller: user,
                          cursorColor: kPrimaryColor,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.deepOrange,
                            ),
                            hintText: "Usuario",
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(
                                color: kPrimaryColor
                            ),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Ingresa un usuario";
                            }
                            // Return null if the entered password is valid
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                )),

            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Registrar",
              press: () async {
                await write(key: 'user', value: user.text);
                var usuario = await read('user');
                if(usuario!= null){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                }
              },
            ),
          ],
        )
      ),
    );
  }
}
