import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  List options = ["About us", "Documentaion", "Log Out"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget(
              child: Container(
          child: ListView(
            children: options.map((o) {
              return ButtonTheme(
                child: IconButton(
                  icon: Row(children: [
                    Icon(Icons.account_box),
                    Text("About us")
                  ],),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

//! sign out: _auth.signOut()
