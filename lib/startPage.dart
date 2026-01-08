import 'package:flutter/material.dart';
import 'package:photo_finder/hostGamePage.dart';
import 'package:photo_finder/joinGameScreen.dart';
import 'package:photo_finder/main.dart';
import 'package:photo_finder/serverStuff.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gameCodeController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(() {
      gamestates.playerName = nameController.text;
    });

    gameCodeController.addListener(() {
      gamestates.gameCode = gameCodeController.text;
    });

    super.initState();
  }

  bool canCreateGame() {
    if (gamestates.playerName.isEmpty) {
      const snackBar = SnackBar(content: Text('Name can not be empty'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  bool canJoinGame() {
    if (gamestates.playerName.isEmpty) {
      const snackBar = SnackBar(content: Text('Name can not be empty'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (gamestates.gameCode.isEmpty) {
      const snackBar = SnackBar(content: Text('Game Code can not be empty'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Finder')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            SizedBox(
              width: 512,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                startGameMessage(gamestates.playerName, "reaktor_room").then((
                  value,
                ) {
                  print(value.body);
                });

                if (canCreateGame()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HostGamePage(gameCode: "123"),
                    ),
                  ).then((value) {
                    leaveGame();
                  });
                }
              },
              child: Text("Host a new Game"),
            ),
            Wrap(
              spacing: 8,
              children: [
                SizedBox(
                  width: 512,
                  child: TextField(
                    controller: gameCodeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Game Code',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (canJoinGame()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JoinGameScreen(gameCode: gamestates.gameCode),
                        ),
                      ).then((value) {
                        joinGame(
                          gamestates.gameCode,
                          gamestates.playerName,
                        ).then((value) {
                          print(value);
                        });
                        leaveGame();
                      });
                    }
                  },
                  child: Text("Join a Game"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
