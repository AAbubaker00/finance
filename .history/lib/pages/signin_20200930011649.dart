import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Finace"),
          Container(
            child: Column(
              pad
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Sign In"),
                TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Email Address",
                      icon: Icon(Icons.alternate_email)),
                ),TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Email Address",
                      icon: Icon(Icons.lock_outline)),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
