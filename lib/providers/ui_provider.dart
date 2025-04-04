import 'package:cvhat/app_router.dart';
import 'package:cvhat/core/resources/app_icons.dart';
import 'package:cvhat/views/favorite_screen/favorite_screen.dart';
import 'package:cvhat/views/premium_screen/premium_screen.dart';
import 'package:cvhat/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

enum AuthState { login, signup, forgetPassword, otp, confirmPassword }

class UiProvider extends ChangeNotifier {
  AuthState _authState = AuthState.login;

  AuthState get authState => _authState;

  void setAuthState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  int index = 0;

  List drawerList = [
    {
      "title": "Home",
      "icon": AppIcons.home,
      "filled_icon": AppIcons.homeFilled,
    },
    {
      "title": "Favorites",
      "icon": AppIcons.favorite,
      "filled_icon": AppIcons.favoriteFilled,
    },
    {
      "title": "Profile",
      "icon": AppIcons.profile,
      "filled_icon": AppIcons.profileFilled,
    },
    {
      "title": "Premium",
      "icon": AppIcons.premium,
      "filled_icon": AppIcons.premiumFilled,
    }
  ];

  void setIndex(int value) {
    index = value;
    notifyListeners();
  }

  void changeDrawerStatus() {
    switch (index) {
      case 0:
        AppRouter.popWidget();
        break;
      case 1:
        AppRouter.popWidget();
        AppRouter.pushWidget(FavoriteScreen());
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
    notifyListeners();
  }

  IconData getIcon(int itemIndex) {
    return index == itemIndex
        ? drawerList[itemIndex]["selectedIcon"]
            as IconData // Ensure it's casted correctly
        : drawerList[itemIndex]["icon"];
  }

  bool editProfile = false;
  double containerHeight = 0;

  void changeEditProfile() {
    editProfile = !editProfile;
    containerHeight = editProfile ? 320 : 0;
    notifyListeners();
  }
}
