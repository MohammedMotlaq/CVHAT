import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_colors.dart';
import 'package:cvhat/core/resources/app_icons.dart';
import 'package:cvhat/providers/auth_provider.dart';
import 'package:cvhat/providers/ui_provider.dart';
import 'package:cvhat/views/drawer/widgets/list_tile_widget.dart';
import 'package:cvhat/views/drawer/widgets/user_account_details.dart';
import 'package:cvhat/views/premium_screen/premium_screen.dart';
import 'package:cvhat/views/profile_screen/profile_screen.dart';
import 'package:cvhat/widgets/loader_blur_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColors.bgWhite,
        child: Consumer2<UiProvider, AuthProvider>(
          builder: (context, uiProvider, authProvider, child) {
            return Column(
              children: [
                const UserAccountDetails(),
                SizedBox(
                  height: 360.h,
                  width: 280.w,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTileWidget(
                            title: uiProvider.drawerList[index]["title"],
                            icon: index == uiProvider.index
                                ? uiProvider.drawerList[index]["filled_icon"]
                                : uiProvider.drawerList[index]["icon"],
                            isSelected:
                                index == uiProvider.index ? true : false,
                            onTap: () {
                              uiProvider.setIndex(index);
                              switch (uiProvider.index) {
                                case 0:
                                  AppRouter.popWidget();
                                  break;
                                case 1:
                                  break;
                                case 2:
                                  AppRouter.popWidget();
                                  AppRouter.pushWidget(const ProfileScreen());
                                  break;
                                case 3:
                                  AppRouter.popWidget();
                                  AppRouter.pushWidget(const PremiumScreen());
                                  break;
                              }
                            });
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: 4),
                ),
                const Spacer(),
                ListTileWidget(
                    title: "Logout",
                    icon: AppIcons.logout,
                    isSelected: false,
                    onTap: () async {
                      AppRouter.popWidget();
                      await authProvider.logout();
                    }),
                SizedBox(
                  height: 20.h,
                ),
              ],
            );
          },
        ));
  }
}
