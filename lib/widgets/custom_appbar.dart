import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/core/resources/app_icons.dart';
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
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            //AppRouter.pushWidget(const ProfileScreen());
            Scaffold.of(context).openDrawer();
          },
          icon: Image.asset(AppIcons.menu, width: 32.w, height: 32.h),
        ),
        title: Text(
          "C V H A T",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              color: AppColors.textWhite,
              fontSize: 32.sp),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 35.r,
            backgroundColor: AppColors.bgWhite,
            child: Text(
              userName[0].toUpperCase(),
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24.sp,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
