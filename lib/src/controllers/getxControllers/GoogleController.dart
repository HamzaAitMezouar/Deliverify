import 'package:deliverify/src/controllers/apis/googleSignIn.dart';
import 'package:get/get.dart';

import '../../models/googleModel.dart';

class GoogleController extends GetxController {
  late GoogleModel user;

  currentUser() {
    user = GoogleSigninApi().getUser();
    print(user);
  }
}
