import 'package:flutter/material.dart';
import 'package:flutter_palette/flutter_palette.dart' as fp;
import 'dart:ui';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.26,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                toolbarHeight: 40,
                backgroundColor: Colors.transparent,
                title: Text("asdasd"),
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.15,
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.45,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.attach_money),
                              Text("Total Invested"),
                              Text("£2,282")
                            ],
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.15,
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.45,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.attach_money),
                                Text("Total Invested"),
                                Text("£2,282")
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                top: 170,
                right: 0,
                left: 0,
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent,dividerTheme: DividerThemeData(color: Theme.of(context).colorScheme.)),
                  child: ExpansionTile(
                    title: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View Portfolio Stasistics",
                          style: TextStyle(color: Colors.white),
                        )),
                    children: [
                      ListTile(
                        title: Text("lol"),
                      )
                    ],
                  ),
                )

                // FlatButton(
                //   onPressed: (){},
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text("View Portfolio Stasistics", style: TextStyle(color: Colors.white),),
                //       Transform.rotate(
                //         angle: 270*math.pi/180,
                //         child: Icon(Icons.arrow_drop_down_circle,color: Colors.white,),
                //       )
                //     ],
                //   ),
                // )
                )
            // Positioned(
            //   top: 200,
            //   right: 10,
            //   left: 10,
            //   child: Container(
            //     height: MediaQuery.of(context).size.height*0.05,
            //       padding: EdgeInsets.only(left: 10, right: 10),
            //       child: DecoratedBox(
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Colors.white),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Align(
            //               alignment: Alignment.centerLeft,
            //               child: Text("Total Shares: 213123"),
            //             ),
            //             Text("Total Stocks: 12"),
            //           ],
            //         ),
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}

// Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[Text("£asdadasd"), Text("Total Gain"), Text("Daily Gain")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("52 Week Gain"), Text("Daily Gain")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Daily Gain"), Text("Daily Gain")],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Acquired Stock")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Acquired Shares")],
//               ),
//             ],
//           )
