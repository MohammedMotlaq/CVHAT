import 'package:cvhat/src/core/resources/app_icons.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AppIcons.logo, width: 150, height: 150)),
    );
  }
}
