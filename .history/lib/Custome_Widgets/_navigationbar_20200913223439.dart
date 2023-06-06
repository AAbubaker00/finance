import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 350,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10)

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
