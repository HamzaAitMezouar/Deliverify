// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:deliverify/main.dart';
import 'package:deliverify/src/Widgets/My_Orders.dart';
import 'package:deliverify/src/controllers/apis/facebookSignIn.dart';
import 'package:deliverify/src/pages/Signin.dart';
import 'package:deliverify/src/utils/page_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../models/facebookModel.dart';

class NavBar extends StatefulWidget {
  FacebookModel user;
  Size size;
  NavBar({
    required this.user,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width,
      child: Scaffold(
        backgroundColor: Color(0xff3490dc),
        body: Stack(
          children: [
            Container(
              height: size.height,
              child: Image.asset(
                'assets/navbac.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.35,
                ),
                Container(
                  child: Text(
                    'Hello ${widget.user.name}',
                    style: GoogleFonts.ebGaramond(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                CircleAvatar(
                  foregroundColor: Colors.transparent,
                  radius: size.height * 0.05,
                  backgroundImage: AssetImage('assets/Deliverify.png'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.6,
                ),
                Container(
                  height: size.height * 0.2,
                  child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_jkaln4af.json'),
                )
              ],
            ),
            Positioned.fill(
              child: DraggableScrollableSheet(
                  expand: true,
                  initialChildSize: 0.75,
                  maxChildSize: 0.75,
                  minChildSize: 0.63,
                  builder: (context, controller) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        controller: controller,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '  My Account',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                          ListTile(
                              leading: Icon(
                                FontAwesomeIcons.bagShopping,
                                color: Colors.green,
                              ),
                              title: Text('My Orders',
                                  style: GoogleFonts.ebGaramond(
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                print('myOrders');
                                Navigator.push(
                                    context, FadeRoute(child: MyOrders()));
                              }),

                          bottomsheet(
                              const Icon(FontAwesomeIcons.circleInfo),
                              'My Information',
                              () {},
                              const Icon(Icons.arrow_forward_ios)),
                          Divider(
                            thickness: 1,
                            color: Theme.of(context)
                                .hintColor, // Y is your desired color
                            // X is your int value
                          ),
                          //Premium
                          bottomsheet(
                              const Icon(Icons.workspace_premium),
                              'Premium',
                              () {},
                              const Icon(
                                Icons.money,
                                size: 0,
                              )),
                          // FiveStars
                          bottomsheet(
                              const Icon(
                                FontAwesomeIcons.star,
                                color: Colors.amber,
                              ),
                              'Rate Us',
                              () {},
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 0,
                              )),
                          // Help center
                          bottomsheet(
                              const Icon(Icons.help_center_rounded),
                              'Help Center',
                              () {},
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 0,
                              )),
                          //Contaact Us
                          bottomsheet(
                              const Icon(Icons.phone),
                              'Contact Us',
                              () {},
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 0,
                              )),
                          Divider(
                            thickness: 1,
                            color: Theme.of(context).hintColor,
                          ),
                          bottomsheet(const Icon(Icons.settings), 'Settings',
                              () {
                            print('sett');
                          },
                              const Icon(
                                Icons.arrow_forward_ios,
                              )),
                          ListTile(
                              leading: const Icon(
                                FontAwesomeIcons.signOut,
                                color: Colors.red,
                              ),
                              title: Text('Log Out',
                                  style: GoogleFonts.ebGaramond(
                                      textStyle:
                                          const TextStyle(fontSize: 18))),
                              onTap: () {
                                print('logout');
                                FacebookApi().logout();
                                sharedPreferences!.clear();
                                Navigator.pushReplacement(
                                    context, FadeRoute(child: SignIn()));
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [const Text('version 00.00.00    ')],
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),

        /* bottomSheet: BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Center(
                  child: Text('Barr'),
                );
              })*/
      ),
    );
  }

  Widget bottomsheet(Icon icon, String title, Function function, Icon arrow) {
    return ListTile(
      leading: icon,
      title: Text(title,
          style:
              GoogleFonts.ebGaramond(textStyle: const TextStyle(fontSize: 18))),
      onTap: () => function,
      trailing: arrow,
    );
  }
}
