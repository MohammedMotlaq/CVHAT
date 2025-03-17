import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.textColor,
      required this.onTap});

  final String title;
  final Color bgColor;
  final Color textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: bgColor,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 32.sp,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            color: textColor),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: () => onTap(),
          icon: Icon(
            Icons.arrow_back,
            size: 32.w,
            color: textColor,
          )),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
