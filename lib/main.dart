import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ww_open_tv/language/languages.dart';
import 'package:ww_open_tv/splash_screen.dart';
import 'package:ww_open_tv/utils/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FastCachedImageConfig.init(
    clearCacheAfter: const Duration(days: 3),
  );
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Global.language = box.read('language') ?? "vi";

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          translations: Languages(),
          locale: Global.language == 'zh'
              ? const Locale('zh', 'CN')
              : Global.language == 'vi'
                  ? const Locale('vi', 'VN')
                  : const Locale('en', 'US'),
          fallbackLocale: const Locale('vi', 'VN'),
          home: const SplashScreen(),
        );
      },
    );
  }
}
