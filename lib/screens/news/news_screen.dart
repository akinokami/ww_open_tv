import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/controller/news_controller.dart';

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
                () => ListView.builder(
                  itemCount: newsCountroller.filterList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: newsCountroller.filterList[index].name ?? '',
                            color: whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomText(
                            text:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec odio vitae nunc ultrices ultricies. Donec nec odio vitae nunc ultrices ultricies.',
                            color: whiteColor,
                            fontSize: 14.sp,
                          ),
                        ],
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
