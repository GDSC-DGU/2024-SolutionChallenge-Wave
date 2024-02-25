// 사용자에게 확인을 요청하는 대화상자를 표시하는 함수
import 'package:flutter/material.dart';
import 'package:wave/common/const/colors.dart';

Future<void> showConfirmationDialog(BuildContext context, String title, String content, VoidCallback onConfirm) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: PRIMARY_BLUE_COLOR,
              minimumSize: const Size(80, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: onConfirm,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey.shade700,
              minimumSize: const Size(80, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
