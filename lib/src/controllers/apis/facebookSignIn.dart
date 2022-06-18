import 'dart:convert';

import 'package:deliverify/main.dart';
import 'package:deliverify/src/models/facebookModel.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class FacebookApi {
  Future<void> signin() async {
    print("userJson");
    late FacebookModel user;

    final status = await Permission.storage.request();
    print("userJson");
    FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then(
        (value) => FacebookAuth.instance.getUserData().then((value) {
              print(value);
              user = FacebookModel.fromJson(value);
              print('Useeeer ${user.email}');
              final userJson = jsonEncode(user.toJson());
              print('Useeeer222 ${userJson}');
              sharedPreferences!.setString('user', userJson);
              print(sharedPreferences!.get('user'));
            }));
  }

  FacebookModel getUser() {
    late FacebookModel user;
    FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then(
        (value) => FacebookAuth.instance
            .getUserData()
            .then((value) => user = FacebookModel.fromJson(value)));
    return user;
  }

  logout() {
    FacebookAuth.instance.logOut();
  }
}
