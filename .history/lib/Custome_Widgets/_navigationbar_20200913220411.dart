import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)

        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icon.news),
            )
          ],
        )
      )
    );
  }
}
