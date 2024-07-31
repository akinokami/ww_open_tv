import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_text.dart';
import 'package:ww_open_tv/screens/categories/view_all_screen.dart';

import '../controller/channel_controller.dart';
import '../models/channel_model.dart';
import '../screens/channels/player_screen.dart';
import 'custom_cache_network_image.dart';

class CustomLabelAndListView extends StatelessWidget {
  const CustomLabelAndListView({super.key, required this.label, required this.channelList});
final String label;
final List<ChannelModel> channelList;
  @override
  Widget build(BuildContext context) {
    final channelController = Get.put(ChannelController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: label,fontWeight: FontWeight.w900,fontSize: 16.sp, ),
                GestureDetector(
                    onTap: (){
                      Get.to(ViewAllScreen(label: label, channelList: channelList));
                    },
                    child: CustomText(text: 'view_all'.tr, color: greyColor,fontSize: 12.sp))
              ],
            ),
          ),
          SizedBox(
              height: 130.h,
              child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: channelList.length,
            itemBuilder: (context, index) {
              return  GestureDetector(
                onTap: (){
                  Get.to(() => PlayerScreen(
                      streammingUrl: channelList[index].url ??
                          ""));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150.w,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.r))),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0.h,
                            right: 0.w,
                            child: Obx(()=>
                              GestureDetector(
                                  onTap: () {

                                      channelController.addToFavorite(
                                          channelList[index]);


                                  },
                                  child: Icon(
                                    Icons.favorite,

                                    color:channelController.selectedChannelList.any((element) => element.name==channelList[index].name)? Colors.red:  whiteColor,
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
                                url: channelList[index]
                                    .imageUrl ??
                                    '',
                                width: 45.w,
                                height: 42.h,
                              ),
                              CustomText(
                                text: channelList[
                                index]
                                    .name ??
                                    '',
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
            },
          ))
        ],
      ),
    );
  }
}
