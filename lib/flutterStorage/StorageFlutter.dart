library my_project.global;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();


Future<String?> read(String key) async{
  String? val = await storage.read(key: key);
  return val;
}

Future<void> write({required String key, required String value}) async {
  storage.write(key: key, value: value);
}

