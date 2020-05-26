import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/index.dart';
import '../providers/navi.dart';
import '../config/index.dart';

final List<Screen> allScreens = <Screen>[
  Screen(appName, Icons.home, 'Home', Colors.white, HomeScreen(), false),
  Screen('Empty', Icons.threesixty, 'Empty', Colors.white, EmptyScreen(), true),
];

class BottomNavi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var naviProvider = Provider.of<NaviProvider>(context);
    return BottomNavigationBar(
      currentIndex: naviProvider.currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).primaryColor,
      onTap: (int index) {
        naviProvider.setActiveIndex(
            index, allScreens[index].showAppbar, allScreens[index].appBarTitle);
      },
      items: allScreens.map((Screen screen) {
        return BottomNavigationBarItem(
          icon: Icon(
            screen.icon,
            color: Colors.grey.withOpacity(0.5),
          ),
          activeIcon: Icon(
            screen.icon,
            color: screen.color,
          ),
          title: Text(screen.title),
        );
      }).toList(),
    );
  }
}

class Screen {
  final String appBarTitle;
  final IconData icon;
  final String title;
  final Color color;
  final Widget screen;
  final bool showAppbar;

  Screen(this.appBarTitle, this.icon, this.title, this.color, this.screen,
      this.showAppbar);

  Widget get getScreen {
    return screen;
  }
}
