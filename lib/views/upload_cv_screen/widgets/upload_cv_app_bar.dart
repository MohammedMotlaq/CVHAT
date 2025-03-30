import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/file_picker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UploadCvAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UploadCvAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilePickerProvider>(
        builder: (context, filePickerProvider, child) {
      return AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bgWhite,
        leading: IconButton(
            onPressed: () {
              AppRouter.popWidget();
              filePickerProvider.clearFile();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 32.sp,
              color: AppColors.secondary,
            )),
        title: Text(
          "Upload CV",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              color: AppColors.secondary,
              fontSize: 32.sp),
        ),
        centerTitle: true,
      );
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
