import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_finder/gamestates.dart';
import 'package:photo_finder/startPage.dart';

Gamestates gamestates = Gamestates();
late WebSocket socket;
void main() async {
  socket = await WebSocket.connect(
    'ws://midnight.ernestsgm.com/game?gameId=M8XVRK&name=1',
  );
  socket.listen((data) {
    print('WebSocket message received: $data');
    String type = data.split('"type":"')[1].split('"')[0];
    switch (type) {
      case 'server:gameStarted':
        //TODO: wait for the word in a different way
        //wait for one second to make sure the word is set
        Future.delayed(Duration(seconds: 1), () {
          gamestates.gameController.startGame();
        });
        break;
      case 'server:wordChosen':
        String word = data.split('"word":"')[1].split('"')[0];
        gamestates.gameController.chooseWord(word);
        print('Code word set to: $word');
        break;
      default:
        print('Unknown message type: $type');
    }
    print('Received data: $data');
  });
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
