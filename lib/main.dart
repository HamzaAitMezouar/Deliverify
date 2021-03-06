import 'package:deliverify/src/Translation/Translation.dart';
import 'package:deliverify/src/pages/Signin.dart';
import 'package:deliverify/src/pages/home.dart';
import 'package:deliverify/src/pages/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/utils/themes.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  Stripe.publishableKey =
      'pk_test_51LDmmrFcy39zM7TraXXhbwFP1g6gZah3gwB6v2aznN61EFWsoGooCKHmMgHFWJpyZI9tKh8F9cPUjhipiNmat1uW00QedrqUUI';
  await Stripe.instance.applySettings();

  runApp(Deliverify());
}

class Deliverify extends StatelessWidget {
  Deliverify({Key? key}) : super(key: key);
  final onboard = sharedPreferences!.getBool('firstTime') ?? true;
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
        home: sharedPreferences!.getBool('firstTime') == false
            ? sharedPreferences!.get('user') == null
                ? SignIn()
                : const home()
            : OnBoardScreen());
  }
}
