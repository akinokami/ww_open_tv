import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';
import 'package:ww_open_tv/screens/categories/view_all_screen.dart';

import '../controller/channel_controller.dart';
import '../models/channel_model.dart';
import '../screens/channels/player_screen.dart';
import 'custom_cache_network_image.dart';

class CustomRelatedChannel extends StatelessWidget {
  const CustomRelatedChannel({super.key, required this.relatedChannelList, required this.channelModel, required this.fromScreen});

  final List<ChannelModel> relatedChannelList;
  final ChannelModel channelModel;
  final String fromScreen;
  @override
  Widget build(BuildContext context) {
    final channelController = Get.put(ChannelController());
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height:isPortrait? 130.h:200.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: relatedChannelList.length,
                itemBuilder: (context, index) {
                  if (relatedChannelList[index].name != channelModel.name) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerScreen(
                                    fromScreen:fromScreen,
                                    channelModel: relatedChannelList[index],
                                    channelList: relatedChannelList)));
                        // Get.to(() => PlayerScreen(
                        //     fromScreen: 'custom_related',
                        //     channelModel: relatedChannelList[index],
                        //     channelList: relatedChannelList));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width:isPortrait? 150.w:130.w,

                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0.h,
                                right: 0.w,
                                child: Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      channelController.addToFavorite(
                                          relatedChannelList[index]);
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: channelController
                                              .selectedChannelList
                                              .any((element) =>
                                                  element.name ==
                                                  relatedChannelList[index]
                                                      .name)
                                          ? Colors.red
                                          : whiteColor,
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomFastCacheNetworkImage(
                                      url: relatedChannelList[index].imageUrl ??
                                          '',
                                      width: 45.w,
                                      height: 42.h,
                                    ),
                                    CustomText(
                                      text:
                                          relatedChannelList[index].name ?? '',
                                      color: blackTextColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ))
        ],
      ),
    );
  }
}
