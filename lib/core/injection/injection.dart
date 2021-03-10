import 'package:get/get.dart';

import 'core_module.dart';
import 'repository_module.dart';

abstract class AbstractModule extends Bindings {
  T get<T>({String tag}) {
    return Get.find<T>();
  }
}

class Injection extends AbstractModule {
  @override
  dependencies() {
    CoreModule().dependencies();
    RepositoryModule().dependencies();
  }
}
