import 'package:finance/services/Login/authentication.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  List options = ["About us", "Documentaion", "Log Out"];

  final AuthService _aut

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(children: [
            IconButton(
              icon: Row(
                children: [Icon(Icons.account_box), Text("About us")],
              ),
            ),
            IconButton(
              icon: Row(
                children: [Icon(Icons.account_box), Text("Documnetaion")],
              ),
            ),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Row(
                children: [Icon(Icons.account_box), Text("Log Out")],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

//! sign out: _auth.signOut()
