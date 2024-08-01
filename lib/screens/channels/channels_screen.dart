import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ww_open_tv/controller/channel_controller.dart';
import 'package:ww_open_tv/custom_widgets/custom_cache_network_image.dart';
import 'package:ww_open_tv/screens/channels/player_screen.dart';

import '../../constants/color_const.dart';
import '../../controller/language_controller.dart';
import '../../custom_widgets/custom_text.dart';
import '../../utils/global.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';
  final languageController = Get.put(LanguageController());
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final box = GetStorage();
    first = box.read('first') ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (first == '') {
        return showDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Builder(builder: (context) {
            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return AlertDialog(
                  surfaceTintColor: whiteColor,
                  backgroundColor: whiteColor,
                  title: CustomText(
                    text: 'policy'.tr,
                    fontWeight: FontWeight.w500,
                  ),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Text(
                            languageController.language.value == "en"
                                ? Global.policyEn
                                : Global.policyCn,
                            style: TextStyle(fontSize: 12.sp)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              activeColor: Colors.green,
                              side: BorderSide(
                                width: 1.5,
                                color: isChecked ? Colors.green : Colors.black,
                              ),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                  if (isChecked) {
                                    isAccepted = true;
                                  } else {
                                    isAccepted = false;
                                  }
                                });
                              },
                            ),
                            CustomText(
                              text: 'agree'.tr,
                              fontSize: 12.sp,
                            )
                          ],
                        ),
                        MaterialButton(
                          disabledColor: Colors.grey,
                          color: isAccepted ? secondaryColor : Colors.black,
                          onPressed: isAccepted
                              ? () {
                                  final box = GetStorage();
                                  box.write('first', 'notfirst');
                                  Navigator.pop(context);
                                }
                              : null,
                          child: CustomText(
                            text: 'accept'.tr,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                  ),
                );
              },
            );
          }),
        );
      }
    });
  }

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
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(10.r),
                      value: channelController.selectedCountry.value.code,
                      items: channelController.countryList.map((country) {
                        return DropdownMenuItem<String>(
                          value: country.code,
                          child: Text(
                              "${country.flag ?? ''}   ${country.name ?? ''}"),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          final selectedCountry = channelController.countryList
                              .firstWhere(
                                  (country) => country.code == newValue);
                          channelController.selectedCountry.value =
                              selectedCountry;
                          channelController.filterChannel(newValue);
                        }
                      },
                      dropdownColor: whiteColor,
                      style: TextStyle(color: blackTextColor),
                    ),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Obx(
                  () => channelController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : channelController.filterList.isNotEmpty
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0.w,
                                      mainAxisSpacing: 0.h,
                                      childAspectRatio: 1.4),
                              itemCount: channelController.filterList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //some code here
                                    Get.to(() => PlayerScreen(
                                      fromScreen: 'channel',
                                        channelList: channelController.filterList,
                                        channelModel: channelController
                                                .filterList[index]));
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => PlayerScreen(
                                    //             streammingUrl: channelController
                                    //                     .filterList[index]
                                    //                     .url ??
                                    //                 "")));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                          color: cardColor,
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
                                                    channelController
                                                        .addToFavorite(
                                                            channelController
                                                                    .filterList[
                                                                index]);
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
                                                    size: 20.w,
                                                  ),
                                                ),
                                              )),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
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
                                                  text: channelController
                                                          .filterList[index]
                                                          .name ??
                                                      '',
                                                  color: blackTextColor,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
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
