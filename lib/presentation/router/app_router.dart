import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentation/screens/home_layout.dart';
import 'package:my_contacts_app/presentation/screens/splash_screen.dart';
import '../../constants/screens.dart' as screens;

class AppRouter{
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings){
    startScreen = const SplashScreen();

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case screens.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      default:
        return null;
    }
  }
}