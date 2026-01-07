import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

//screens
import 'package:go_router/go_router.dart';
import 'package:photo_finder/cameraPreview.dart';
import 'package:photo_finder/gamestates.dart';
import 'package:photo_finder/hostGamePage.dart';
import 'package:photo_finder/joinGameScreen.dart';
import 'package:photo_finder/startPage.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => CameraApp()),
    GoRoute(
      path: "/hostGame:gameCode",
      builder: (context, state) {
        String? gameCode = state.pathParameters['gameCode'];
        if (gameCode == null || gameCode.isEmpty) {
          print("Error no game code provided");
        }
        if (gameCode![0] == ':') {
          gameCode = gameCode.substring(1);
        }

        return HostGamePage(gameCode: gameCode);
      },
    ),
    GoRoute(
      path: "/joinGame:gameCode",
      builder: (context, state) {
        String? gameCode = state.pathParameters['gameCode'];
        if (gameCode == null || gameCode.isEmpty) {
          print("Error no game code provided");
        }
        if (gameCode![0] == ':') {
          gameCode = gameCode.substring(1);
        }

        return JoinGameScreen(gameCode: gameCode);
      },
    ),
  ],
);

Gamestates gamestates = Gamestates();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  gamestates.cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
