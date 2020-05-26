import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'login.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider auth, _) {
      switch (auth.status) {
        case Status.Uninitialized:
          return SplashScreen();
        case Status.Authenticated:
          switch (auth.auth.role) {
            default:
              return Consumer(builder: (context, NaviProvider navi, _) {
                return Scaffold(
                  appBar: navi.showAppbar
                      ? AppBar(
                          title: Text(navi.appBarTitle),
                        )
                      : null,
                  bottomNavigationBar: BottomNavi(),
                  body: allScreens[navi.currentIndex].getScreen,
                );
              });
          }
          break;
        default:
          return LoginScreen();
      }
    });
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff262262),
        image: DecorationImage(
          image: AssetImage('assets/images/splash.gif'),
          fit: BoxFit.cover,
        ),
      ),
      child: SpinKitFadingFour(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
