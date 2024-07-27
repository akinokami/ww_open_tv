import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/constants/dimen_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_image_button.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';
import 'package:ww_open_tv/screens/game/game_intro_screen.dart';
import 'package:ww_open_tv/screens/score/score_screen.dart';
import 'package:ww_open_tv/screens/settings/settings_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageButton(
                onTap: () {
                  Get.to(const GameIntroScreen());
                },
                text: "Play"),
            kSizedBoxH10,
            CustomImageButton(
                onTap: () {
                  Get.to(const SettingsScreen());
                },
                text: "Settings"),
            kSizedBoxH10,
            CustomImageButton(
                onTap: () {
                  Get.to(const ScoreScreen());
                },
                text: "Score"),
            kSizedBoxH30,
            CustomText(text: "Version 1.0.0", fontSize: 16.sp),
          ],
        ),
      ),
    );
  }
}
