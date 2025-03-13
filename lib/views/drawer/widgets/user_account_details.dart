import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/core/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAccountDetails extends StatelessWidget {
  const UserAccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        "Mohammed Motlaq",
        style: TextStyle(fontSize: 16.sp),
      ),
      accountEmail: Text(
        "Mobile Developer",
        style: TextStyle(fontSize: 14.sp),
      ),
      currentAccountPicture: CircleAvatar(
        radius: 100.r,
        backgroundColor: AppColors.bgWhite,
        backgroundImage: const AssetImage(
          AppIcons.cv,
        ),
      ),
      decoration: BoxDecoration(color: AppColors.secondary, boxShadow: [
        BoxShadow(
          color: AppColors.secondary.withOpacity(0.3),
          spreadRadius: 0.2,
          blurRadius: 10,
          offset: const Offset(0, 6),
        )
      ]),
    );
  }
}
