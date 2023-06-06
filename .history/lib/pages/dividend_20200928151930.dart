import 'package:flutter/material.dart';

class Dividend extends StatefulWidget {
  @override
  _DividendState createState() => _DividendState();
}

List

class _DividendState extends State<Dividend> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child:
                  InkWell(
                    GridView.count(
                      crossAxisCount: 6,
                      children: [],
                    )
                  )
                ),
              )
            )
          ],
        ),
      )
    );
  }
}


class MonthDividend{
  final String comapny;
  final Double amount;
  final String date;

  MonthDividend({
    @required this.comapny,
    @require
    });
}
