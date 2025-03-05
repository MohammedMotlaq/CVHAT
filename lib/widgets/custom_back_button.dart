import 'package:cvhat/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../core/resources/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, uiProvider, child) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(91.w, 60.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r)),
            backgroundColor: AppColors.primary.withOpacity(0.1),
            elevation: 0,
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            uiProvider.resetPasswordChange();
          },
          child: Icon(
            Icons.arrow_back,
            size: 25.w,
            color: AppColors.primary,
          ));
    });
  }
}
