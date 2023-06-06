import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ,
      color: Colors.pink,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)

        ),
        child: Row(
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.library_books),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.pie_chart),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.home),
            ),
            
          ],
        )
      )
    );
  }
}
