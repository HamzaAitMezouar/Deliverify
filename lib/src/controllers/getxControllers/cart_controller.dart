import 'package:deliverify/src/models/restaurantsModel.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var _cat = {}.obs;
  addCat(Cat cat) {
    if (_cat.containsKey(cat)) {
      _cat[cat] += 1;
    } else {
      _cat[cat] = 1;
    }
    Get.snackbar(
        'You Added an item to your list', 'You Ordered a ${cat.itemname} ',
        snackPosition: SnackPosition.BOTTOM);
    print(_cat.keys.toList()[0].itemprice);
    print(_cat.values.toList());
  }

  get cat {
    if (_cat.isEmpty) {
      return;
    } else {
      return _cat;
    }
  }

  /*get producttotal {
    for (int i = 0; i < _products.length; i++) {
      Products prod = _products.keys.toList()[i];
      // ignore: invalid_use_of_protected_member
      return prod.price! * _products.value[prod];
    }
  }

  get total => _products.entries.isNotEmpty
      ? _products.entries.map(((e) => e.key.price * e.value)).toList().reduce(
          (value, element) {
            return value + element;
          },
        )
      : '0';*/

  removeProduct(Cat cat) {
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

