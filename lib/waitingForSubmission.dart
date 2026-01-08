//dissplay that you are waiting for submission of other players
import 'package:flutter/material.dart';
import 'package:photo_finder/imagePickerOfCurrentRound.dart';
import 'package:photo_finder/main.dart';
import 'package:photo_finder/waitingPlayerWidget.dart';
class WaitingForSubmission extends StatefulWidget {
  const WaitingForSubmission({super.key});

  @override
  State<WaitingForSubmission> createState() => _WaitingForSubmissionState();
}

class _WaitingForSubmissionState extends State<WaitingForSubmission> {
  late VoidCallback _listener;

  @override
  void initState() {
    _listener = () {
      if (gamestates.gameController.lastMessage == "allPhotosSubmitted") {
        //navigate to next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImagePickerForRound(images: gamestates.imageURLs,)),
        );
      }
    };
    gamestates.gameController.addListener(_listener);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waiting for Submissions')),
      body: Center(child: Text('Waiting for players to submit photos...'),)
    );
  }

  @override
  void dispose() {
    gamestates.gameController.removeListener(_listener);
    super.dispose();
  }
}