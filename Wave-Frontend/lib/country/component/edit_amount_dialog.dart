import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/const/colors.dart';

class EditAmountDialog extends StatefulWidget {
  final Function(double) onAmountEdited;

  const EditAmountDialog({Key? key, required this.onAmountEdited}) : super(key: key);

  @override
  _EditAmountDialogState createState() => _EditAmountDialogState();
}

class _EditAmountDialogState extends State<EditAmountDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // 모달 배경색을 흰색으로 설정
      shape: RoundedRectangleBorder( // 모달의 borderRadius 설정
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Your donation will create a big Wave.'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: "Amount"),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능
          FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d{0,2}$|^999$')), // 1부터 1000까지의 숫자만 허용
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: PRIMARY_BLUE_COLOR, // 버튼 배경색
            shape: RoundedRectangleBorder( // 버튼의 borderRadius 설정
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('OK'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: PRIMARY_BLUE_COLOR, // 버튼 배경색
            shape: RoundedRectangleBorder( // 버튼의 borderRadius 설정
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            final double amount = double.tryParse(_controller.text) ?? 0;
            if (amount > 0 && amount <= 999) {
              widget.onAmountEdited(amount);
              Navigator.of(context).pop();
            } else {
              // 입력 값이 범위를 벗어났을 때 사용자에게 알림
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a value between 1 and 999.')),
              );
            }
          },
        ),
      ],
    );
  }
}
