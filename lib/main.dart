import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon/View/Home/HomeScreen.dart';
import 'View/User/UserScreen.dart';
import 'constants.dart';
import 'flutterStorage/StorageFlutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(title: 'Flutter Demo User Page'),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Splash> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<Splash> with TickerProviderStateMixin{
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: (3)),vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/pokemon.json',
              controller: _controller,
              height: MediaQuery.of(context).size.height * 0.36,
              animate: true,
              onLoaded: (composition) async {
                var usuario = await read('user');
                if(usuario == null){
                  _controller..duration = composition.duration
                    ..forward().whenComplete(() => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const UserScreen())));
                }else{
                  _controller..duration = composition.duration
                    ..forward().whenComplete(() => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen())));
                }

              },
            ),

          ],
        ),
      ),
    );
  }
}
