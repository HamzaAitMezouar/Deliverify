import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_Zuwmxh.json')),
    );
  }
}
