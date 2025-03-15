import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSelected,
      required this.onTap});

  final String title;
  final String icon;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.secondary.withValues(alpha: 0.04)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: ListTile(
        leading: Image.asset(
          icon,
          width: 24.w,
          height: 24.h,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.normal),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
