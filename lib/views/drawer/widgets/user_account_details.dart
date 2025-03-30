import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserAccountDetails extends StatelessWidget {
  const UserAccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          "${profileProvider.profile!.firstName} ${profileProvider.profile!.lastName}",
          style: TextStyle(fontSize: 16.sp),
        ),
        accountEmail: Text(
          profileProvider.profile!.email,
          style: TextStyle(fontSize: 14.sp),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: AppColors.bgWhite,
          radius: 78.r,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(78.r),
              child: Image.network(
                width: 75.w,
                height: 75.w,
                profileProvider.profile!.avatarURL,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return SizedBox(
                      width: 25.w,
                      height: 25.w,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondary,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (context, child, stackTrace) {
                  return Text(
                    profileProvider.profile!.firstName[0] +
                        profileProvider.profile!.lastName[0],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: AppColors.textSecondary),
                  );
                },
              )),
        ),
        decoration: BoxDecoration(color: AppColors.secondary, boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.3),
            spreadRadius: 0.2,
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ]),
      );
    });
  }
}
