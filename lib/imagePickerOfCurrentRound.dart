import 'package:flutter/material.dart';

class ImagePickerForRound extends StatefulWidget {
  ImagePickerForRound({super.key, required this.images});
  List<String> images;

  @override
  State<ImagePickerForRound> createState() => ImagePickerForRoundState();
}

class ImagePickerForRoundState extends State<ImagePickerForRound> {
  int currentSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images of Current Round')),
      body: ListView.builder(
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          Color fillColor = index == currentSelectedIndex
              ? Colors.blue
              : Colors.transparent;

          return GestureDetector(
            onTap: () {
              setState(() {
                currentSelectedIndex = index;
              });
            },
            child: Card(
              color: fillColor,
              child: SizedBox(
                height: 600,
                child: Image.network(widget.images[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
