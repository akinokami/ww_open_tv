import 'dart:convert';

import 'package:get/get.dart';
import 'package:ww_open_tv/data/country.dart';
import 'package:ww_open_tv/models/channel_model.dart';
import 'package:ww_open_tv/models/country_model.dart';

import '../data/channel_m3u8.dart';

class NewsController extends GetxController {
  final selectedIndex = 0.obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  Rx<CountryModel> selectedCountry =
      CountryModel(name: 'Afghanistan', code: 'AF', flag: "🇦🇫").obs;
  RxList<ChannelModel> filterList = <ChannelModel>[].obs;

  @override
  void onInit() {
    getCountryList();
    filterChannel(selectedCountry.value.code ?? '');
    super.onInit();
  }

  getCountryList() {
    List<dynamic> list = jsonDecode(countryJson);
    countryList.value =
        list.map((json) => CountryModel.fromJson(json)).toList();
  }

  void filterChannel(String countryCode) {
    filterList.value = channelList
        .where((element) => element.countryCode == countryCode)
        .toList();
  }
}
