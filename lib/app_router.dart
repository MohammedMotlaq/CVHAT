import 'package:flutter/material.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static pushWithReplacement(Widget widget) {
    Navigator.of(navKey.currentContext!)
        .pushReplacement(SlideTransition1(widget));
  }

  static pushWidget(Widget widget) {
    Navigator.of(navKey.currentContext!).push(SlideTransition1(widget));
  }

  static popWidget() {
    if (Navigator.canPop(navKey.currentContext!)) {
      Navigator.pop(navKey.currentContext!);
    }
  }

  static pushAndRemoveUntil(Widget widget) {
    Navigator.of(navKey.currentContext!).pushAndRemoveUntil(
      SlideTransition1(widget),
      (Route<dynamic> route) => false, // This removes all previous routes
    );
  }

  static canPopWidget() {
    return Navigator.canPop(navKey.currentContext!);
  }

  static animatedSwitcher(Widget widget) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      child: widget,
    );
  }
}

class SlideTransition1 extends PageRouteBuilder {
  final Widget page;

  SlideTransition1(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1000),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0))
                    .animate(animation),
                child: page,
              );
            });
}
