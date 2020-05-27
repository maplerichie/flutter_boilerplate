import 'dart:async';
import 'http.dart';

class AuthService {
  final HttpService _http = new HttpService();

  Future<dynamic> login(String username, String password) async {
    var res =
        await _http.post('login', {username: username, password: password});

    if (res is bool) {
      return res;
      // _http.updateAuthBox(auth);
    }

    return res;
  }
}
