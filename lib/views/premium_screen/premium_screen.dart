import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_icons.dart';
import 'package:cvhat/data/dummy_data.dart';
import 'package:cvhat/models/premium_details.dart';
import 'package:cvhat/views/premium_screen/widgets/premium_subscribe_list.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/app_colors.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PremiumDetails> premium = DummyData.premiumOffers
        .map((json) => PremiumDetails.fromJson(json))
        .toList();
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: CustomAppBar(
          title: "",
          bgColor: AppColors.bgWhite,
          textColor: AppColors.secondary,
          onTap: () {
            AppRouter.popWidget();
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            width: 390.w,
          ),
          Text(
            "Get Premium",
            style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 32.sp),
          ),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            width: 300.w,
            child: Text(
              "Unlock all the power of this mobile tool and enjoy digital experience like never before!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.7),
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Image.asset(
            AppIcons.premium,
            width: 340.w,
            height: 164,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 48.h,
          ),
          SizedBox(
              width: 350.w,
              height: 200.h,
              child: PremiumSubscribeList(
                premiumList: premium,
              )),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
              height: 50,
              width: 350,
              title: 'Start 30-day free trial',
              fontSize: 14,
              onTap: () {}),
          SizedBox(
            height: 25.h,
          ),
          SizedBox(
            width: 350.w,
            height: 50.h,
            child: Text(
              "By placing this order, you agree to the Terms of Service and Privacy Policy. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.secondary),
            ),
          )
        ],
      ),
    );
  }
}
