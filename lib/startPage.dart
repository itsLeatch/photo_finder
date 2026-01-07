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

  @override
  void initState() {
    nameController.addListener(() {
      gamestates.playerName = nameController.text;
      print(gamestates.playerName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Finder')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your name',
            ),
          ),
          ElevatedButton(
            onPressed: () => context.go("/hostGame:123"),
            child: Text("Host a new Game"),
          ),
          ElevatedButton(
            onPressed: () => print("implement join game"),
            child: Text("Join a Game"),
          ),
        ],
      ),
    );
  }
}
