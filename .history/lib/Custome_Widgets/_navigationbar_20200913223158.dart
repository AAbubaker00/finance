import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 500,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10)

        ),
        child: Row(
          child
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.library_books,size: 50,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search,size: 50,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.pie_chart,size: 50,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.home,size: 50,),
            ),
            
          ],
        )
      )
    );
  }
}
