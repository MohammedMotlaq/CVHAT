import 'package:cvhat/models/premium_details.dart';
import 'package:cvhat/views/premium_screen/widgets/premium_subscribe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumSubscribeList extends StatelessWidget {
  const PremiumSubscribeList({super.key, required this.premiumList});

  final List<PremiumDetails> premiumList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return PremiumSubscribeWidget(premiumDetails: premiumList[index]);
        },
        separatorBuilder: (context, child) => SizedBox(
              height: 16.h,
            ),
        itemCount: premiumList.length);
  }
}
