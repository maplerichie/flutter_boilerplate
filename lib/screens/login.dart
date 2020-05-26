import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/index.dart';
import '../services/http.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username;
  TextEditingController _password;
  final _loginFormKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget _textField(TextEditingController ctrl, Widget icon, String hint,
      int minLength, String errMsg,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: ctrl,
        validator: (value) {
          if (value.isEmpty && minLength != 0) {
            return "Please don't leave blank";
          }
          if (value.length < minLength) {
            return errMsg;
          }
          return null;
        },
        obscureText: isPassword,
        autofocus: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Container(
            child: icon,
            margin: EdgeInsets.only(
              top: 14.0,
              left: 30.0,
              right: 20.0,
            ),
          ),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _resetPwBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Text(
          'Reset Password?',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          print('Reset pw');
        },
      ),
    );
  }

  Widget _learnMoreBtn() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: Text(
          'Learn More',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () async {
          final url = 'https://www.google.com';
          if (await canLaunch(url)) {
            await launch(
              url,
              forceSafariVC: false,
            );
          }
        },
      ),
    );
  }

  Widget _loginBtn() {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red,
        ),
      ),
      color: Colors.white,
      onPressed: () async {
        if (_loginFormKey.currentState.validate()) {
          // if (!await Provider.of<AuthProvider>(context, listen: false).login(
          //   username: _username.text.trim(),
          //   password: _password.text.trim(),
          // )) {
          //   _key.currentState.showSnackBar(SnackBar(
          //     content: Text("Invalid credential. Please try again."),
          //   ));
          // }
          if (!await Provider.of<AuthProvider>(context, listen: false)
              .loginAnonymous(true)) {
            _key.currentState.showSnackBar(SnackBar(
              content: Text("Invalid credential. Please try again."),
            ));
          }
        }
      },
    );
  }

  Widget _title(double size1, double size2) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Flutter\n',
        style: GoogleFonts.lato(
          fontSize: size1,
          color: Colors.white,
          fontWeight: FontWeight.w100,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Boilerplate',
            style: TextStyle(
              fontSize: size2,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: deviceSize.height * 0.125,
              ),
              _title(
                deviceSize.height / 8,
                deviceSize.height / 32,
              ),
              SizedBox(
                height: deviceSize.height * 0.1,
              ),
              Provider.of<AuthProvider>(context).status == Status.Authenticating
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : Form(
                      key: _loginFormKey,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          _textField(
                              _username,
                              FaIcon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              "Username",
                              6,
                              "Invalid username"),
                          _textField(
                            _password,
                            FaIcon(
                              FontAwesomeIcons.lock,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            "Password",
                            6,
                            "Invalid password",
                            isPassword: true,
                          ),
                          _resetPwBtn(),
                          SizedBox(
                            height: deviceSize.height * 0.025,
                          ),
                          _loginBtn(),
                        ],
                      ),
                    ),
              Expanded(
                child: _learnMoreBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
