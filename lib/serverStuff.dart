import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_finder/main.dart';

final baseUrl = 'https://midnight.ernestsgm.com';

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
  final response = await request.send();
  if (response.statusCode == 200) {
    print('Image uploaded successfully');
    return true;
  } else {
    print('Image upload failed with status: ${response.statusCode}');
    return false;
  }
}
