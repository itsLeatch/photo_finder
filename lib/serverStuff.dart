import 'dart:convert';

import 'package:http/http.dart';
import 'package:photo_finder/main.dart';

Future<Response> joinGame(String joinCode, String playerName) async {
  final encodedName = Uri.encodeComponent(playerName);
  final uri = Uri.parse(
    'http://midnight.ernestsgm.com/games/$joinCode/join?name=$encodedName',
  );

  final response = await get(uri);
  return response;
}

Future<Response> startGameMessage(String hostName, String roomName) async {
  final uri = Uri.parse('http://midnight.ernestsgm.com/games/start');
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
  final uri = Uri.parse(
    'http://midnight.ernestsgm.com/games/$joinCode/leave?name=$encodedName',
  );

  await delete(uri);
}

Future<List<String>> connectedPlayers(String gameCode) async {
  final baseUrl = 'http://midnight.ernestsgm.com';
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
