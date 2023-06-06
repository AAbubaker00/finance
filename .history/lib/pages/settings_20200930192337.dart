import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  List options = ["About us", "Documentaion", "Log Out"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              body: Container(
          child: ListView(
            children: [

            ]
                
            
          ),
        ),
      ),
    );
  }
}

//! sign out: _auth.signOut()
