import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon(
      {super.key,
      required this.height,
      required this.width,
      required this.showAnimation});

  final double width;

  final double height;
  final bool showAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          color: AppColors.bgWhite.withValues(alpha: 0.95),
          borderRadius:
              showAnimation ? BorderRadius.zero : BorderRadius.circular(20.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width.w,
          ),
          showAnimation
              ? Lottie.asset(AppAnimations.soon,
                  width: 250.w, height: 250.h, fit: BoxFit.fill)
              : const SizedBox(),
          Text(
            "Coming Soon!",
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
