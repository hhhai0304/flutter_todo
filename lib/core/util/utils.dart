import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

extension MyStringExtension on String {
  bool get isNullOrEmpty => this == null || this.trim().isEmpty;

  String get getFromResource {
    final result = this.tr;
    if (result.isNullOrEmpty) return this;
    return result;
  }
}

class Utils {
  static String getGuid() => Uuid().v1();

  static showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Toast duration = Toast.LENGTH_LONG,
  }) =>
      Fluttertoast.showToast(
        backgroundColor: Colors.black.withOpacity(0.4),
        msg: message,
        toastLength: duration,
        gravity: gravity,
      );
}

bool isNullOrEmpty(dynamic s) {
  if (s != null && s is String) {
    s = s.trim();
  }
  try {
    return s == null || s.isEmpty;
  } catch (_) {
    return s == null;
  }
}
