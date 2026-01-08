import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_finder/gamestates.dart';
import 'package:photo_finder/startPage.dart';

Gamestates gamestates = Gamestates();

void main() async {
  final socket = await WebSocket.connect('ws://midnight.ernestsgm.com/game');
  socket.listen((data) {
    print('Received data: $data');
  });
  socket.add(
    '{"type": "client:startGame", "gameId": "M8XVRK", "playerName": "1"}',
  );
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
