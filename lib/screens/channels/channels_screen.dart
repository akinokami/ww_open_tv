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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => SizedBox(
                  height: 29.h,
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
                            channelController.filterChannel(
                                channelController.countryList[index].code ?? '');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    channelController.selectedIndex.value == index
                                        ? secondaryColor
                                        : whiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r))),
                            child: CustomText(
                              text:
                                  "${channelController.countryList[index].flag ?? ''} ${channelController.countryList[index].name ?? ''}",
                              color:channelController.selectedIndex.value == index?whiteColor: blackTextColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Obx(
                  () => channelController.filterList.isNotEmpty
                      ? GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.w,
                              mainAxisSpacing: 0.h,
                              childAspectRatio: 1.5),
                          itemCount: channelController.filterList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                //some code here
                                Get.to(() => PlayerScreen(
                                    streammingUrl:
                                        channelController.filterList[index].url ??
                                            ""));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(

                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.r))),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0.h,
                                          right: 0.w,
                                          child:GestureDetector(
                                            onTap: (){
                                              //some code here
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5.w),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: secondaryColor,
                                                ),
                                                child: Icon(Icons.favorite,color: whiteColor,size: 15.w,)),
                                          )

                                      ),
                                      Center(
                                        child: CustomText(
                                          text: channelController
                                                  .filterList[index].name ??
                                              '',
                                          color: blackTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: CustomText(text: 'no_data_found'.tr),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
