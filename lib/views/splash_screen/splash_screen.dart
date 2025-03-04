import 'package:cvhat/app_router.dart';
import 'package:cvhat/views/auth/register_screen.dart';
import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      AppRouter.pushWidget(const RegisterScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: LogoWidget(
        width: 177,
        height: 189,
      ),
    );
  }
}
