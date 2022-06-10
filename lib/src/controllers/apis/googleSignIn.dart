import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static final googleSignin = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() {
    print(googleSignin.signIn());
    return googleSignin.signIn();
  }

  static Future logout() {
    return googleSignin.disconnect();
  }
}
