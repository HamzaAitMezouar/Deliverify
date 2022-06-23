import 'dart:convert';

import 'package:deliverify/main.dart';
import 'package:deliverify/src/models/facebookModel.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookApi {
  /*Future<FacebookModel?> signin() async {
    FacebookModel user = FacebookModel(name: '', email: '', url: '');

    FacebookAuth.instance.login(permissions: ["public_profile", "email"]).then(
        (value) => FacebookAuth.instance.getUserData().then((value) {
              user = FacebookModel.fromJson(value);

              final userJson = jsonEncode(user.toJson());
              print(user.name);
              sharedPreferences!.setString('user', userJson);
            }));

    return user;
  }*/

  Future<FacebookModel?> getUser() async {
    late FacebookModel user = FacebookModel(name: '', email: '', url: '');
    final result = await FacebookAuth.i.login();
    if (result.status == LoginStatus.success) {
      final data = await FacebookAuth.i.getUserData(fields: "email,name");
      user = FacebookModel.fromJson(data);
    }
    print(user.name);
    sharedPreferences!.setString('user', jsonEncode(user.toJson()));
    return user;
  }

  logout() {
    FacebookAuth.instance.logOut();
  }
}
