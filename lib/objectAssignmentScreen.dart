import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ObjectAssignmentScreen extends StatelessWidget {
  const ObjectAssignmentScreen({super.key, required this.objectToFind});
  final String objectToFind;

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
                animatedTexts: [
                  ScrambleAnimatedText(
                    objectToFind,
                    speed: Duration(
                      milliseconds: (5000 / objectToFind.length).round(),
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
