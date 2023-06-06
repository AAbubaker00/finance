import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10)

        ),
        child: Row(
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.library_books,siz),
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
