import 'package:flutter/material.dart';
import 'package:photo_finder/waitingPlayerWidget.dart';

class JoinGameScreen extends StatefulWidget {
  const JoinGameScreen({super.key});

  @override
  State<JoinGameScreen> createState() => JoinGameScreenState();
}

class JoinGameScreenState extends State<JoinGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Game')),
      body: Center(child: Column(children: [WaitingPlayerList()])),
    );
  }
}
