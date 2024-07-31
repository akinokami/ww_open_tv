import 'package:get/get.dart';
import 'package:ww_open_tv/bottom_navigation_menu.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => BottomNavigationMenu());
    });
  }

  @override
  void dispose() {
    //
    super.dispose();
  }
}
