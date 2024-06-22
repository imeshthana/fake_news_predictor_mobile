import 'package:fake_news_predictor/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _startAnimation = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _startAnimation = false;
      });
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 207, 207, 207),
        backgroundColor: Colors.white,
        body: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween:
                      Tween<double>(begin: 30, end: _startAnimation ? 30 : 50),
                  curve: Curves.easeInOut,
                  duration: Duration(seconds: 3),
                  builder: (context, size, child) {
                    return Text(
                      'Fake News',
                      style: TextStyle(
                        fontSize: size,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Newsreader',
                      ),
                    );
                  },
                ),
                TweenAnimationBuilder<double>(
                  tween:
                      Tween<double>(begin: 30, end: _startAnimation ? 30 : 50),
                  duration: Duration(seconds: 3),
                  curve: Curves.easeInOut,
                  builder: (context, size, child) {
                    return Text(
                      'Predictor',
                      style: TextStyle(
                        fontSize: size,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Newsreader',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            left: _startAnimation
                ? 0
                : -(size.width / 2 - (size.width * 0.55) / 2),
            top: _startAnimation
                ? 0
                : -(size.height / 2 - (size.height * 0.5) / 2),
            child: Image(
              image: AssetImage("assets/1.png"),
              height: size.height * 0.5,
              width: size.width * 0.65,
              fit: BoxFit.fill,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            right: _startAnimation
                ? 0
                : -(size.width / 2 - (size.width * 0.55) / 2),
            top: _startAnimation
                ? 0
                : -(size.height / 2 - (size.height * 0.5) / 2),
            child: Image(
              image: AssetImage("assets/2.png"),
              height: size.height * 0.5,
              width: size.width * 0.65,
              fit: BoxFit.fill,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            right: _startAnimation
                ? 0
                : -(size.width / 2 - (size.width * 0.55) / 2),
            bottom: _startAnimation
                ? 0
                : -(size.height / 2 - (size.height * 0.5) / 2),
            child: Image(
              image: AssetImage("assets/3.png"),
              height: size.height * 0.5,
              width: size.width * 0.65,
              fit: BoxFit.fill,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            left: _startAnimation
                ? 0
                : -(size.width / 2 - (size.width * 0.55) / 2),
            bottom: _startAnimation
                ? 0
                : -(size.height / 2 - (size.height * 0.5) / 2),
            child: Image(
              image: AssetImage("assets/4.png"),
              height: size.height * 0.5,
              width: size.width * 0.65,
              fit: BoxFit.fill,
            ),
          ),
        ]),
      ),
    );
  }
}
