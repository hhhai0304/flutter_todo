import 'package:flutter/widgets.dart';

import 'util/dialog_utils.dart';
import 'util/utils.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  showErrorDialog(String message, {Function okAction}) {
    DialogUtils.showAlertDialog(
        title: 'error'.getFromResource,
        message: message?.getFromResource ?? '',
        okAction: okAction);
  }
}
