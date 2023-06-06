import 'package:finance/services/Login/authentication.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  //! Email and Password data
  String email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Finace"),
          Container(
            padding: EdgeInsets.only(left: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign In"),
                  TextFormField(
                    validator: (txt) =>
                        txt.isEmpty ? 'Enter email' : null,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter Email",
                        icon: Icon(Icons.alternate_email)),
                    onChanged: (txt) {
                      setState(() => email = txt);
                    },
                  ),
                  TextFormField(
                    validator: (txt) =>
                        txt.length < 6 ? 'Enter passowrd longer than 6' : null,
                    style: TextStyle(fontSize: 20),
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Enter Password",
                        icon: Icon(Icons.lock_outline)),
                    onChanged: (txt) {
                      setState(() => _password = txt);
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonTheme(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  child: Text("Register"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
              ButtonTheme(
                child: FlatButton(
                  onPressed: () async {
                    Navigator
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  child: Text("Login In"),
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text("Or Login with"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.g_translate),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.g_translate),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Continue without Login ->"),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();

                  if (result == null) {
                    print("error signing in");
                  } else {
                    print("signed, $result");
                  }
                },
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
