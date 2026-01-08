//make a listanable class for game controller
import 'package:flutter/material.dart';
import 'package:photo_finder/main.dart';

class GameController extends ChangeNotifier {
  String lastMessage = "";
  void startGame() {
    lastMessage = "gameStarted";
    notifyListeners();
  }

  void chooseWord(String word) {
    gamestates.codeWord = word;
    lastMessage = "wordChosen";
    notifyListeners();
  }

  void allPhotosSubmitted() {
    lastMessage = "allPhotosSubmitted";
    notifyListeners();
  }
}
