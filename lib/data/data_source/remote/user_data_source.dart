import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final userDataSource = Provider<UserDataSource>((ref) {
  return UserDataSource(ref);
});

class UserDataSource {
  final Ref ref;
  UserDataSource(this.ref);
  Future<List> fetchUser(int since) async {
    final http.Response response =
        await http.get(Uri.parse("https://api.github.com/users?since=$since"));
    final List result = json.decode(response.body);
    return result;
  }

  Future<List> fetchUserRepo(String userName) async {
    final http.Response response = await http
        .get(Uri.parse("https://api.github.com/users/$userName/repos"));
    final List result = json.decode(response.body);
    return result;
  }
}
