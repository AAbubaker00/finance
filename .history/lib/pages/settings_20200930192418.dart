import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  List options = ["About us", "Documentaion", "Log Out"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(children: [
            IconButton(
                  icon: Row(children: [
                    Icon(Icons.account_box),
                    Text("About us")
                  ],),
                ),
              IconButton(
                  icon: Row(children: [
                    Icon(Icons.account_box),
                    Text("Doc")
                  ],),
                ),
                IconButton(
                  icon: Row(children: [
                    Icon(Icons.account_box),
                    Text("About us")
                  ],),
                ),
          ]),
        ),
      ),
    );
  }
}

//! sign out: _auth.signOut()
