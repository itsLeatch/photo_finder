import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_finder/main.dart';

late WebSocket socket;

final baseUrl = 'https://midnight.ernestsgm.com';

Future<void> setupWebSocked(String gameId, String playerName) async {
  socket = await WebSocket.connect(
    'wss://midnight.ernestsgm.com/game?gameId=$gameId&name=$playerName',
  );
  socket.listen((data) async {
    print('WebSocket message received: $data');
    String type = data.split('"type":"')[1].split('"')[0];
    switch (type) {
      case 'server:gameStarted':
        //TODO: wait for the word in a different way
        //wait for one second to make sure the word is set
        Future.delayed(Duration(seconds: 1), () {
          gamestates.gameController.startGame();
        });
        break;
      case 'server:wordChosen':
        String word = data.split('"word":"')[1].split('"')[0];
        gamestates.gameController.chooseWord(word);
        print('Code word set to: $word');
        break;
      case 'server:photosUpdated':
        //extract all the urls after photo from things like this: {"type":"server:photosUpdated","gameId":"FHOV2L","photos":[{"name":"jj","photo":"https://silo.deployor.dev/midnight-dev/FHOV2L/jj/1767849540692-4f07425d-5826-4b96-b156-3715602e0813846090211747097372.jpg"},{"name":"thug","photo":"https://silo.deployor.dev/midnight-dev/FHOV2L/thug/1767849541199-image_picker_13DBFDF4-70C4-4315-9CDF-73A36B458E51-32527-00000397C3C9BB2F.jpg"}]
        List<String> urls = [];
        String photosPart = data.split('"photos":[')[1].split(']')[0];
        List<String> photoEntries = photosPart.split('},{');
        for (var entry in photoEntries) {
          String url = entry.split('"photo":"')[1].split('"')[0];
          urls.add(url);
        }
        gamestates.imageURLs = urls;
        print('Updated image URLs: $urls');
        int numberOfPlayers = await connectedPlayers(
          gamestates.gameCode,
        ).then((value) => value.length);
        if (gamestates.imageURLs.length >= numberOfPlayers) {
          gamestates.gameController.allPhotosSubmitted();
        }
        break;

      default:
        print('Unknown message type: $type');
    }
  });
}

void startNewGame() {
  socket.add(
    '{"type": "client:startGame", "gameId": "${gamestates.gameCode}", "playerName": "${gamestates.playerName}"}',
  );
}

Future<Response> joinGame(String joinCode, String playerName) async {
  final encodedName = Uri.encodeComponent(playerName);
  final uri = Uri.parse('$baseUrl/games/$joinCode/join?name=$encodedName');

  final response = await get(uri);
  return response;
}

Future<Response> startGameMessage(String hostName, String roomName) async {
  final uri = Uri.parse('$baseUrl/games/start');
  final response = await post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'hostName': hostName, 'roomName': roomName}),
  );
  return response;
}

void leaveGame() async {
  final joinCode = Uri.encodeComponent(gamestates.gameCode);
  final encodedName = Uri.encodeComponent(gamestates.playerName);
  final uri = Uri.parse('$baseUrl/games/$joinCode/leave?name=$encodedName');

  await delete(uri);
}

Future<List<String>> connectedPlayers(String gameCode) async {
  final uri = Uri.parse('$baseUrl/games/$gameCode/players');
  final response = await get(uri);
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    decoded.map((e) => (e as Map<String, dynamic>)['name'] as String).toList();
    List<String> players = List<String>.from(
      decoded.map((e) => e['name'] as String),
    );
    //close the response
    return players;
  } else {
    throw Exception('Failed to load players');
  }
}

Future<bool> uploadImage(XFile imageFile) async {
  /*
  POST /games/:code/upload?name=
:code is the join code
name= has to be the player name
Must serve images as form-data (Multipart files)

header:headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'hostName': hostName, 'gameId': gameId, 'playerName': playerName, }),
  */
  final joinCode = Uri.encodeComponent(gamestates.gameCode);
  final encodedName = Uri.encodeComponent(gamestates.playerName);
  final uri = Uri.parse('$baseUrl/games/$joinCode/upload?name=$encodedName');
  var request = MultipartRequest('POST', uri);
  request.files.add(await MultipartFile.fromPath('images', imageFile.path));
  final streamedResponse = await request.send();
  final response = await Response.fromStream(streamedResponse);
  //response example {"message":"Images uploaded successfully","files":[{"filename":"103f8b1b-1c35-4b99-8f6b-985ab9d49bfa6433108787172316987.jpg","url":"https://silo.deployor.dev/midnight-dev/QS0RJL/testest/1767840594964-103f8b1b-1c35-4b99-8f6b-985ab9d49bfa6433108787172316987.jpg"}
  String url = jsonDecode(response.body)['files'][0]['url'];

  if (socket != null && socket.readyState == WebSocket.open) {
    print('Sending photo URL via WebSocket: $url');
    socket.add(
      jsonEncode({
        'type': 'client:submitPhoto',
        'gameId': gamestates.gameCode,
        'playerName': gamestates.playerName,
        'photo': url,
      }),
    );
  } else {
    print('WebSocket is not connected');
  }

  if (response.statusCode == 200) {
    print('Image uploaded successfully');
    return true;
  } else {
    print('Image upload failed with status: ${response.statusCode}');
    return false;
  }
}
