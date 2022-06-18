// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:deliverify/src/pages/services/Menu.dart';
import 'package:deliverify/src/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/apis/RestaurantsApi.dart';
import '../../models/restaurantsModel.dart';

class RestuarantService extends StatefulWidget {
  const RestuarantService({Key? key}) : super(key: key);

  @override
  State<RestuarantService> createState() => _RestuarantServiceState();
}

class _RestuarantServiceState extends State<RestuarantService> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restuarants',
          textAlign: TextAlign.center,
          style: GoogleFonts.abel(
              textStyle: const TextStyle(
            letterSpacing: 2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<ResturantModel>>(
            future: ResturantsApi().getRestaurants('beni mellal'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else if (snapshot.hasData) {
                List<ResturantModel> rests = snapshot.data!;
                print('object${rests[0].menu![0].cat![0].itemname}');
                return Column(
                  children: [
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: [lightIcon, logoColor])),
                      child: Row(
                        children: [
                          SizedBox(width: size.width * 0.01),
                          Image.asset('assets/restaurant.png',
                              height: size.height * 0.03),
                          Text(
                            ' Restuarants',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ebGaramond(
                                textStyle: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: [lightIcon, logoColor])),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: rests.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(RestuarantMenu(
                                      rest: rests[index],
                                    ));
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          height: size.height * 0.2,
                                          width: size.width * 0.85,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    rests[index].image!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: size.height * 0.1,
                                        child: Text(
                                          rests[index].name!,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lora(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.35))),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: size.height * 0.015,
                                          left: size.width * 0.1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              width: size.width * 0.14,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star_rate,
                                                    color: Colors.amber
                                                        .withOpacity(0.7),
                                                  ),
                                                  Text(
                                                    '${rests[index].rating}',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.ebGaramond(
                                                            textStyle:
                                                                const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                      //// Cityyyyyy
                                      Positioned(
                                          bottom: size.height * 0.015,
                                          right: size.width * 0.1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              width: size.width * 0.3,
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.my_location,
                                                    color: Colors.amber,
                                                  ),
                                                  Text(
                                                    ' ${rests[index].city}',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.ebGaramond(
                                                            textStyle:
                                                                const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  height: size.height * 0.05,
                                  width: size.width * 0.85,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.thumbsUp,
                                            color:
                                                Color.fromARGB(255, 0, 39, 71),
                                          ),
                                          Text(
                                            ' 80%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.motorcycle,
                                              color: Colors.amber,
                                            ),
                                            Text('   Free • '),
                                            Text(
                                              '30-40 min  ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                index == rests.length.toInt() - 1
                                    ? Center(
                                        child: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color.fromARGB(255, 0, 150, 5),
                                              Color.fromARGB(255, 100, 207, 104)
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        height: size.height * 0.3,
                                        width: size.width * 0.8,
                                        child: Column(children: [
                                          Text(
                                            '\n  Invite Your friends',
                                            style: GoogleFonts.lora(
                                                textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ),
                                          Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Image.asset(
                                                    'assets/money.png',
                                                    height: size.height * 0.1,
                                                  ),
                                                  SizedBox(
                                                      width: size.width * 0.06)
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '  Get A free 10\$ Discount\n Everytime   You Invite a friend',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.lora(
                                                        textStyle: TextStyle(
                                                      height:
                                                          size.height * 0.002,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '  Your Friend will get a Discount too\n',
                                            style: GoogleFonts.lora(
                                                textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 5,
                                                  primary: Colors.amber,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40))),
                                              onPressed: () {},
                                              child: Text('Invite'))
                                        ]),
                                      ))
                                    : Container()
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
