import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/controller/channel_controller.dart';
import 'package:ww_open_tv/screens/channels/player_screen.dart';

import '../../constants/color_const.dart';
import '../../custom_widgets/custom_text.dart';

class FavoriteChannelScreen extends StatelessWidget {
  const FavoriteChannelScreen({super.key});

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
             
              Expanded(
                child: Obx(
                      () => channelController.selectedChannelList.isNotEmpty
                      ? GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0.w,
                        mainAxisSpacing: 0.h,
                        childAspectRatio: 1.5),
                    itemCount: channelController.selectedChannelList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //some code here
                          Get.to(() => PlayerScreen(
                              streammingUrl: channelController
                                  .selectedChannelList[index].url ??
                                  ""));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.r))),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0.h,
                                    right: 0.w,
                                    child: Obx(
                                          ()=>
                                          GestureDetector(
                                            onTap: () {
                                              channelController.addToFavorite(channelController.selectedChannelList[index] );
                                              //some code here
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              //color: Colors.red,
                                              color:channelController.selectedChannelList.contains(channelController.selectedChannelList[index]) ?Colors.red:whiteColor,
                                              size: 15.w,
                                            ),
                                          ),
                                    )),

                                Center(
                                  child: CustomText(
                                    text: channelController
                                        .selectedChannelList[index].name ??
                                        '',
                                    color: blackTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    maxLines: 3,
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
