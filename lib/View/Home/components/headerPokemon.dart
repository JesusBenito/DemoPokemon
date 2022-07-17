import 'dart:convert';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';


class HeaderHome extends StatefulWidget {
  final String name, urlImg;
  const HeaderHome({Key? key, required this.name, required this.urlImg}) : super(key: key);
  @override
  _HeaderHomeState createState() => _HeaderHomeState(name,urlImg);
}


class _HeaderHomeState extends State<HeaderHome> {
  String? _name,_urlImg;
  _HeaderHomeState(this._name,this._urlImg);

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Colors.teal
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(_name!,style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold))),
          Image.network(_urlImg!,fit: BoxFit.cover,height: 250,width: 200,)
        ],
      ),
    );
  }
}
