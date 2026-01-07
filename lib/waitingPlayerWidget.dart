import 'package:flutter/material.dart';

class WaitingPlayerList extends StatefulWidget {
  const WaitingPlayerList({super.key});

  @override
  State<WaitingPlayerList> createState() => _WaitingPlayerListState();
}

class _WaitingPlayerListState extends State<WaitingPlayerList> {
  List<String> getWaitingPlayers() {
    // This would normally fetch data from a backend or state management solution
    return ["Player1", "Player2", "Player3"];
  }

  @override
  Widget build(BuildContext context) {
    var waitingPlayers = getWaitingPlayers();

    return Card(
      child: Column(
        children: waitingPlayers
            .map((player) => ListTile(title: Text(player)))
            .toList(),
      ),
    );
  }
}
