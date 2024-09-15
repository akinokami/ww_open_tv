import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:ww_open_tv/language/en_language.dart';
import 'package:ww_open_tv/language/vi_language.dart';
import 'package:ww_open_tv/language/zh_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': ZhLanguage().zhLanguage,
        'en_US': EnLanguage().enLanguage,
        'vi_VN': ViLanguage().viLanguage,
      };
}
