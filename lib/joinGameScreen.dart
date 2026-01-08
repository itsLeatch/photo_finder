import 'package:flutter/material.dart';
import 'package:photo_finder/main.dart';
import 'package:photo_finder/objectAssignmentScreen.dart';
import 'package:photo_finder/waitingPlayerWidget.dart';

class JoinGameScreen extends StatefulWidget {
  const JoinGameScreen({super.key, required this.gameCode});
  final String? gameCode;

  @override
  State<JoinGameScreen> createState() => JoinGameScreenState();
}

class JoinGameScreenState extends State<JoinGameScreen> {
  late VoidCallback _gameStartedListener;

  @override
  void initState() {
    _gameStartedListener = () {
      if (gamestates.gameController.lastMessage == "gameStarted") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ObjectAssignmentScreen()),
        );
      }
    };
    gamestates.gameController.addListener(_gameStartedListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Game')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Gamecode: ${widget.gameCode}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            WaitingPlayerList(),
            Wrap(
              children: [
                Text("Waiting for host to start..."),
                CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    gamestates.gameController.removeListener(_gameStartedListener);
    super.dispose();
  }
}
