import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_finder/gamestates.dart';
import 'package:photo_finder/startPage.dart';

Gamestates gamestates = Gamestates();
late WebSocket socket;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StartPage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
    );
  }
}
