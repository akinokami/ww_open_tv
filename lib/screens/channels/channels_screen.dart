import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/controller/channel_controller.dart';
import 'package:ww_open_tv/screens/channels/player_screen.dart';

import '../../constants/color_const.dart';
import '../../custom_widgets/custom_text.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final channelController = Get.put(ChannelController());
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Obx(
              () => SizedBox(
                height: 28.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: channelController.countryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          channelController.selectedIndex.value = index;
                          channelController.selectedCountry.value =
                              channelController.countryList[index];
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  channelController.selectedIndex.value == index
                                      ? secondaryColor
                                      : greyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r))),
                          child: CustomText(
                            text: "${channelController.countryList[index].flag ?? ''} ${channelController.countryList[index].name ?? ''}",
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
                  itemCount: channelController.filterList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                       //some code here
                        Get.to(PlayerScreen(url: channelController.filterList[index].url??""));
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
                            text: channelController.filterList[index].name ?? '',
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
