import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getString('user') == null)
      return RouteSettings(name: '/login');
    else
      return RouteSettings(name: '/home');
  }
}
