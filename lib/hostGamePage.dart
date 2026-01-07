import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                ImagePicker().pickImage(source: ImageSource.camera);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}
