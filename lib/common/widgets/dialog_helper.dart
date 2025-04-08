import 'package:flutter/cupertino.dart';

class DialogHelper {
  static void showCupertinoYesNoDialog({
    required BuildContext context,
    required String title,
    required String content,
    VoidCallback? onYes,
    VoidCallback? onNo,
    String yesText = '확인',
    String noText = '취소',
  }) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(content),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(noText),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNo != null) onNo();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(yesText),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onYes != null) onYes();
                },
              ),
            ],
          ),
    );
  }
}
