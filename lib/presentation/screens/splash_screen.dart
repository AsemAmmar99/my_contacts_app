import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/screens.dart' as screens;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
        const Duration(milliseconds: 2000),
            () {
          Navigator.pushNamedAndRemoveUntil(context, screens.homeLayout, (route) => false);
            },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.indigo,);
  }
}
