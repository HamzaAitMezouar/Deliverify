import 'dart:convert';

import 'package:deliverify/main.dart';
import 'package:deliverify/src/models/googleModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static final googleSignin = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() {
    print(googleSignin.currentUser);
    GoogleSignInAccount googleAccount = googleSignin.currentUser!;
    GoogleModel? user;
    user!.email = googleAccount.email;
    user.displayName = googleAccount.displayName!;
    user.photoUrl = googleAccount.photoUrl!;
    final userjson = jsonEncode(user.toJson());
    sharedPreferences!.setString('user', userjson);
    return googleSignin.signIn();
  }

  GoogleModel getUser() {
    GoogleSignInAccount googleAccount = googleSignin.currentUser!;
    GoogleModel? user;
    user!.email = googleAccount.email;
    user.displayName = googleAccount.displayName!;
    user.photoUrl = googleAccount.photoUrl!;
    return user;
  }

  static Future logout() {
    return googleSignin.disconnect();
  }
}
