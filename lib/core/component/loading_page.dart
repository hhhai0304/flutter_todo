import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'spin_kit_chasing_dots.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitChasingDots(color: Get.theme.primaryColor));
  }
}
