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
      required this.showArrow,
      required this.width,
      required this.height});

  final String jsonFile;
  final String title;
  final bool showArrow;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 390.w,
          height: showArrow ? 70.h : 180.h,
        ),
        Lottie.asset(jsonFile,
            width: width.w, height: height.h, fit: BoxFit.fill),
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
