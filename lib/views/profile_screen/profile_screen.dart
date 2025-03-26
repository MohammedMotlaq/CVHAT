import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/providers/profile_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/widgets/custom_app_bar.dart';
import 'package:cvhat/widgets/custom_button.dart';
import 'package:cvhat/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();
    return PopScope(
      canPop: false,
      child:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Profile',
            bgColor: AppColors.secondary,
            textColor: AppColors.textWhite,
            onTap: () {
              AppRouter.popWidget();
              Provider.of<UiProvider>(context, listen: false).index = 0;
            },
          ),
          body: Consumer<UiProvider>(builder: (context, uiProvider, child) {
            return SingleChildScrollView(
              child: Container(
                  color: AppColors.secondary,
                  padding: EdgeInsets.only(top: 35.h),
                  width: 390.w,
                  height: 754.h,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 62.h,
                          ),
                          Container(
                            width: 390.w,
                            height: 657.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 18.w),
                            decoration: BoxDecoration(
                                color: AppColors.bgWhite,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.r),
                                    topLeft: Radius.circular(20.r))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 133.h,
                                ),
                                Text(
                                  "${profileProvider.profile!.firstName} ${profileProvider.profile!.lastName}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 32.sp,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  profileProvider.profile!.email,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 36.h,
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                  height: uiProvider.containerHeight,
                                  width: 354.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 0),
                                  decoration: BoxDecoration(
                                    color: AppColors.bgWhite,
                                    borderRadius: BorderRadius.circular(14.r),
                                    boxShadow: uiProvider.editProfile
                                        ? [
                                            BoxShadow(
                                              color: AppColors.bgBlack
                                                  .withValues(alpha: 0.2),
                                              blurRadius: 10,
                                              spreadRadius: 3,
                                              offset: const Offset(4, 4),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: uiProvider.editProfile
                                      ? FutureBuilder(
                                          future: Future.delayed(const Duration(
                                              milliseconds: 400)),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const SizedBox(); // Show nothing while waiting
                                            }
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomTextField(
                                                      width: 145,
                                                      height: 50,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      textEditingController:
                                                          controller,
                                                      hintText: 'First Name',
                                                      inputType:
                                                          TextInputType.text,
                                                    ),
                                                    CustomTextField(
                                                      width: 145,
                                                      height: 50,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      textEditingController:
                                                          controller1,
                                                      hintText: 'Last Name',
                                                      inputType:
                                                          TextInputType.text,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20.h),
                                                CustomTextField(
                                                  width: 309,
                                                  height: 50,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  textEditingController:
                                                      controller2,
                                                  hintText: 'Old Password',
                                                  inputType: TextInputType
                                                      .visiblePassword,
                                                  obscure: true,
                                                  // suffixIcon: IconButton(
                                                  //   icon: Icon(
                                                  //       authFormProvider.isPasswordObscure
                                                  //           ? Icons.visibility_off
                                                  //           : Icons.visibility),
                                                  //   onPressed: authFormProvider
                                                  //       .togglePasswordVisibility,
                                                  // ),
                                                ),
                                                SizedBox(height: 20.h),
                                                CustomTextField(
                                                  width: 309,
                                                  height: 50,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  textEditingController:
                                                      controller3,
                                                  hintText: 'New Password',
                                                  inputType: TextInputType
                                                      .visiblePassword,
                                                  obscure: true,
                                                  // suffixIcon: IconButton(
                                                  //   icon: Icon(authFormProvider
                                                  //           .isConfirmPasswordObscure
                                                  //       ? Icons.visibility_off
                                                  //       : Icons.visibility),
                                                  //   onPressed: authFormProvider
                                                  //       .toggleConfirmPasswordVisibility,
                                                  // ),
                                                ),
                                                SizedBox(height: 20.h),
                                                CustomTextField(
                                                  width: 309,
                                                  height: 50,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  textEditingController:
                                                      controller3,
                                                  hintText:
                                                      'Confirm New Password',
                                                  inputType: TextInputType
                                                      .visiblePassword,
                                                  obscure: true,
                                                  // suffixIcon: IconButton(
                                                  //   icon: Icon(authFormProvider
                                                  //           .isConfirmPasswordObscure
                                                  //       ? Icons.visibility_off
                                                  //       : Icons.visibility),
                                                  //   onPressed: authFormProvider
                                                  //       .toggleConfirmPasswordVisibility,
                                                  // ),
                                                ),
                                              ],
                                            );
                                          })
                                      : const SizedBox(),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                CustomButton(
                                  height: 50,
                                  width: 200,
                                  fontSize: 16,
                                  title: uiProvider.editProfile
                                      ? 'Update'
                                      : 'Edit',
                                  onTap: () {
                                    uiProvider.changeEditProfile();
                                  },
                                )
                                // SizedBox(
                                //   width: 353.w,
                                //   height: 272.h,
                                //   child: RecentReviewsList(
                                //       recentReviews: resents,
                                //       height: 260,
                                //       scrollable: true),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: AppColors.secondary_3,
                        radius: 80.r,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 78.r,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(78.r),
                            child: Image.network(
                              width: 160.w,
                              height: 160.w,
                              profileProvider.profile!.avatarURL,
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.bgWhite,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
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
                                      fontSize: 64.sp,
                                      color: AppColors.textWhite),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          }),
        );
      }),
    );
  }
}
