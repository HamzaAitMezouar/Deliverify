import 'dart:convert';

import 'package:deliverify/main.dart';
import 'package:deliverify/src/models/googleModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static final googleSignin = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => googleSignin.signIn();

  Future<GoogleModel> getUser() async {
    GoogleSignInAccount? googleAccount = await googleSignin.signIn();
    GoogleModel? user;
    user!.email = googleAccount!.email;
    user.displayName = googleAccount.displayName!;
    user.photoUrl = googleAccount.photoUrl!;
    return user;
  }

  static Future logout() {
    return googleSignin.disconnect();
  }
}
