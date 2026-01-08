import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_finder/imagePickerOfCurrentRound.dart';

class ObjectAssignmentScreen extends StatefulWidget {
  ObjectAssignmentScreen({
    super.key,
    required this.objectToFind,
    this.animationDuration = const Duration(seconds: 2),
    this.totalTime = const Duration(seconds: 4),
  });
  final String objectToFind;
  final Duration animationDuration;
  final Duration totalTime;

  @override
  State<ObjectAssignmentScreen> createState() => _ObjectAssignmentScreenState();
}

class _ObjectAssignmentScreenState extends State<ObjectAssignmentScreen> {
  Future<XFile> recivePhoto() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    while (image == null) {
      //open a snackbar saying "No photo taken, please take a photo"
      const snackBar = SnackBar(
        content: Text('No photo taken, please take a photo'),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      await Future.delayed(Duration(seconds: 1));
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    return image;
  }

  @override
  void initState() {
    //after totalTime, navigate to the next screen
    Future.delayed(
      widget.totalTime,
      () => recivePhoto().then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePickerForRound(images: []),
          ),
        );
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: AppBar(title: const Text('Object Assignment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(style: textStyle, "The word is:"),
            DefaultTextStyle(
              style: textStyle!,
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  ScrambleAnimatedText(
                    widget.objectToFind,
                    speed: Duration(
                      milliseconds:
                          (widget.animationDuration.inMilliseconds /
                                  widget.objectToFind.length)
                              .round(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
