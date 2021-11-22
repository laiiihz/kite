import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:kite/pages/about.dart';
import 'package:kite/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: HomePage.name,
      routes: {
        HomePage.name: (context) => const HomePage(),
        AboutPage.name: (context) => const AboutPage(),
      },
      builder:BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
