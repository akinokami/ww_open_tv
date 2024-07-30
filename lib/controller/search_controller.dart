import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/channel_list.dart';
import '../models/channel_model.dart';

class SearchChannelController extends GetxController {
  final isLoading = false.obs;
  final channelTxtController = TextEditingController();
  RxList<ChannelModel> cList = <ChannelModel>[].obs;

  @override
  void onInit() {
    //
    super.onInit();
  }

  searchAllChannel(String name) {
    isLoading.value = true;
    cList.value = channelList
        .where((element) =>
            element.name!.toLowerCase().contains(name.toLowerCase()))
        .toList();
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }
}
