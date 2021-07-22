import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:utils/translation/translate.dart';
import 'package:utils/translation/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  final translate = Translate();
  await translate.loadJsonFromPath('assets/json/en_str.json');
  final s = await translate.usingGoogle(LanguageDictionary.Telugu);
  log('${jsonEncode(s)}');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Your translated jsonMap will be logged into the console.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
