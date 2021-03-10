import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/util/utils.dart';

import '../app_styles.dart';

class DialogUtils {
  static Widget getDialog({
    String title,
    Widget content,
    String yesText,
    Function onYes,
    String noText,
    Function onNo,
  }) {
    final padding = 24.0;
    if (yesText.isNullOrEmpty) yesText = 'OK';
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: padding, left: padding, right: padding, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  title.isNullOrEmpty
                      ? Container()
                      : Text(
                          title,
                          style: AppStyle.dialogTitle,
                        ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: title.isNullOrEmpty ? 8 : padding),
                    child: content,
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                onNo == null
                    ? Container()
                    : Expanded(
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(26),
                          ),
                          child: Ink(
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(26),
                              ),
                              onTap: () {
                                Get.back();
                                onNo?.call();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: padding, bottom: padding),
                                child: Center(
                                  child: Text(
                                    noText,
                                    style: AppStyle.textButton,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                onNo == null
                    ? Container()
                    : Text(
                        '|',
                        style: AppStyle.textButton.copyWith(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                Expanded(
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          onNo != null ? Radius.zero : Radius.circular(26),
                      bottomRight: Radius.circular(26),
                    ),
                    child: Ink(
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              onNo != null ? Radius.zero : Radius.circular(26),
                          bottomRight: Radius.circular(26),
                        ),
                        onTap: () {
                          Get.back();
                          onYes?.call();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 24),
                          child: Center(
                            child: Text(
                              yesText,
                              style: AppStyle.textButton,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget getAlertDialog({
    String title,
    @required String message,
    String yesText,
    Function onYes,
    String noText,
    Function onNo,
  }) {
    return getDialog(
      title: title,
      content: Text(message, style: AppStyle.bodyDescription),
      yesText: yesText,
      onYes: onYes,
      noText: noText,
      onNo: onNo,
    );
  }

  static showAlertDialog({
    String title,
    @required String message,
    String buttonText,
    final Function okAction,
    bool canDismiss = true,
  }) {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return getAlertDialog(
          message: message,
          title: title,
          yesText: buttonText,
          onYes: okAction,
        );
      },
      barrierDismissible: canDismiss,
      barrierLabel: 'dismiss'.getFromResource,
    );
  }

  static showYesNoDialog({
    String title,
    @required String message,
    String yesText,
    String noText,
    Function onYes,
    Function onNo,
    bool canDismiss = true,
  }) {
    if (noText.isNullOrEmpty) noText = 'cancel'.getFromResource;
    if (onNo == null) onNo = () {};
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return getAlertDialog(
          message: message,
          title: title,
          yesText: yesText,
          onYes: onYes,
          noText: noText,
          onNo: onNo,
        );
      },
      barrierDismissible: canDismiss,
      barrierLabel: 'dismiss'.getFromResource,
    );
  }

  static showLoadingDialog({bool canDismiss = false, String status}) {
    if (status.isNullOrEmpty) {
      EasyLoading.show(
        dismissOnTap: canDismiss,
        maskType: EasyLoadingMaskType.black,
      );
    } else {
      EasyLoading.show(
        status: status,
        dismissOnTap: canDismiss,
        maskType: EasyLoadingMaskType.black,
      );
    }
  }

  static hideLoadingDialog() {
    EasyLoading.dismiss();
  }
}
