import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDatetime;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    return token != null;
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

  Future<void> signup(String inputEmail, String inputPw) {
    const signupPostUrl = 'https://jsonplaceholder.typicode.com/posts';

    return _authenticate(inputEmail, inputPw, signupPostUrl);
  }

  Future<void> login(String inputEmail, String inputPw) {
    const loginPostUrl = FIREBASE_EMAIL_PW_LOGIN_URL + FIREBASE_WEB_API_KEY;

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
          {
            'email': inputEmail,
            'password': inputPw,
            'returnSecureToken': true,
          },
        ),
      );

      final responseMap = (jsonDecode(response.body) as Map<String, dynamic>);

      if (responseMap.containsKey('error')) {
        throw HttpException(responseMap['error']['message']);
      }

      // else set all values here
      _token = responseMap['idToken'];
      _userId = responseMap['localId'];
      _expiryDatetime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseMap['expiresIn']),
        ),
      );

      _setupAutoLogout();
      notifyListeners();

      final sharedPref = await SharedPreferences.getInstance();
      final userAuthData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDatetime': _expiryDatetime.toIso8601String(),
      });
      sharedPref.setString(SHARED_PREF_USER_AUTH_STRING, userAuthData);
    } catch (exception) {
      throw exception;
    }
  }

  Future<bool> tryAutoLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (!sharedPrefs.containsKey(SHARED_PREF_USER_AUTH_STRING)) {
      return false; // automatically wrapped in future coz of async
    }

    final savedUserAuth =
        jsonDecode(sharedPrefs.get(SHARED_PREF_USER_AUTH_STRING))
            as Map<String, Object>;
    final expiryDtFromFirebase =
        DateTime.parse(savedUserAuth['expiryDatetime']);

    if (expiryDtFromFirebase.isBefore(DateTime.now())) {
      // token has expired
      return false;
    }

    notifyListeners();
    _setupAutoLogout();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expiryDatetime = null;
    _userId = null;

    notifyListeners();

    final sharedPrefs = await SharedPreferences.getInstance();
    //sharedPrefs.remove('userData'); // clears on userData
    sharedPrefs.clear(); // clears all-all app data
  }

  void _setupAutoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiryInSecs =
        _expiryDatetime.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiryInSecs), logout);
  }
}
