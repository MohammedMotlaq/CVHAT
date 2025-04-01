import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0.r)),
      child: Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded,
                size: 50.sp, color: Colors.orange),
            SizedBox(height: 15.h),
            Text(
              "Are you sure?",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              "Do you really want to log out? You will need to log in again.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: AppColors.secondary),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => AppRouter.popWidget(),
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    backgroundColor: AppColors.bgLightGray,
                  ),
                  child: Text("Cancel",
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.textBlack)),
                ),
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
                  return TextButton(
                    onPressed: () async {
                      AppRouter.popWidget();
                      await authProvider.logout();
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      backgroundColor: AppColors.bgRed,
                    ),
                    child: Text("Logout",
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.textWhite)),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
