import 'package:flutter/material.dart';
import 'package:photo_finder/main.dart';
import 'package:photo_finder/serverStuff.dart';

class WaitingPlayerList extends StatefulWidget {
  const WaitingPlayerList({super.key});

  @override
  State<WaitingPlayerList> createState() => _WaitingPlayerListState();
}

class _WaitingPlayerListState extends State<WaitingPlayerList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: Stream.periodic(Duration(seconds: 1)).asyncMap((_) => connectedPlayers(gamestates.gameCode)),
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Text('No players waiting');
      } else {
        List<String> waitingPlayers = snapshot.data!;

        return Card(
        child: Column(
          children: waitingPlayers
            .map((player) => ListTile(title: Text(player)))
            .toList(),
        ),
        );
      }
      },
    );
  }
}
