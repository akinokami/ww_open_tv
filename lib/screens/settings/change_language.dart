import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../controller/language_controller.dart';
import '../../custom_widgets/custom_text.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          // iconTheme: IconThemeData(color: lightWhiteColor),
          centerTitle: true,
          backgroundColor: primaryColor,
          title: CustomText(
            text: 'change_language'.tr,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          )),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("en", "US");
                    },
                    child: Card(
                      color: cardColor,
                      child: ListTile(
                        leading: Image.asset(
                          "assets/images/usa.webp",
                          width: 20.w,
                          height: 20.h,
                        ),
                        title: const CustomText(
                          text: "English",
                          //color: lightWhiteColor,
                        ),
                        trailing: Icon(
                          languageController.language.value == "en"
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: languageController.language.value == "en"
                              ? secondaryColor
                              : greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("zh", "CN");
                    },
                    child: Card(
                      color: cardColor,
                      child: ListTile(
                        leading: Image.asset(
                          "assets/images/china.webp",
                          width: 20.w,
                          height: 20.h,
                        ),
                        title: const CustomText(
                          text: "中国人",
                          //color: lightWhiteColor,
                        ),
                        trailing: Icon(
                          languageController.language.value == "zh"
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: languageController.language.value == "zh"
                              ? secondaryColor
                              : greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("vi", "VN");
                    },
                    child: Card(
                      color: cardColor,
                      child: ListTile(
                        leading: Image.asset(
                          "assets/images/vietnam.webp",
                          width: 20.w,
                          height: 20.h,
                        ),
                        title: const CustomText(
                          text: "Tiếng Việt",
                          //color: lightWhiteColor,
                        ),
                        trailing: Icon(
                          languageController.language.value == "vi"
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: languageController.language.value == "vi"
                              ? secondaryColor
                              : greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
