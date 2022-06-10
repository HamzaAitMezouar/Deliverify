import 'package:deliverify/src/pages/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/utils/themes.dart';

void main() {
  runApp(const Deliverify());
}

class Deliverify extends StatelessWidget {
  const Deliverify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deliverify',
      theme: light(context),
      darkTheme: dark(context),
      home: SignIn(),
    );
  }
}
