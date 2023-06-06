import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(30)

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.library_books,size: 40,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search,size: 40,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.pie_chart,size: 40,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.home,size: 40,),
            ),
            
          ],
        )
      )
    );
  }
}
