import 'dart:convert';

import 'package:flutter_application_2/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String url = "https://reqres.in/api/users?page=2";
  // ignore: body_might_complete_normally_nullable
  Future<Usermodel?> fetchUsers() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var jsonBody = Usermodel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("Hata 404");
    }
  }
}
