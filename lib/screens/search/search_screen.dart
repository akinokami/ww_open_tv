import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';

import '../../controller/channel_controller.dart';
import '../../controller/search_controller.dart';
import '../../custom_widgets/custom_cache_network_image.dart';
import '../../custom_widgets/custom_text.dart';
import '../channels/player_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scController = Get.put(SearchChannelController());
    final channelController = Get.put(ChannelController());
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 10.h,
        backgroundColor: primaryColor,
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 40.h,
                child: TextField(
                  controller: scController.channelTxtController,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      scController.channelTxtController;
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.w),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: MaterialButton(
                        color: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        onPressed: () {
                          scController.searchAllChannel(
                              scController.channelTxtController.text);
                        },
                        child: Text('search'.tr,
                            style: TextStyle(
                                color: Colors.white, fontSize: 10.sp)),
                      ),
                    ),
                    hintText: '${'search'.tr} ${'channel'.tr}',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.black, size: 18.sp),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => scController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : scController.cList.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0.w,
                                    mainAxisSpacing: 0.h,
                                    childAspectRatio: 1.4),
                            itemCount: scController.cList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  //some code here
                                  Get.to(() => PlayerScreen(
                                      streammingUrl:
                                          scController.cList[index].url ?? ""));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: 0.h,
                                            right: 0.w,
                                            child: GestureDetector(
                                              onTap: () {
                                                //some code here
                                              },
                                              child: Icon(
                                                channelController
                                                        .selectedChannelList
                                                        .any((item) =>
                                                            item.name ==
                                                            scController
                                                                .cList[index]
                                                                .name)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: channelController
                                                        .selectedChannelList
                                                        .any((item) =>
                                                            item.name ==
                                                            scController
                                                                .cList[index]
                                                                .name)
                                                    ? Colors.red
                                                    : greyColor,
                                                size: 15.w,
                                              ),
                                            )),
                                        Center(
                                          child: Column(
                                            children: [
                                              CustomFastCacheNetworkImage(
                                                url: channelController
                                                        .filterList[index]
                                                        .imageUrl ??
                                                    '',
                                                width: 45.w,
                                                height: 42.h,
                                              ),
                                              CustomText(
                                                maxLines: 3,
                                                text: scController
                                                        .cList[index].name ??
                                                    '',
                                                fontSize: 12.sp,
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
                            child: CustomText(text: 'no_channel_found'.tr),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
