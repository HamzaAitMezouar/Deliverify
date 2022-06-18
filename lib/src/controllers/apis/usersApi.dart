import 'dart:convert';

import 'package:deliverify/src/models/googleModel.dart';
import 'package:http/http.dart' as http;

class usersApi {
  static final client = http.Client();
  register(String name, email, password) async {
    print('Register success0000');
    Map<String, String> requestHeaders = {"Content-Type": 'application/json'};
    print('Register success1111"');
    final uri = Uri.http("10.0.0.7:4000", 'deliverify/register');
    print('Register success0333333');
    final response = await client.post(
      uri,
      headers: requestHeaders,
    );
    print('object ++ ${response.body}');

    if (response.statusCode == 200) {
      print('Register success');
    } else {
      print('Register Failed');
    }
  }

  login(String email, password) async {
    Map<String, String> requestHeaders = {"Content-Type": 'application/json'};
    final uri = Uri.http("10.0.0.7:4000", 'signin');
    final response = await client.post(uri,
        headers: requestHeaders, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      print('SignIn success');
      print(email);
    } else {
      print('SignIn Failed');
    }
  }
}
