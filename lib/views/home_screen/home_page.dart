import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/views/home_screen/widgets/review_card.dart';
import 'package:cvhat/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: const CustomAppbar(userName: "userName")),
      body: Container(
          width: 390.w,
          decoration: BoxDecoration(
              color: AppColors.bgWhite,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r))),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReviewCard(label: "AI Reviews", value: "7"),
                  ReviewCard(label: "Recruiter Feedback", value: "7"),
                ],
              ),
            ],
          )),
    );
  }
}
