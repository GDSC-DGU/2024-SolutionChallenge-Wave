import 'package:flutter/material.dart';

class MyPageMenuList extends StatelessWidget {
  final Map<String, VoidCallback> actions;

  const MyPageMenuList({
    Key? key,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        'Donation list',
        'About Wave',
        'Terms and conditions',
        'Privacy policy',
        'Unscribing membership',
      ]
          .map(
            (title) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 10, 10, 10),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: actions[title],
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}
