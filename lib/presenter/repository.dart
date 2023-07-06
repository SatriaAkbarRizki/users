import 'dart:convert';

import 'package:users/model/users.dart';
import 'package:http/http.dart' as http;

class Repository {
  List<UsersModel>? usersModel;
  Uri uri = Uri.parse("https://64a58a1500c3559aa9bfe0b5.mockapi.io/users");
  Future<List<UsersModel>?> FetchUser() async {
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return null;
    } else {
      List<dynamic> data = jsonDecode(response.body);
      return usersModel = data.map((e) => UsersModel.fromJson(e)).toList();
    }
  }

  Future postUser(UsersModel user) async {
    try {
      final response = await http.post(uri, body: user.toJson());

      if (response.statusCode != 201) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
