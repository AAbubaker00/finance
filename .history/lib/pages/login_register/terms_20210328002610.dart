import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(child: Scaffold(
        body: ListView(
          children: [
            RichText(
              text: TextSpan(
                text: 'Terms of Service',
                
              ),
            )
          ],
        ),
      )),
    );
  }
}