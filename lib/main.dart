import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beam Calculator',
      theme: ThemeData(primarySwatch: const Color.fromARGB(255, 240, 240, 240)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
