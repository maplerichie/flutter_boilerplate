import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../models/index.dart';
import '../services/index.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  String _boxName = "authBox";
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
      notifyListeners();
    });
  }

  Future<bool> login({String username, String password}) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      return await AuthService().login(username, password).then((res) {
        if (res is bool) {
          _status = Status.Unauthenticated;
          notifyListeners();
          return res;
        }
        _auth = new Auth(
          jwt: res['jwt'],
          role: 1,
          status: 1,
          user: User.fromJson(json.encode(res['data'])),
        );
        updateAuthBox(_auth);
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      });
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future logout() async {
    resetAuth();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> loginAnonymous(bool isSuccess) async {
    print('LoginAnonymous');
    _status = Status.Authenticating;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 800), () {
      if (isSuccess) {
        _auth = new Auth(
            role: 0,
            status: 1,
            user: new User(
              fullName: 'John Doe',
              contactNo: '60123456789',
            ));

        _status = Status.Authenticated;
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
      }
    });
    return isSuccess;
  }

  void resetAuth() async {
    await Hive.deleteBoxFromDisk(_boxName);
    _auth = null;
    _status = Status.Unauthenticated;
  }

  Future<Auth> getAuthBox() async {
    var authBox = await Hive.openBox(_boxName);
    if (authBox.length < 1) {
      return _auth = null;
    } else {
      _auth = authBox.getAt(0);
    }
    return _auth;
  }

  void updateAuthBox(Auth auth) async {
    var authBox = await Hive.openBox(_boxName);
    authBox.add(auth);
    _auth = auth;
  }
}
