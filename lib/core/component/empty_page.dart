import 'package:flutter/widgets.dart';
import 'package:todo_app/core/constants.dart';

import '../util/utils.dart';

class EmptyPage extends StatelessWidget {
  final String messageKey;

  const EmptyPage([this.messageKey = 'no_data']);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${messageKey.getFromResource ?? ''}',
        style: TextStyle(fontSize: FONT_SIZE_DEFAULT),
      ),
    );
  }
}
