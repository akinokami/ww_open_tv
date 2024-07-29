import 'package:get/get.dart';
import 'package:ww_open_tv/models/channel_model.dart';
import 'package:ww_open_tv/models/country_model.dart';

import '../data/channel_m3u8.dart';

class NewsController extends GetxController {
  final selectedIndex = 0.obs;
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  Rx<CountryModel> selectedCountry =
      CountryModel(id: 1, name: 'Myanmar', code: 'mm').obs;
  RxList<ChannelModel> filterList = <ChannelModel>[].obs;

  @override
  void onInit() {
    getCountryList();
    filterChannel(selectedCountry.value.code ?? '');
    super.onInit();
  }

  getCountryList() {
    countryList.value = [
      CountryModel(id: 1, name: 'Myanmar', code: 'mm'),
      CountryModel(id: 2, name: 'Thailand', code: 'th'),
      CountryModel(id: 3, name: 'Singapore', code: 'sg'),
      CountryModel(id: 4, name: 'Malaysia', code: 'my'),
      CountryModel(id: 5, name: 'Indonesia', code: 'id'),
      CountryModel(id: 6, name: 'Vietnam', code: 'vn'),
      CountryModel(id: 7, name: 'Philippines', code: 'ph'),
      CountryModel(id: 8, name: 'Cambodia', code: 'kh'),
      CountryModel(id: 9, name: 'Laos', code: 'la'),
      CountryModel(id: 10, name: 'Brunei', code: 'bn'),
    ];
  }

  void filterChannel(String countryCode) {
    filterList.value = channelList
        .where((element) => element.countryCode == countryCode)
        .toList();
  }
}
