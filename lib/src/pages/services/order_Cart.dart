import 'dart:convert';

import 'package:deliverify/src/Widgets/My_Orders.dart';
import 'package:deliverify/src/controllers/getxControllers/cart_controller.dart';
import 'package:deliverify/src/controllers/sqlite/order.dart';
import 'package:deliverify/src/utils/Text.dart';
import 'package:deliverify/src/utils/page_routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../models/facebookModel.dart';

class OrderCart extends StatefulWidget {
  const OrderCart({Key? key}) : super(key: key);

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  OrdersSqlite ordersSqlite = OrdersSqlite();
  CartController controller = Get.find();
  late FacebookModel user = FacebookModel(name: '', email: '', url: '');
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
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.cat.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    '${controller.cat.values.toList()[index]}x ',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 77, 151, 235)),
                                  ),
                                  textWidget(
                                      ' ${controller.cat.keys.toList()[index].itemname}'),
                                ],
                              ),
                              trailing: Text(
                                '${controller.cat.values.toList()[index] * controller.cat.keys.toList()[index].itemprice} MAD',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber,
                                ),
                              ),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget('Total :'),
                        Text(
                          '${controller.total} MAD',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            minimumSize:
                                Size(size.width * 0.45, size.height * 0.05)),
                        onPressed: () async {
                          for (int i = 0; i < controller.cat.length; i++) {
                            int res = await ordersSqlite.insert('''
INSERT INTO "order" (
  "itemname" ,
  "itemprice" ,
  "itemcount" ,"username") VALUES ("${controller.cat.keys.toList()[i].itemname}",${controller.cat.keys.toList()[i].itemprice},${controller.cat.values.toList()[i]} ,"${user.name}" )
  ''');
                          }
                          Navigator.push(context, FadeRoute(child: MyOrders()));
                        },
                        child: const Text('Order Now'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            elevation: 10,
                            minimumSize:
                                Size(size.width * 0.45, size.height * 0.05)),
                        onPressed: () async {
                          for (int i = 0; i < controller.cat.length; i++) {
                            int res = await ordersSqlite.insert('''
INSERT INTO "order" (
  "itemname" ,
  "itemprice" ,
  "itemcount" ,"username") VALUES ("${controller.cat.keys.toList()[i].itemname}",${controller.cat.keys.toList()[i].itemprice},${controller.cat.values.toList()[i]} ,"${user.name}" )
  ''');
                            print(res);
                          }
                        },
                        child: const Text('Save For Later'),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
