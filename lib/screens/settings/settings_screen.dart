import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/constants/dimen_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_card.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10.w),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/images/left_btn.webp",
                width: 10.w,
                height: 10.h,
              )),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: CustomText(
          text: "Settings",
          fontSize: 16.sp,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kSizedBoxH10,
          const CustomText(text: "Sound Settings"),
          CustomCard(
              widget: Container(
            padding: EdgeInsets.all(10.w),
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                //color: color ?? cardColor,
                image: DecorationImage(
              image: AssetImage("assets/images/wood_bgg.webp"),
              fit: BoxFit.cover,
            )),
            child: Row(
              children: [
                CustomText(
                  text: "Sound",
                  fontSize: 14.sp,
                ),
                const Spacer(),
                Icon(
                  Icons.volume_up,
                  color: Colors.white,
                  size: 25.w,
                ),
                // Image.asset(
                //   "assets/images/sound_btn.webp",
                //   width: 25.w,
                //   height: 25.h,
                // ),
              ],
            ),
          )),
          kSizedBoxH10,
          const CustomText(text: "Score Settings"),
          CustomCard(
              widget: Container(
            padding: EdgeInsets.all(10.w),
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                //color: color ?? cardColor,
                image: DecorationImage(
              image: AssetImage("assets/images/wood_bgg.webp"),
              fit: BoxFit.cover,
            )),
            child: Row(
              children: [
                CustomText(
                  text: "Reset Score",
                  fontSize: 14.sp,
                ),
                const Spacer(),
                Icon(
                  Icons.cleaning_services_rounded,
                  color: Colors.white,
                  size: 25.w,
                ),
                // Image.asset(
                //   "assets/images/sound_btn.webp",
                //   width: 25.w,
                //   height: 25.h,
                // ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
