import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:schoolnotes/pages/auth_pages/login_page.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/education.json'),
      nextScreen: LoginPage(),
      backgroundColor: const Color.fromARGB(255, 137, 240, 140),
      splashIconSize: 250,
      duration: 2000,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: const Duration(seconds: 0),
    );
  }
}
