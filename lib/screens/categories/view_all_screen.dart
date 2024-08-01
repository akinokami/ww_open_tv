import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/color_const.dart';
import '../../controller/channel_controller.dart';
import '../../custom_widgets/custom_cache_network_image.dart';
import '../../custom_widgets/custom_text.dart';
import '../../models/channel_model.dart';
import '../channels/player_screen.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key, required this.label, required this.channelList});
final String label;
final List<ChannelModel> channelList;
  @override
  Widget build(BuildContext context) {
    final channelController = Get.put(ChannelController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: CustomText(
          text: label,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: channelList.isNotEmpty
                  ? GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.w,
                    mainAxisSpacing: 0.h,
                    childAspectRatio: 1.4),
                itemCount: channelList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(() => PlayerScreen(
                          channelModel: channelList[index]));
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
              )
                  : Center(
                child: CustomText(text: 'no_data_found'.tr),
              ),
            ),

        ],
      ),
    );
  }
}
