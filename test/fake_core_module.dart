import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/injection/core_module.dart';
import 'package:todo_app/core/setting.dart';

import 'fake_setting.dart';

class FakeCoreModule extends Fake implements CoreModule {
  @override
  dependencies() {
    Get.put<Setting>(FakeSetting());
  }
}
