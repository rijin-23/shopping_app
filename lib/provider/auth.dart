import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String token;
  String userId;
  DateTime expirytime;

  Future<void> _authenticate(
      String email, String password, String urlPart) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlPart?key=AIzaSyDQkNGuOtS4SG-fIb5NRA61cR236waLr-0';
    final response = await http.post(
      url,
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );
    print(
      jsonDecode(response.body),
    );
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
