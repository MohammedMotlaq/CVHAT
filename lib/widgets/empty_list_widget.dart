import 'package:cvhat/core/resources/app_animations.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget(
      {super.key,
      required this.jsonFile,
      required this.title,
      required this.showArrow});

  final String jsonFile;
  final String title;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 390.w,
        ),
        Lottie.asset(jsonFile, width: 250.w, height: 200.h, fit: BoxFit.fill),
        SizedBox(
          height: 10.h,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w100,
              color: AppColors.textSecondary),
        ),
        showArrow
            ? Lottie.asset(
                AppAnimations.arrow,
                width: 180.w,
                height: 180.h,
                fit: BoxFit.fill,
              )
            : const SizedBox(),
      ],
    );
  }
}
