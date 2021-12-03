// ignore_for_file: prefer_const_constructors

import 'package:bloc_flutter/constants/strings.dart';
import 'package:bloc_flutter/data/model/character.dart';
import 'package:bloc_flutter/view/screens/character_details.dart';
import 'package:bloc_flutter/view/screens/home_screen.dart';
import 'package:bloc_flutter/view/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case characterDetails:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: character,
                ));
    }
  }
}
