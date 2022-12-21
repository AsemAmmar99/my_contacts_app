import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_contacts_app/presentation/styles/colors.dart';
import 'package:my_contacts_app/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../constants/screens.dart' as screens;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
        vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
        animationBehavior: AnimationBehavior.preserve,
        value: 1,
        vsync: this,
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.ease),
    );

    Timer(
        const Duration(milliseconds: 4000),
            () {
          Navigator.pushNamedAndRemoveUntil(context, screens.homeLayout, (route) => false);
            },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 100.h),
              duration: const Duration(milliseconds: 3000),
              builder: (BuildContext context, double? value, Widget? child) =>
            Container(
              height: value,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    skyBlue,
                    lightSkyBlue,
                    skyBlue,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    'assets/contacts_logo.png',
                    height: 30.h,
                    width: 70.w,
                  ),
                ),
                SlideTransition(
                  position: _slideAnimation,
                  child: DefaultText(
                      text: 'MY CONTACTS',
                    color: darkPurple,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
