import 'package:flutter/material.dart';
import 'package:photo_finder/waitingPlayerWidget.dart';

class HostGamePage extends StatefulWidget {
  const HostGamePage({super.key, required this.gameCode});
  final String gameCode;

  @override
  State<HostGamePage> createState() => HostGamePageState();
}

class HostGamePageState extends State<HostGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Host Game')),
      body: Center(
        child: Column(
          children: [
            Text('Hosting game with code: ${widget.gameCode}'),
            WaitingPlayerList(),
          ],
        ),
      ),
    );
  }
}
