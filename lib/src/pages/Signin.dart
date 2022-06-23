// ignore_for_file: use_build_context_synchronously

import 'package:deliverify/main.dart';
import 'package:deliverify/src/controllers/apis/facebookSignIn.dart';
import 'package:deliverify/src/controllers/apis/googleSignIn.dart';
import 'package:deliverify/src/models/facebookModel.dart';

import 'package:deliverify/src/pages/home.dart';
import 'package:deliverify/src/utils/Constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/Register.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          appIcon(size),
          SizedBox(
            height: size.height * 0.1,
          ),
          googleButton(size),
          SizedBox(
            height: size.height * 0.02,
          ),
          facebookButton(size),
          SizedBox(
            height: size.height * 0.05,
          ),
          Register(size, context),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Terms And Condtions ,',
                style: TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).hintColor.withOpacity(0.5)),
              ),
              Icon(
                FontAwesomeIcons.copyright,
                color: Theme.of(context).hintColor.withOpacity(0.5),
                size: 14,
              ),
              Text(
                'Copyright ',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 13,
                    color: Theme.of(context).hintColor.withOpacity(0.5)),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column Register(Size size, BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage('Register')));
            },
            child: Text(
              '1'.tr,
              style: GoogleFonts.ebGaramond(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: appBarTitle.withOpacity(0.8)),
              ),
            )),
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '3'.tr,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor.withOpacity(0.5)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage('Login')));
              },
              child: Text(
                '2'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: appBarTitle.withOpacity(0.8)),
              ),
            )
          ],
        )
      ],
    );
  }

  ElevatedButton facebookButton(Size size) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 16, 45, 173),
            fixedSize: Size(size.width * 0.8, size.height * 0.06)),
        onPressed: () async {
          final FacebookModel? user = await FacebookApi().getUser();
          if (user != null) {
            sharedPreferences?.getString('user') == null
                ? Get.snackbar('No User Found', '')
                : Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const home()));
          } else {
            Get.snackbar('No User Found', '');
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.facebook),
            Text(
              '5'.tr,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ));
  }

  ElevatedButton googleButton(Size size) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 219, 86, 76),
            fixedSize: Size(size.width * 0.8, size.height * 0.06)),
        onPressed: () async {
          GoogleSigninApi.login();
          /*GoogleModel userG = await GoogleSigninApi().getUser();
          if (userG == null) {
            Get.snackbar('No User found', '');
          } else {
            Navigator.pushReplacement(context, FadeRoute(child: const home()));
          }*/
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.google),
            Text(
              '4'.tr,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ));
  }

  ClipPath appIcon(Size size) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        color: logoColor,
        height: size.height * 0.3,
        alignment: Alignment.center,
        child: Image.asset("assets/icon.png"),
      ),
    );
  }
}
