import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class User {
  int id;
  String first_name;
  String last_name;
  String email;
  String image;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.image,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        image: json['avatar']);
  }
}

Future<void> getUsers(
    {int page = 1,
    required PagingController<int, User> pagingController}) async {
  List<User> users = [];

  http.Response response = await http
      .get(Uri.parse("https://reqres.in/api/users?page=$page&per_page=4"));

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);

    List newData = data['data'];
    newData.forEach((element) {
      users.add(User.fromJson(element));
    });

    if (users.length < 4) {
      pagingController.appendLastPage(users);
    } else {
      final nextPageKey = page + 1;
      pagingController.appendPage(users, nextPageKey);
    }
  }
}
