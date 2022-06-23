// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:deliverify/main.dart';
import 'package:deliverify/src/Widgets/NavBar.dart';

import 'package:deliverify/src/models/restaurantsModel.dart';
import 'package:deliverify/src/pages/services/restuarants.dart';

import 'package:deliverify/src/utils/Constants.dart';
import 'package:deliverify/src/utils/page_routing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../Widgets/NoConnection.dart';
import '../controllers/apis/RestaurantsApi.dart';
import '../models/facebookModel.dart';
import '../utils/map.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  bool isClicked = false;
  double dragpercent = 0;

  String city = '';
  late FacebookModel user = FacebookModel(name: '', email: '', url: '');
  bool hasInternet = false;
  late Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  late AnimationController animationController;
  late Animation buttonsAnimation;
  late Animation degreeAnimation;
  String search = '';
  late Future<List<ResturantModel>> restsfuture;
// For Internet connectivity
  checkConnection() async {
    final bool hasInternet1 = await InternetConnectionChecker().hasConnection;
    setState(() {
      hasInternet = hasInternet1;
    });
  }

  // For user data
  initUser() {
    final pref = sharedPreferences!.getString('user');

    final userinit = FacebookModel.fromJson(jsonDecode(pref!));

    setState(() {
      user = userinit;
    });
  }

  // For Location
  getLocation() async {
    await Geolocator.requestPermission();
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(minutes: 2),
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        position = currentPosition;
      });
    }

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String placeCity = placemarks[0].street!;

    setState(() {
      city = placeCity;
    });
  }

  @override
  void initState() {
    super.initState();
    restsfuture = ResturantsApi().getRestaurants('beni mellal');
    //Aniamtion
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    buttonsAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    degreeAnimation = Tween<double>(begin: 360.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animationController.addListener(() {
      setState(() {});
    });
    initUser();
    checkConnection();
    getLocation();
  }

  double degreeToRadian(double degree) {
    double radian = 57.296;
    return degree / radian;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return hasInternet
        ? Scaffold(
            backgroundColor: logoColor,
            extendBodyBehindAppBar: true,
            drawer: NavBar(
              size: size,
              user: user,
            ),
            appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
            body: Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 130),
                    height: size.height * 0.6,
                    width: size.width,
                    child: Stack(
                      children: [
                        //********************Grocery Button */
                        Transform.translate(
                            offset: Offset.fromDirection(degreeToRadian(0),
                                (size.width * 0.3) * buttonsAnimation.value),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(
                                  degreeToRadian(degreeAnimation.value))
                                ..scale(buttonsAnimation.value),
                              child: groceryButton(
                                size,
                                Theme.of(context).cardColor,
                              ),
                            )),
                        //Super Market Buttons*******************
                        Transform.translate(
                            offset: Offset.fromDirection(degreeToRadian(90),
                                (size.width * 0.3) * buttonsAnimation.value),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(
                                  degreeToRadian(degreeAnimation.value))
                                ..scale(buttonsAnimation.value),
                              child: restaurantsButton(
                                size,
                                Theme.of(context).cardColor,
                              ),
                            )), // **************Restuarants Button
                        Transform.translate(
                            offset: Offset.fromDirection(degreeToRadian(180),
                                (size.width * 0.3) * buttonsAnimation.value),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(
                                  degreeToRadian(degreeAnimation.value))
                                ..scale(buttonsAnimation.value),
                              child: superMarketButton(
                                size,
                                Theme.of(context).cardColor,
                              ),
                            )), // Clothes Buttoooooon

                        Transform.translate(
                            offset: Offset.fromDirection(degreeToRadian(270),
                                (size.width * 0.3) * buttonsAnimation.value),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(
                                  degreeToRadian(degreeAnimation.value))
                                ..scale(buttonsAnimation.value),
                              child: clothesButton(
                                size,
                                Theme.of(context).cardColor,
                              ),
                            )),

                        //Opeen Button
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationZ(
                              degreeToRadian(degreeAnimation.value)),
                          child: openButton(
                              size, Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ],
                    ),
                  ),
                ),
                NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notif) {
                    //Calculate the rate by which you are dragging the Sheet
                    setState(() {
                      dragpercent = notif.extent / 0.65 - 0.26;
                    });

                    return true;
                  },
                  child: DraggableScrollableSheet(
                      initialChildSize: 0.17,
                      minChildSize: 0.17,
                      maxChildSize: 0.82,
                      builder: ((context, controller) => ClipPath(
                            clipper: WaveClipperOne(reverse: true),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/icon.png'),
                                    fit: BoxFit.fitWidth),
                              ),
                              height: 200,
                              child: FutureBuilder<List<ResturantModel>>(
                                  future: restsfuture,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else if (snapshot.hasData) {
                                      List<ResturantModel> rests =
                                          snapshot.data!;
                                      return Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                    lightIcon,
                                                    logoColor
                                                  ])),
                                              alignment: Alignment.bottomLeft,
                                              height: size.height * 0.08,
                                              width: size.width,
                                              child: Text(
                                                '\n   Places You might Like ',
                                                style: GoogleFonts.ebGaramond(
                                                    textStyle: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              )),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                    lightIcon,
                                                    logoColor
                                                  ])),
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount: rests.length,
                                                controller: controller,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Stack(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          height:
                                                              size.height * 0.2,
                                                          width:
                                                              size.width * 0.85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    rests[index]
                                                                        .image!),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                        top: size.height * 0.1,
                                                        child: Text(
                                                          rests[index].name!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.lora(
                                                              textStyle: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white,
                                                                  backgroundColor: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.35))),
                                                        ),
                                                      ),
                                                      Positioned(
                                                          bottom: size.height *
                                                              0.015,
                                                          left:
                                                              size.width * 0.1,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.14,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .star_rate,
                                                                    color: Colors
                                                                        .amber
                                                                        .withOpacity(
                                                                            0.7),
                                                                  ),
                                                                  Text(
                                                                    '${rests[index].rating}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .ebGaramond(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                      //// Cityyyyyy
                                                      Positioned(
                                                          bottom: size.height *
                                                              0.015,
                                                          right:
                                                              size.width * 0.1,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.35,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .my_location,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  Text(
                                                                    ' ${rests[index].city}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .ebGaramond(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ))
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
                          ))),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: -200 * (1 - dragpercent),
                  child: ClipPath(
                    clipper: WaveClipperOne(flip: true),
                    child: Opacity(
                      opacity: dragpercent * 0.99,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: [lightIcon, logoColor]),
                          image: const DecorationImage(
                              image: AssetImage('assets/Deliverify.png'),
                              fit: BoxFit.fitHeight),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        height: size.height * 0.243,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            searchWidget(size),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: size.width * 0.6,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        ScaleRoute(
                                            child: MapWidget(
                                          position: position,
                                          city: city,
                                        )));
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.my_location),
                                      Text(
                                        ' Get New Location',
                                        style: GoogleFonts.ebGaramond(
                                            textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        )),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const NoConnection();
  }

  Widget openButton(Size size, Color color) {
    return AnimatedContainer(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(10),
        height: size.height * 0.1,
        width: size.width * 0.2,
        decoration: BoxDecoration(
            boxShadow: isClicked
                ? const [
                    BoxShadow(
                        color: Color.fromARGB(255, 110, 110, 110),
                        offset: Offset(4, 4),
                        blurRadius: 8,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Color.fromARGB(255, 216, 216, 216),
                        offset: Offset(-4, -4),
                        blurRadius: 8,
                        spreadRadius: 1)
                  ]
                : null,
            borderRadius: BorderRadius.circular(20),
            color: color),
        child: InkWell(
          child: Column(
            children: [
              Image.asset('assets/click.png', height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.022,
                child: Text(
                  'Services',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ebGaramond(),
                ),
              )
            ],
          ),
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
        ));
  }

  Widget superMarketButton(Size size, Color color) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: size.height * 0.1,
        width: size.width * 0.2,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 110, 110, 110),
              offset: Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1),
          BoxShadow(
              color: Color.fromARGB(255, 216, 216, 216),
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1)
        ], borderRadius: BorderRadius.circular(20), color: color),
        child: InkWell(
          child: Column(
            children: [
              Image.asset('assets/supermarket.png', height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.022,
                child: Text(
                  'SuperMarket',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ebGaramond(),
                ),
              )
            ],
          ),
          onTap: () {},
        ));
  }

  Widget restaurantsButton(Size size, Color color) {
    return AnimatedContainer(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(10),
        height: size.height * 0.1,
        width: size.width * 0.2,
        decoration: BoxDecoration(
            boxShadow: isClicked
                ? const [
                    BoxShadow(
                        color: Color.fromARGB(255, 110, 110, 110),
                        offset: Offset(4, 4),
                        blurRadius: 8,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Color.fromARGB(255, 216, 216, 216),
                        offset: Offset(-4, -4),
                        blurRadius: 8,
                        spreadRadius: 1)
                  ]
                : null,
            borderRadius: BorderRadius.circular(20),
            color: color),
        child: InkWell(
          child: Column(
            children: [
              Image.asset('assets/rest.png', height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.022,
                child: Text(
                  'Restaurants',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ebGaramond(),
                ),
              )
            ],
          ),
          onTap: () {
            Get.to(const RestuarantService());
          },
        ));
  }

  Widget clothesButton(Size size, Color color) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: size.height * 0.1,
        width: size.width * 0.2,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 110, 110, 110),
              offset: Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1),
          BoxShadow(
              color: Color.fromARGB(255, 216, 216, 216),
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1)
        ], borderRadius: BorderRadius.circular(20), color: color),
        child: InkWell(
          child: Column(
            children: [
              Image.asset('assets/clothes.png', height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.022,
                child: Text(
                  'Clothes',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ebGaramond(),
                ),
              )
            ],
          ),
          onTap: () {},
        ));
  }

  Widget groceryButton(Size size, Color color) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: size.height * 0.1,
        width: size.width * 0.2,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 110, 110, 110),
              offset: Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1),
          BoxShadow(
              color: Color.fromARGB(255, 216, 216, 216),
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1)
        ], borderRadius: BorderRadius.circular(20), color: color),
        child: InkWell(
          child: Column(
            children: [
              Image.asset('assets/grocery.png', height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.022,
                child: Text(
                  'Grocery',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ebGaramond(),
                ),
              )
            ],
          ),
          onTap: () {},
        ));
  }

  ////// Search Text Field
  Widget searchWidget(Size size) {
    return SizedBox(
      width: size.width * 0.6,
      height: size.height * 0.055,
      child: TextFormField(
        validator: (val) => val!.isEmpty ? 'type Something' : null,
        onChanged: (val) {
          setState(() {
            search = val;
          });
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: 'Search ',
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
