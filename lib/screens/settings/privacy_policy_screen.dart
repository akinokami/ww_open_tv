import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../controller/language_controller.dart';
import '../../custom_widgets/custom_text.dart';
import '../../utils/global.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: lightWhiteColor),
          title: CustomText(
            text: 'policy'.tr,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                languageController.language.value == "en"
                    ? Global.policyEn
                    : languageController.language.value == "zh"
                        ? Global.policyCn
                        : Global.policyViet,
                style: TextStyle(color: lightWhiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
