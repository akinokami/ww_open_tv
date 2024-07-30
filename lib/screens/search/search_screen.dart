import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';

import '../../controller/search_controller.dart';
import '../../custom_widgets/custom_text.dart';
import '../channels/player_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scController = Get.put(SearchChannelController());
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 20.h,
        backgroundColor: primaryColor,
        title: const Text(''),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: TextField(
              controller: scController.channelTxtController,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
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
                        style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                  ),
                ),
                hintText: '${'search'.tr} ${'channel'.tr}',
                hintStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
                prefixIcon:
                    Icon(Icons.search, color: Colors.white, size: 18.sp),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Colors.white),
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
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                  childAspectRatio: 2),
                          itemCount: scController.cList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                //some code here
                                Get.to(() => PlayerScreen(
                                    streammingUrl:
                                        scController.cList[index].url ?? ""));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h),
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.r))),
                                child: Center(
                                  child: CustomText(
                                    text: scController.cList[index].name ?? '',
                                    color: whiteColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
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
    );
  }
}
