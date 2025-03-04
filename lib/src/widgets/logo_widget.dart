import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/resources/app_icons.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(AppIcons.logo, width: width.w, height: height.h));
  }
}
