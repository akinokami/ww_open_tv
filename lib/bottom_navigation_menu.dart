import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ww_open_tv/screens/categories/categories_screen.dart';
import 'package:ww_open_tv/screens/channels/channels_screen.dart';
import 'package:ww_open_tv/screens/favorite/favorite_channel_screen.dart';
import 'package:ww_open_tv/screens/search/search_screen.dart';
import 'package:ww_open_tv/screens/settings/settings_screen.dart';
import 'constants/color_const.dart';
import 'controller/bottom_nav_controller.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  buildBottomNavigationMenu(context, landingPageController) {
    return  Builder(
      builder: (context) {
        final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;


        final TextStyle unselectedLabelStyle = TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            fontSize:isPortrait? 11.sp:8.sp);

        final TextStyle selectedLabelStyle = TextStyle(
            color: secondaryColor, fontWeight: FontWeight.w500, fontSize:isPortrait? 11.sp:8.sp);

        return Obx(() =>MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: SizedBox(
              height:isPortrait? 55.h:85.h,
              child: BottomNavigationBar(
                selectedFontSize: isPortrait ? 11.sp : 8.sp,  // Adjust font size for orientation
                unselectedFontSize: isPortrait ? 11.sp : 8.sp,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: landingPageController.changeTabIndex,
                currentIndex: landingPageController.tabIndex.value,
                backgroundColor: primaryColor,
                unselectedItemColor: Colors.grey.withOpacity(0.5),
                selectedItemColor: secondaryColor,
                unselectedLabelStyle: unselectedLabelStyle,
                selectedLabelStyle: selectedLabelStyle,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category,
                      size: isPortrait ?18.w:15.w,
                    ),
                    label: 'category'.tr,
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.tv,
                      size: isPortrait ?18.w:15.w,
                    ),
                    label: 'channel'.tr,
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: isPortrait ?18.w:15.w,
                    ),
                    label: 'search'.tr,
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite_border,
                      size: isPortrait ?18.w:15.w,
                    ),
                    label: 'fav'.tr,
                    backgroundColor: primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: isPortrait ?18.w:15.w,
                    ),
                    label: 'settings'.tr,
                    backgroundColor: primaryColor,
                  ),
                ],
              ),
            )));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar:
          buildBottomNavigationMenu(context, bottomNavController),
      body: Obx(() => IndexedStack(
            index: bottomNavController.tabIndex.value,
            children: const [
              CategoriesScreen(),
              ChannelScreen(),
              SearchScreen(),
              FavoriteChannelScreen(),
              SettingsScreen(),
            ],
          )),
    ));
  }
}
