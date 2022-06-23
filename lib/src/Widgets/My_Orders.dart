import 'dart:convert';

import 'package:deliverify/src/controllers/getxControllers/credit_card.dart';
import 'package:deliverify/src/models/order_model.dart';
import 'package:deliverify/src/pages/home.dart';
import 'package:deliverify/src/utils/page_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../main.dart';
import '../controllers/sqlite/order.dart';
import '../models/facebookModel.dart';
import '../utils/Text.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  PaymentController paymentController = Get.put(PaymentController());
  OrdersSqlite ordersSqlite = OrdersSqlite();
  double total = 0;
  late FacebookModel user = FacebookModel(name: '', email: '', url: '');
  late Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  late String city = '';

  Set<Marker> marker = {};
  late BitmapDescriptor mapMarker;
  bool loading = true;
  void setMarkerIcon() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/pin.png');
  }

  //location
  // For Location
  getLocation() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = currentPosition;
    });

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String placeCity = placemarks[0].street!;

    setState(() {
      city = placeCity;
    });
  }

// create Map
  onMapCreated(GoogleMapController googleMapController) {
    setState(() {
      marker.add(
        Marker(
            icon: mapMarker,
            infoWindow: InfoWindow(title: city),
            markerId: const MarkerId('1'),
            position: LatLng(position.latitude, position.longitude)),
      );
    });
  }

//useer dataaa
  initUser() {
    final pref = sharedPreferences!.getString('user');

    final userinit = FacebookModel.fromJson(jsonDecode(pref!));

    setState(() {
      user = userinit;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    initUser();
    setMarkerIcon();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: FutureBuilder<List<Map>>(
          future: ordersSqlite.read('''
Select * from "order" where "username" = "${user.name}"'''),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<Map> orders = snapshot.data!;

              double getTotale() {
                for (int i = 0; i < orders.length; i++) {
                  double prod = orders[i]['itemcount'] * orders[i]['itemprice'];
                  total = total + prod;
                }

                return total;
              }

              return orders.length == 0
                  ? Center(
                      child: textWidget('No Saved order yet'),
                    )
                  : SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: textWidget('My Orders'),
                              ),
                              Container(
                                height: size.height * 0.4,
                                child: ListView.builder(
                                  itemCount: orders.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      child: ListTile(
                                          trailing: Text(
                                            '${orders[index]['itemcount'] * orders[index]['itemprice']}MAD',
                                            style: const TextStyle(
                                                color: Colors.amber),
                                          ),
                                          title: textWidget(
                                              '${orders[index]['itemcount']}x ${orders[index]['itemname']}')),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                            FontAwesomeIcons.allergies),
                                        label: const Text('Any Allergies ?')),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.95,
                                height: size.height * 0.2,
                                child: GoogleMap(
                                  onMapCreated: onMapCreated,
                                  markers: marker,
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                      zoom: 20,
                                      target: LatLng(position.latitude,
                                          position.longitude)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  alignment: Alignment.centerLeft,
                                  height: size.height * 0.06,
                                  width: size.width * 0.95,
                                  decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(
                                        0.8,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      const Text(
                                        '  As Soon As Possible',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text('30-40 min',
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.5)))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton.icon(
                                  icon: const Icon(FontAwesomeIcons.phone),
                                  label: Column(
                                    children: [
                                      const Text(
                                        'Add Your Phone Number',
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                          ' We Will send You a Text to Confirm your phone Number',
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                                  .withOpacity(0.5)))
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget('  Payment methods'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: ListTile(
                                        onTap: () {
                                          showBottomSheet(
                                              elevation: 20,
                                              enableDrag: true,
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  height: size.height * 0.25,
                                                  child: Column(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: textWidget(
                                                          'Choose payment method'),
                                                    ),
                                                    Card(
                                                      child: ListTile(
                                                        onTap: () {},
                                                        leading: const Icon(
                                                            FontAwesomeIcons
                                                                .moneyBill),
                                                        title: const Text(
                                                            ' Pay With Cash'),
                                                      ),
                                                    ),
                                                    Card(
                                                      child: ListTile(
                                                        onTap: () {
                                                          print('object2');
                                                        },
                                                        leading: const Icon(
                                                            FontAwesomeIcons
                                                                .creditCard),
                                                        title: const Text(
                                                            ' Add new Card'),
                                                      ),
                                                    )
                                                  ]),
                                                );
                                              });
                                        },
                                        leading: const Icon(
                                            FontAwesomeIcons.creditCard),
                                        title: Text(' Select Payment Method',
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                        trailing:
                                            const Icon(Icons.arrow_drop_down),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ClipPath(
                                clipper: MovieTicketBothSidesClipper(),
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 207, 207, 207),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            textWidget('Products :'),
                                            Text(
                                              '${getTotale()}MAD',
                                              style: const TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            textWidget('Delivery:'),
                                            const Text(
                                              'Free',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            textWidget('Total :'),
                                            Text(
                                              '${getTotale()}MAD',
                                              style: const TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: size.height * 0.06,
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        minimumSize: Size(size.width * 0.45,
                                            size.height * 0.05)),
                                    onPressed: () {
                                      paymentController.makePayment(
                                          amount: total.toString(),
                                          currency: 'USD');
                                    },
                                    child: const Text('Order Now')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        minimumSize: Size(size.width * 0.45,
                                            size.height * 0.05)),
                                    onPressed: () {
                                      OrdersSqlite().delete('''
DELETE FROM "order" WHERE "username" = "${user.name}"
''');
                                      Navigator.push(
                                          context, ScaleRoute(child: home()));
                                    },
                                    child: const Text('Delete This Order')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
    );
  }
}
