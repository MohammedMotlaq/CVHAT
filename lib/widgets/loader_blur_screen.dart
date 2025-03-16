import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/resources/app_colors.dart';

class LoaderBlurScreen extends StatelessWidget {
  const LoaderBlurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white.withValues(alpha: 0.4),
      ),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.secondaryWithOpacity,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ],
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: const CircularProgressIndicator(
                backgroundColor: AppColors.bgWhite,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
