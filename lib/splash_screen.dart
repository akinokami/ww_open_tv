import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/constants/dimen_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashScreenController = Get.put(SplashScreenController());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/launcher.webp",width: 100.w,height: 100.h,),
            kSizedBoxH30,
             CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
            ),
            kSizedBoxH30,
             CustomText(text: 'please_wait'.tr, ),
          ],
        ),
      ),
    );
  }
}
