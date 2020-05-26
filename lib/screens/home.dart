import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchCtrl = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  bool isSearchEmpty = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: 130,
              ),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ),
              Positioned(
                left: 30.0,
                top: 40.0,
                child: Text(
                  'Have a nice day',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                top: 25.0,
                child: IconButton(
                  icon: Icon(Icons.notifications_none),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Positioned(
                left: 18.0,
                right: 18.0,
                top: 70.0,
                child: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.5,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          autofocus: false,
                          controller: _searchCtrl,
                          focusNode: _searchFocusNode,
                          onChanged: (text) {
                            setState(() {
                              isSearchEmpty = !(_searchCtrl.text.length > 0);
                            });
                          },
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Search something',
                            contentPadding: EdgeInsets.all(6.0),
                            hintStyle: TextStyle(
                              fontSize: 12.0,
                            ),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearchEmpty = true;
                          });
                          _searchCtrl.clear();
                          _searchFocusNode.unfocus();
                        },
                        child: isSearchEmpty
                            ? Icon(
                                Icons.clear,
                                color: Colors.transparent,
                              )
                            : Icon(
                                Icons.clear,
                                color: Colors.black,
                              ),
                      ),
                      Container(
                        width: 1,
                        height: 30.0,
                        color: Colors.grey,
                        margin: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                      ),
                      GestureDetector(
                        child: FaIcon(
                          FontAwesomeIcons.qrcode,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
