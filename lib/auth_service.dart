import 'package:flutter/material.dart';
import 'package:bridge_it/utils/auth.dart';
import 'package:bridge_it/utils/centered_view.dart';
import 'package:bridge_it/' as fb;


class AuthPage extends StatefulWidget {

  AuthPage({this.auth, this.loginCallback, this.signupCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  final VoidCallback signupCallback;

  @override
  State<StatefulWidget> createState() => new _AuthPage();

}

class BaseAuth {
}

class _AuthPage extends State<AuthPage>{

  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void signInWithThirdParty() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    try {
      String userId  = "";
        userId  = await widget.auth.googleSignIn();
      setState(() {
        _isLoading = false;
      });
      final fb.DatabaseReference ref = fb.database().ref("users/" + userId);
      ref.once("value").then((e) async {
          if (e.snapshot.child("completeSignUp").exists() && 
          (e.snapshot.child("completeSignUp").val() == "true")){
            widget.loginCallback();
          } else if (e.snapshot.child("completeSignUp").exists() &&
          e.snapshot.child("completeSignUp").val() == "false") {
            widget.signupCallback();
          } else {
            var map = {"completeSignUp": "false"};
            await ref.set(map);
            widget.signupCallback();
          }
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = e.message.toString();
        _formKey.currentState.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: CenteredView(
                  child: Stack(
            children: <Widget>[
              _showForm(),
              _showCircularProgress(),
            ],
          ),
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showThirdPartyButtons(),
              SizedBox(height: 20,),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 150.0,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }

  Widget showThirdPartyButtons() {
        return new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              SizedBox(
                width: 300,
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.blue,
                  child: new Text("Login",
                      style: new TextStyle(fontSize: 15.0, color: Colors.white)),
                  onPressed: (){
                    signInWithThirdParty();
                  },
                ),
              ),
        ],
      )
    );
  }
}