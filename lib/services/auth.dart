import 'dart:async';
import 'http.dart';

class AuthService {
  final HttpService _http = new HttpService();

  Future<dynamic> login(String username, String password) async {
    var login =
        await _http.post('login', {username: username, password: password});

    print(login.toString());
    var success = login.jwt != null;
    if (success) {
      // _http.updateAuthBox(auth);
    }

    return success;
  }
}
