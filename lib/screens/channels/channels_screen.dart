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
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButton<String>(
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10.r),
                    value: channelController.selectedCountry.value.code,
                    items: channelController.countryList.map((country) {
                      return DropdownMenuItem<String>(
                        value: country.code,
                        child:
                            Text("${country.flag ?? ''} ${country.name ?? ''}"),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        final selectedCountry = channelController.countryList
                            .firstWhere((country) => country.code == newValue);
                        channelController.selectedCountry.value =
                            selectedCountry;
                        channelController.filterChannel(newValue);
                      }
                    },
                    dropdownColor: whiteColor,
                    style: TextStyle(color: blackTextColor),
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                    streammingUrl: channelController
                                            .filterList[index].url ??
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
                                            () => GestureDetector(
                                              onTap: () {
                                                channelController.addToFavorite(
                                                    channelController
                                                        .filterList[index]);
                                                //some code here
                                              },
                                              child: Icon(
                                                channelController
                                                        .selectedChannelList
                                                        .any((item) =>
                                                            item.name ==
                                                            channelController
                                                                .filterList[
                                                                    index]
                                                                .name)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: channelController
                                                        .selectedChannelList
                                                        .any((item) =>
                                                            item.name ==
                                                            channelController
                                                                .filterList[
                                                                    index]
                                                                .name)
                                                    ? Colors.red
                                                    : greyColor,
                                                size: 15.w,
                                              ),
                                            ),
                                          )),
                                      // Positioned(
                                      //     top: 0.h,
                                      //     left: 0.w,
                                      //     child: CustomText(
                                      //   text: channelController
                                      //           .selectedCountry.value.flag ??
                                      //       "",
                                      // )),
                                      Center(
                                        child: Column(
                                          children: [
                                            Image.network(
                                              channelController
                                                      .filterList[index]
                                                      .imageUrl ??
                                                  '',
                                              width: 50.w,
                                              height: 50.h,
                                            ),
                                            CustomText(
                                              text: channelController
                                                      .filterList[index].name ??
                                                  '',
                                              color: blackTextColor,
                                              fontSize: 14.sp,
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
              ),
            ],
          ),
        ));
  }
}
