import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ww_open_tv/data/country.dart';
import 'package:ww_open_tv/models/channel_model.dart';
import 'package:ww_open_tv/models/country_model.dart';

import '../data/channel_m3u8.dart';

class ChannelController extends GetxController {
  final box = GetStorage();
  final fav = ''.obs;
  final selectedIndex = 0.obs;
  final selectedChannelList = <ChannelModel>[].obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  Rx<CountryModel> selectedCountry =
      CountryModel(name: 'Afghanistan', code: 'AF', flag: "🇦🇫").obs;
  RxList<ChannelModel> filterList = <ChannelModel>[].obs;
  final isLoading = false.obs;
  final isFavLoading = false.obs;

  @override
  void onInit() {
    getCountryList();

    getCarts();
    filterChannel(selectedCountry.value.code ?? '');
    super.onInit();
  }

  void getCarts() {
    isFavLoading.value = true;
    fav.value = box.read('fav') ?? '[]';
    selectedChannelList.clear();
    selectedChannelList.addAll(jsonDecode(fav.value).map<ChannelModel>((item) {
      return ChannelModel.fromJson(item);
    }));
    Future.delayed(const Duration(milliseconds: 500), () {
      isFavLoading.value = false;
    });
  }
  void removeFromCart(ChannelModel item) {
    selectedChannelList.removeWhere((fav) => fav.countryCode == item.countryCode);
    updateCartList(); // Call updateCartList to refresh UI and storage
  }
  void updateCartList() {
    // Update the UI
    update();
    // Update the storage
    box.write('carts', jsonEncode(selectedChannelList.map((item) => item.toJson()).toList()));
  }
  getCountryList() {
    List<dynamic> list = jsonDecode(countryJson);
    countryList.value =
        list.map((json) => CountryModel.fromJson(json)).toList();
  }

  void filterChannel(String countryCode) {
    isLoading.value = true;
    filterList.value = channelList
        .where((element) =>
            element.countryCode?.toLowerCase() == countryCode.toLowerCase())
        .toList();
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void addToFavorite(ChannelModel channel) {
    if (selectedChannelList.contains(channel)) {
      selectedChannelList.remove(channel);
      return;
    } else {
      selectedChannelList.add(channel);
    }
    box.remove('fav');
    box.write('fav', jsonEncode(selectedChannelList));
    print("Add to fav $selectedChannelList");
    print("box read ${box.read('fav')}");
  }
}
