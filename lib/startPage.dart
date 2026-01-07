import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_finder/main.dart';

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
              onPressed: () => context.push("/hostGame:123"),
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
                    print(gamestates.gameCode);
                    context.push("/joinGame:" + gamestates.gameCode);
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
