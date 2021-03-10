import 'package:get/get.dart';

import '../setting.dart';
import 'injection.dart';

class CoreModule extends AbstractModule {
  @override
  dependencies() {
    Get.put<Setting>(Setting());
  }
}
