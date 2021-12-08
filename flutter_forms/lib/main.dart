import 'package:flutter/material.dart';

import 'features/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Nothing special, just calling the HomePage which has a ListView
  // off all the different forms.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Forms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
