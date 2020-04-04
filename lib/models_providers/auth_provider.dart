import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDatetime;
  String _userId;

  bool get isAuthenticated {
    return false; // TODO
    // return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDatetime != null &&
        _expiryDatetime.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> login(String inputEmail, String inputPw) {
    const loginPostUrl = 'https://jsonplaceholder.typicode.com/posts';

    return _authenticate(inputEmail, inputPw, loginPostUrl);
  }

  Future<void> _authenticate(
    String inputEmail,
    String inputPw,
    String authUrl,
  ) async {
    try {
      final response = await http.post(
        authUrl,
        body: jsonEncode(
          {'title': 'foo', 'body': 'bar', 'userId': 1},
        ),
      );

      final responseMap = (jsonDecode(response.body) as Map<String, dynamic>);

      if (responseMap.containsKey('error')) {
        throw HttpException(responseMap['error']['message']);
      }

      // else set all values here
      // TODO uncomment below
      // _token = responseMap['idToken'];
      // _userId = responseMap['localId'];
      // _expiryDatetime = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(responseMap['expiresIn']),
      //   ),
      // );

      final sharedPref = await SharedPreferences.getInstance();
      final userAuthData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDatetime': _expiryDatetime.toIso8601String(),
      });
      sharedPref.setString('userAuthData', userAuthData);
    } catch (exception) {
      throw exception;
    }
  }
}
