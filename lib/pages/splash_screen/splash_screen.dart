import 'package:_1_projeto/pages/login/login_page.dart';
import 'package:_1_projeto/pages/main_page.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    carregarHome();
  }

  carregarHome() async {
    
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id');
    if (userId == null) {
      Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
     });
    }
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.red,
              Colors.purple,
            ],
                stops: [
              0.3,
              0.7,
            ])),
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Hello world!',
                textStyle: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 50),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
      ),
    ));
  }
}