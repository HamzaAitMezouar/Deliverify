import 'package:deliverify/src/Translation/Translation.dart';
import 'package:deliverify/src/pages/Signin.dart';
import 'package:deliverify/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/utils/themes.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(Deliverify());
}

class Deliverify extends StatelessWidget {
  const Deliverify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deliverify',
      theme: light(context),
      locale: Get.deviceLocale,
      translations: TranslationLocale(),
      darkTheme: dark(context),
      home: sharedPreferences!.get('user') == null ? SignIn() : home(),
    );
  }
}
