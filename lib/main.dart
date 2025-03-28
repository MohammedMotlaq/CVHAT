import 'package:cvhat/providers.dart';
import 'package:cvhat/services/local_storage_service.dart';
import 'package:cvhat/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'core/resources/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.localStorageService.initS();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              navigatorKey: AppRouter.navKey,
              theme: ThemeData(
                fontFamily: 'Inter',
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          }),
    );
  }
}
