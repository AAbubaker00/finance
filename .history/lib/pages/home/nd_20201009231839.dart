import 'package:flutter/material.dart';

class Nd extends StatefulWidget {
  @override
  _NdState createState() => _NdState();
}

class _NdState extends State<Nd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 10,
                right: 200,
                left: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.7,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      ),Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AAPL"),
                          Column(
                            children: [Text("£3223"), Text("+356.4%")],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),Positioned(
                 top: 10,
                left: 200,
                right: 10,
                child: Container(
                  color: Colors.red,
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Column(
                    children: [
                      Text("20"),
                      Text("Total Stocks")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
