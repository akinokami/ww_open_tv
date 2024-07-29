import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/controller/news_controller.dart';
import 'package:ww_open_tv/screens/channels/player_screen.dart';

import '../../constants/color_const.dart';
import '../../custom_widgets/custom_text.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsCountroller = Get.put(NewsController());
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Obx(
              () => SizedBox(
                height: 28.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsCountroller.countryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          newsCountroller.selectedIndex.value = index;
                          newsCountroller.selectedCountry.value =
                              newsCountroller.countryList[index];
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  newsCountroller.selectedIndex.value == index
                                      ? secondaryColor
                                      : greyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r))),
                          child: CustomText(
                            text: newsCountroller.countryList[index].name ?? '',
                            color: whiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 2),
                  itemCount: newsCountroller.filterList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                       //some code here
                        Get.to(PlayerScreen(url: newsCountroller.filterList[index].url??""));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        child: Center(
                          child: CustomText(
                            text: newsCountroller.filterList[index].name ?? '',
                            color: whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
