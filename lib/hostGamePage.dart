import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_finder/main.dart';
import 'package:photo_finder/objectAssignmentScreen.dart';
import 'package:photo_finder/waitingPlayerWidget.dart';

class HostGamePage extends StatefulWidget {
  const HostGamePage({super.key, required this.gameCode});
  final String gameCode;

  @override
  State<HostGamePage> createState() => HostGamePageState();
}

class HostGamePageState extends State<HostGamePage> {
  @override
  void initState() {
    gamestates.gameController.addListener(() {
      if (gamestates.gameController.lastMessage == "gameStarted") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ObjectAssignmentScreen()),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Host Game')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Gamecode: ${widget.gameCode}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            WaitingPlayerList(),
            ElevatedButton(
              onPressed: () {
                socket.add(
                  '{"type": "client:startGame", "gameId": "${widget.gameCode}", "playerName": "${gamestates.playerName}"}',
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    gamestates.gameController.removeListener(() {});
    super.dispose();
  }
}
