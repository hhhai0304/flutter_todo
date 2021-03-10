import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {
  static const Color pageBackground = Colors.white;
  static const Color titleText = Color(0xFF252525);
}

class AppStyle {
  static TextStyle dialogTitle = Get.textTheme.headline6.copyWith(
    fontSize: 20,
    color: AppColor.titleText,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyDescription = Get.textTheme.bodyText2.copyWith(
    color: Color(0xFF767575),
  );
  static TextStyle textButton = Get.textTheme.button.copyWith(
    fontSize: 17,
    color: Get.theme.primaryColor,
  );
}
