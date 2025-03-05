import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: CircleAvatar(
          radius: 35.r,
          backgroundColor: AppColors.bgWhite,
          child: Text(
            userName[0],
            style: TextStyle(color: AppColors.textPrimary, fontSize: 24.sp),
          ),
        ),
        title: Text(
          "CVHAT",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
              fontSize: 32.sp),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.settings,
            size: 40.r,
            color: AppColors.bgWhite,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
