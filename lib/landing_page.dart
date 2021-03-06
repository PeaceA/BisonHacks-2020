import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:bridge_it/dashboard.dart';
import 'package:bridge_it/auth_service.dart';
import 'package:bridge_it/utils/auth.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
  SIGNED_UP,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) async {
      var snap;
      if (user != null) {
        _userId = user?.uid;
        final fb.DatabaseReference ref = fb.database().ref("users/" + _userId + "/completeSignUp");
       await ref.once("value").then((e){
          snap = e.snapshot;
          if (snap != null && snap.val() == "false") {
              authStatus = AuthStatus.SIGNED_UP;
            } else {
              authStatus =
                user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
            }
        });
      } else {
        setState(() {
          authStatus =
              user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
        });
      }
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void signUpCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.SIGNED_UP;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new AuthPage(
          auth: widget.auth,
          loginCallback: loginCallback,
          signupCallback: signUpCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      case AuthStatus.SIGNED_UP:
        return new UserData(
          userId: _userId,
          loginCallback: loginCallback,
        );
      default:
        return buildWaitingScreen();
    }
  }
}