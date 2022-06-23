import 'package:deliverify/src/models/restaurantsModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cat = {}.obs;

  get keys => null;
  addCat(Cat cat) {
    if (_cat.containsKey(cat)) {
      _cat[cat] += 1;
    } else {
      _cat[cat] = 1;
    }
    Get.snackbar(
        duration: Duration(milliseconds: 200),
        'You Added an item to your order',
        'You Ordered a ${cat.itemname} ',
        snackPosition: SnackPosition.TOP);
    print(_cat.keys.toList());
    print(_cat.values.toList());
  }

  get cat => _cat;

  /*get producttotal {
    for (int i = 0; i < _products.length; i++) {
      Products prod = _products.keys.toList()[i];
      // ignore: invalid_use_of_protected_member
      return prod.price! * _products.value[prod];
    }
  }
*/
  get total => _cat.entries.isNotEmpty
      ? _cat.entries.map(((e) => e.key.itemprice * e.value)).toList().reduce(
          (value, element) {
            return value + element;
          },
        )
      : '0';

  removecat(Cat cat) {
    if (_cat.containsKey(cat) && _cat[cat] == 1) {
      _cat.removeWhere((key, value) => key == cat);
    } else {
      _cat[cat] -= 1;
    }
  }
}

  /*var cat = Cat();
  RxInt itemNumber = 0.obs;
  List<Cat> listcat = [];
  RxInt itemNumbers = 0.obs;
  RxDouble oneItemPrice = 0.0.obs;
  RxDouble alltemPrice = 0.0.obs;

  addItem(Cat catitem) {
    cat = catitem;
    itemNumber++;
    itemNumbers++;
    oneItemPrice = oneItemPrice + (itemNumber * cat.itemprice!) as RxDouble;
    listcat.add(catitem);
    alltemPrice = alltemPrice + (itemNumber * cat.itemprice!) as RxDouble;

    print(cat);
    print(itemNumber);
    print(itemNumbers);
    print(cat);
    print(cat);
    print(listcat);
    print(alltemPrice);
    update();
  }

  removeItemItem(Cat catitem) {
    if (itemNumber == 1.obs) {
      cat = Cat();
      itemNumber = 0.obs;
      itemNumbers--;
      listcat.remove(cat);
      oneItemPrice = 0.0.obs;
      alltemPrice = alltemPrice - (itemNumber * cat.itemprice!) as RxDouble;
    } else {
      cat = catitem;
      itemNumber--;
      itemNumbers--;
      oneItemPrice = oneItemPrice - (itemNumber * cat.itemprice!) as RxDouble;
      alltemPrice = alltemPrice - (itemNumber * cat.itemprice!) as RxDouble;
    }
    update();
  }*/

