import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/layout/default_layout.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      child: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Image.asset(
            'assets/images/waveGif.gif',
          ),
        ),
      ),
    );
  }
}
