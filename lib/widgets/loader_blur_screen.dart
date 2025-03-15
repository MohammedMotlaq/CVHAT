import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/resources/app_colors.dart';

class LoaderBlurScreen extends StatelessWidget {
  const LoaderBlurScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
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
      ]),
    );
  }
}
