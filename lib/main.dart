import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/page/todo/home_page.dart';

import 'core/constants.dart';
import 'core/injection/injection.dart';
import 'core/translator.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init(SETTINGS_FILE_NAME).then((value) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        initialBinding: Injection(),
        debugShowCheckedModeBanner: false,
        title: 'HHHai Todo',
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
          accentColor: Colors.red,
        ),
        translations: Translator(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('vi', 'VN'),
        enableLog: !kReleaseMode,
        navigatorKey: Get.key,
        popGesture: GetPlatform.isIOS,
        defaultTransition:
            GetPlatform.isIOS ? Transition.cupertino : Transition.rightToLeft,
        home: HomePage(),
      );
}
