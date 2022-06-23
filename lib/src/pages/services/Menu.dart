// ignore_for_file: prefer_const_constructors

import 'package:deliverify/src/controllers/getxControllers/cart_controller.dart';
import 'package:deliverify/src/models/restaurantsModel.dart';
import 'package:deliverify/src/pages/services/order_Cart.dart';
import 'package:deliverify/src/utils/Constants.dart';
import 'package:deliverify/src/utils/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestuarantMenu extends StatefulWidget {
  ResturantModel rest;
  RestuarantMenu({
    Key? key,
    required this.rest,
  }) : super(key: key);

  @override
  State<RestuarantMenu> createState() => _RestuarantMenuState();
}

class _RestuarantMenuState extends State<RestuarantMenu>
    with SingleTickerProviderStateMixin {
  CartController cartController = Get.put(CartController());
  CartController readController = Get.find();

  late AnimationController animationController;
  late Animation buttonsAnimation;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
        animationBehavior: AnimationBehavior.preserve);

    buttonsAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate));

    animationController.addListener(() {
      setState(() {});
    });
  }

  List<Icon> icons = [
    const Icon(Icons.coffee_rounded, color: Colors.amber),
    const Icon(FontAwesomeIcons.cakeCandles, color: Colors.amber),
    const Icon(FontAwesomeIcons.cocktail, color: Colors.amber),
    const Icon(
      FontAwesomeIcons.burger,
      color: Colors.amber,
    )
  ];
  late ScrollController controller = ScrollController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.25 +
                size.height * 0.10 * buttonsAnimation.value,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.rest.image!,
                          ),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    bottom: 0,
                    left: size.width * 0.21,
                    child: Card(
                      elevation: 10,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        width: size.width * 0.6 * buttonsAnimation.value,
                        height: size.height * 0.2 * buttonsAnimation.value,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    size.height * 0.01 * buttonsAnimation.value,
                              ),
                              SizedBox(
                                height:
                                    size.height * 0.04 * buttonsAnimation.value,
                                child: Text(
                                  widget.rest.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lora(
                                      textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                              ),
                              SizedBox(
                                height:
                                    size.height * 0.01 * buttonsAnimation.value,
                              ),
                              SizedBox(
                                height:
                                    size.height * 0.04 * buttonsAnimation.value,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.thumbsUp,
                                        color: Color.fromARGB(255, 0, 39, 71),
                                      ),
                                      const Text(
                                        ' 80%   ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(children: const [
                                        Icon(
                                          FontAwesomeIcons.motorcycle,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          '   30-40 min  ',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: size.height *
                                      0.05 *
                                      buttonsAnimation.value,
                                  child: Text(
                                    ' \n25 MAD ',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough),
                                  )),
                              SizedBox(
                                  height: size.height *
                                      0.05 *
                                      buttonsAnimation.value,
                                  child: Text(
                                    ' Free ',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.amber,
                                      fontSize: 18,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    height: isVisible ? size.height * 0.58 : size.height * 0.58,
                    child: NotificationListener<UserScrollNotification>(
                      onNotification: (notif) {
                        if (notif.direction == ScrollDirection.reverse) {
                          setState(() {
                            if (isVisible) {
                              isVisible = false;
                            }
                            animationController.forward();
                          });
                        } else if (notif.direction == ScrollDirection.forward) {
                          setState(() {
                            if (!isVisible) {
                              isVisible = true;
                            }
                            animationController.reverse();
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: widget.rest.menu!.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      height: size.height * 0.07,
                                      child: Row(
                                        children: [
                                          icons[index],
                                          SizedBox(
                                            width: size.width * 0.008,
                                          ),
                                          textWidget(widget
                                              .rest.menu![index].catname!),
                                        ],
                                      )),
                                  SizedBox(
                                    height: size.height * 0.4,
                                    child: ListView.builder(
                                        controller: controller,
                                        itemCount: widget
                                            .rest.menu![index].cat!.length,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index2) {
                                          return Card(
                                            shadowColor: lightIcon,
                                            borderOnForeground: true,
                                            semanticContainer: true,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            elevation: 10,
                                            margin: EdgeInsets.zero,
                                            child: ListTile(
                                              subtitle: Text(
                                                '    ${widget.rest.menu![index].cat![index2].itemprice!} MAD  ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              leading: IconButton(
                                                onPressed: () {
                                                  cartController.removecat(
                                                      widget.rest.menu![index]
                                                          .cat![index2]);
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                ),
                                              ),
                                              //trailling
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    cartController.addCat(widget
                                                        .rest
                                                        .menu![index]
                                                        .cat![index2]);
                                                  },
                                                  icon: Icon(Icons.add)),
                                              title: Text(
                                                widget.rest.menu![index]
                                                    .cat![index2].itemname!,
                                                style: TextStyle(
                                                    letterSpacing: 1.5,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  isVisible
                      ? Container()
                      : Container(
                          height:
                              size.height * 0.05 * (1 - buttonsAnimation.value),
                        ),
                  Obx(
                    () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(size.width * 0.8, size.height * 0.05)),
                        onPressed: readController.total == '0'
                            ? null
                            : () {
                                Get.to(OrderCart());
                              },
                        child: Text('Order (${readController.total} MAD)')),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
