import 'package:cvhat/app_router.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/views/auth/register_screen.dart';
import 'package:cvhat/views/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await LocalStorageService.localStorageService.initS();

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.loadUser();

      Future.delayed(const Duration(seconds: 2), () {
        if (authProvider.user != null) {
          AppRouter.pushWithReplacement(HomePage());
        } else {
          AppRouter.pushWithReplacement(const RegisterScreen());
        }
      });
    } catch (e) {
      debugPrint("Error initializing app: $e");
      AppRouter.pushWithReplacement(
          const RegisterScreen()); // Fail-safe navigation
    }
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
