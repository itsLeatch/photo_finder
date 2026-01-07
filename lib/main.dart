import 'package:flutter/material.dart';

//screens
import 'package:go_router/go_router.dart';
import 'package:photo_finder/gamestates.dart';
import 'package:photo_finder/hostGamePage.dart';
import 'package:photo_finder/startPage.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => StartPage()),
    GoRoute(
      path: "/hostGame:gameCode",
      builder: (context, state) =>
          HostGamePage(gameCode: state.pathParameters['gameCode']!),
    ),
  ],
);

Gamestates gamestates = Gamestates();

void main() {
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
