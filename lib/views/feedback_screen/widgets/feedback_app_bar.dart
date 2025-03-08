import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeedbackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            AppRouter.popWidget();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            size: 32.sp,
            color: AppColors.secondary,
          )),
      title: Text(
        "Feedback",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
            fontSize: 32.sp),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
