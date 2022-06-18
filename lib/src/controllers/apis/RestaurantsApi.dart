import 'dart:convert';
import 'package:deliverify/src/models/restaurantsModel.dart';
import 'package:http/http.dart' as http;

class ResturantsApi {
  Future<List<ResturantModel>> getRestaurants(String city) async {
    final uri = Uri.http(
      '10.0.2.2:3000',
      'api', /* {
      // "city": city,
    }*/
    );
    final response = await http.get(
      uri,
    );

    Map data = jsonDecode(response.body.toString());

    List list = [];
    List<ResturantModel> rests;

    if (response.statusCode == 200) {
      for (var i in data['result']) {
        list.add(i);
      }

      rests = list.map((e) => ResturantModel.fromJson(e)).toList();

      return rests;
      // return ResturantModel.fromJson(data['result']);
    } else {
      for (var i in data['result']) {
        list.add(i);
      }
      rests = list.map((e) => ResturantModel.fromJson(e)).toList();
      print('${rests.length}');
      return rests;
    }
    //   return ResturantModel.fromJson(data['result']);
  }
}
