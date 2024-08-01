import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/constants/color_const.dart';
import 'package:ww_open_tv/custom_widgets/custom_label_and_listview.dart';
import 'package:ww_open_tv/data/channel_m3u8.dart';

import '../../controller/channel_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final channelController = Get.put(ChannelController());
    var allChannels = channelList;
    var sportsChannels = allChannels.where((element) => element.category == "sports").toList();
    var noGenreChannels = allChannels.where((element) => element.category == "").toList();
    var newsChannels = allChannels.where((element) => element.category == "news").toList();
    var musicChannels = allChannels.where((element) => element.category == "music").toList();
    var movieChannels = allChannels.where((element) => element.category == "movies").toList();
    var religiousChannels = allChannels.where((element) => element.category == "religious").toList();
    var educationChannels = allChannels.where((element) => element.category == "education").toList();
    var autoChannels = allChannels.where((element) => element.category == "auto").toList();
    var animationChannels = allChannels.where((element) => element.category == "animation").toList();
    var businessChannels = allChannels.where((element) => element.category == "business").toList();
    var classicChannels = allChannels.where((element) => element.category == "classic").toList();
    var comedyChannels = allChannels.where((element) => element.category == "comedy").toList();
    var cookingChannels = allChannels.where((element) => element.category == "cooking").toList();
    var cultureChannels = allChannels.where((element) => element.category == "culture").toList();
    var documentaryChannels = allChannels.where((element) => element.category == "documentary").toList();
    var entertainmentChannels = allChannels.where((element) => element.category == "entertainment").toList();
    var familyChannels = allChannels.where((element) => element.category == "family").toList();
    var generalChannels = allChannels.where((element) => element.category == "general").toList();
    var kidsChannels = allChannels.where((element) => element.category == "kids").toList();
    var legislativeChannels = allChannels.where((element) => element.category == "legislative").toList();
    var lifestyleChannels = allChannels.where((element) => element.category == "lifestyle").toList();
    var outdoorChannels = allChannels.where((element) => element.category == "outdoor").toList();
    var relaxChannels = allChannels.where((element) => element.category == "relax").toList();
    var seriesChannels = allChannels.where((element) => element.category == "series").toList();
    var scienceChannels = allChannels.where((element) => element.category == "science").toList();
    var shopChannels = allChannels.where((element) => element.category == "shop").toList();
    var travelChannels = allChannels.where((element) => element.category == "travel").toList();
    var weatherChannels = allChannels.where((element) => element.category == "weather").toList();
    var xxxChannels = allChannels.where((element) => element.category == "xxx").toList();
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        children: [
       if(sportsChannels.isNotEmpty)  CustomLabelAndListView(label: "Sports", channelList: sportsChannels),
          if(noGenreChannels.isNotEmpty) CustomLabelAndListView(label: "No Genre", channelList: noGenreChannels),
          if(musicChannels.isNotEmpty) CustomLabelAndListView(label: "Musics", channelList: musicChannels),
          if(movieChannels.isNotEmpty) CustomLabelAndListView(label: "Movies", channelList: movieChannels),
          if(religiousChannels.isNotEmpty) CustomLabelAndListView(label: "Religious", channelList: religiousChannels),
          if(newsChannels.isNotEmpty) CustomLabelAndListView(label: "News", channelList: newsChannels),
          if(documentaryChannels.isNotEmpty) CustomLabelAndListView(label: "Documentary", channelList: documentaryChannels),
          if(educationChannels.isNotEmpty) CustomLabelAndListView(label: "Education", channelList: educationChannels),
          if(autoChannels.isNotEmpty) CustomLabelAndListView(label: "Auto", channelList: autoChannels),
          if(xxxChannels.isNotEmpty) CustomLabelAndListView(label: "XXX", channelList: xxxChannels),
          if(weatherChannels.isNotEmpty) CustomLabelAndListView(label: "Weather", channelList: weatherChannels),
          if(relaxChannels.isNotEmpty) CustomLabelAndListView(label: "Relax", channelList: relaxChannels),
          if(travelChannels.isNotEmpty)CustomLabelAndListView(label: "Travel", channelList: travelChannels),
          if(shopChannels.isNotEmpty) CustomLabelAndListView(label: "Shop", channelList: shopChannels),
          if(scienceChannels.isNotEmpty) CustomLabelAndListView(label: "Science", channelList: scienceChannels),
          if(seriesChannels.isNotEmpty) CustomLabelAndListView(label: "Series", channelList: seriesChannels),
          if(outdoorChannels.isNotEmpty) CustomLabelAndListView(label: "Outdoor", channelList: outdoorChannels),
          if(lifestyleChannels.isNotEmpty)CustomLabelAndListView(label: "Life Style", channelList: lifestyleChannels),
          if(legislativeChannels.isNotEmpty) CustomLabelAndListView(label: "Legislative", channelList: legislativeChannels),
          if(kidsChannels.isNotEmpty) CustomLabelAndListView(label: "Kids", channelList: kidsChannels),
          if(generalChannels.isNotEmpty)CustomLabelAndListView(label: "General", channelList: generalChannels),
          if(familyChannels.isNotEmpty)CustomLabelAndListView(label: "Family", channelList: familyChannels),
          if(entertainmentChannels.isNotEmpty)CustomLabelAndListView(label: "Entertainment", channelList: entertainmentChannels),
          if(animationChannels.isNotEmpty)CustomLabelAndListView(label: "Animation", channelList: animationChannels),
          if(businessChannels.isNotEmpty) CustomLabelAndListView(label: "Business", channelList: businessChannels),
          if(classicChannels.isNotEmpty)CustomLabelAndListView(label: "Classic", channelList: classicChannels),
          if(cookingChannels.isNotEmpty) CustomLabelAndListView(label: "Cooking", channelList: cookingChannels),
          if(cultureChannels.isNotEmpty) CustomLabelAndListView(label: "Culture", channelList: cultureChannels),
          if(comedyChannels.isNotEmpty)CustomLabelAndListView(label: "Comedy", channelList: comedyChannels),
        ],
      )
    );
  }
}
