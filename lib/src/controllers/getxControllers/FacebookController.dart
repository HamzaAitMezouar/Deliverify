import 'package:deliverify/main.dart';
import 'package:deliverify/src/controllers/apis/facebookSignIn.dart';
import 'package:deliverify/src/models/facebookModel.dart';
import 'package:get/get.dart';

class FacebookController extends GetxController {
  var user = FacebookModel(
    name: '',
    email: '',
    url: '',
  ).obs;

  getuser() {
    FacebookModel userM = FacebookApi().getUser();
    print(userM.name);
    user.value = userM;
  }
}
