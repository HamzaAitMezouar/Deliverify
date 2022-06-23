import 'package:deliverify/main.dart';
import 'package:deliverify/src/pages/Signin.dart';
import 'package:deliverify/src/utils/Text.dart';
import 'package:deliverify/src/utils/page_routing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  bool isLastPage = false;
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          height: size.height * 0.7,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 3;
              });
            },
            controller: controller,
            children: [
              SizedBox(
                  height: size.height * 0.7,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      SizedBox(
                        height: size.height * 0.3,
                        child: Lottie.asset('assets/login.json',
                            fit: BoxFit.cover),
                      ),
                      textWidget('Sign in Using Email ,Google or Facebook')
                    ],
                  )),
              SizedBox(
                  height: size.height * 0.7,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      SizedBox(
                          height: size.height * 0.3,
                          child: Lottie.asset('assets/loc.json')),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Container(
                        child: textWidget(
                            'Enable your Gps to share your current Live Location'),
                      )
                    ],
                  )),
              SizedBox(
                  height: size.height * 0.7,
                  child: Column(children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    SizedBox(
                        height: size.height * 0.3,
                        child: Lottie.asset('assets/order.json')),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    textWidget(
                        'choose an Order and your desired payement method')
                  ])),
              SizedBox(
                  height: size.height * 0.7,
                  child: Column(children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    SizedBox(
                        height: size.height * 0.3,
                        child: Lottie.asset('assets/receive.json')),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    textWidget('Enjoy Your Food And give us your feedback ')
                  ]))
            ],
          )),
      bottomSheet: isLastPage
          ? Container(
              padding: const EdgeInsets.all(5),
              color: Theme.of(context).scaffoldBackgroundColor,
              height: size.height * 0.08,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      minimumSize: Size(size.width * 0.8, size.height * 0.07)),
                  onPressed: () async {
                    sharedPreferences!.setBool('firstTime', false);
                    Navigator.push(context, FadeRoute(child: SignIn()));
                  },
                  child: const Text('Start Now')),
            )
          : Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(fontSize: 20),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                        controller: controller, // PageController
                        count: 4,
                        effect: SwapEffect(
                            activeDotColor: Theme.of(context)
                                .cardColor), // your preferred effect
                        onDotClicked: (index) {
                          controller.animateToPage(index,
                              duration: const Duration(microseconds: 350),
                              curve: Curves.easeInOut);
                        }),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(microseconds: 350),
                            curve: Curves.easeInOut);
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
    );
  }
}
