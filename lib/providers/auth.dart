import 'dart:async';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../models/index.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Auth _auth;
  Status _status = Status.Uninitialized;

  dynamic get auth => _auth;
  Status get status => _status;

  AuthProvider() {
    getAuthBox().then((Auth auth) {
      if (auth != null) {
        _auth = auth;
        _status = Status.Authenticated;
      } else {
        _status = Status.Unauthenticated;
        _auth = null;
      }

      Future.delayed(Duration(milliseconds: 500), () {
        notifyListeners();
      });
    });
  }

  Future<bool> login({String username, String password}) async {
    print('Login');
    try {
      _status = Status.Authenticating;
      notifyListeners();
      // await authService.login(x,x);
      await Future.delayed(Duration(milliseconds: 1000), () {
        logout();
        return false;
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future logout() async {
    print('Logout');
    _auth = null;
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> loginAnonymous(bool isSuccess) async {
    print('LoginAnonymous');
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 800), () {
        if (isSuccess) {
          _auth = new Auth();
          _auth.role = 1;

          _status = Status.Authenticated;
          notifyListeners();
        } else {
          _status = Status.Unauthenticated;
          notifyListeners();
        }
      });
      return isSuccess;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<Auth> getAuthBox() async {
    var authBox = await Hive.openBox('authBox');
    if (authBox.length < 1) {
      return _auth = null;
    } else {
      _auth = authBox.getAt(0);
    }
    return _auth;
  }

  void updateAuthBox(Auth auth) async {
    var authBox = await Hive.openBox('authBox');
    authBox.add(auth);
    _auth = auth;
    notifyListeners();
  }

  void clearAuthBox() async {
    var authBox = await Hive.openBox('authBox');
    authBox.delete('authBox');
  }
}
