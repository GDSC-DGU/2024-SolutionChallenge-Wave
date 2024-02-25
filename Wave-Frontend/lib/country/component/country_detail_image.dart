import 'package:flutter/material.dart';

class CountryDetailImage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String producer;

  const CountryDetailImage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.producer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 260,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20,),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20,),
          child: Text(
            producer,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
