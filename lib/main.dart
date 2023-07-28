import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'models/note_data.dart';

void main() async {
  //initalize
  await Hive.initFlutter();

  //open hive box
  await Hive.openBox('note_database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NoteData(),
        builder: ((context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            )));
  }
}
