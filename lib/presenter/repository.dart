import 'dart:convert';

import 'package:users/model/users.dart';
import 'package:http/http.dart' as http;

class Repository {
  List<UsersModel>? usersModel;

  Future<List<UsersModel>?> FetchUser() async {
    Uri uri = Uri.parse("https://64a58a1500c3559aa9bfe0b5.mockapi.io/users/");
    final response = await http.get(uri);
    print('respon : ${response}');
    if (response.statusCode != 200) {
      return null;
    } else {
      List<dynamic> data = jsonDecode(response.body);
      print('have data: ${data}');
      return usersModel = data.map((e) => UsersModel.fromJson(e)).toList();
    }
  }
}
