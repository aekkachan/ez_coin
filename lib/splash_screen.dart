import 'package:ez_coin/builder/fade_route.dart';
import 'package:ez_coin/home_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Lottie.asset('assets/splash_screen.json',
          controller: _controller, animate: true, onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward().whenComplete(() => Navigator.pushReplacement(context, FadeRoute(page: const HomeManager())));
      }),
    );
  }
}
