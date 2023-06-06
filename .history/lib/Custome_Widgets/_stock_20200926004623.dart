import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart' as Folding;

class ZContainer extends StatefulWidget {
  ZContainer(String symbol, String exchange) {}

  @override
  _ZContainerState createState() => _ZContainerState();
}

class _ZContainerState extends State<ZContainer> {
  final _foldingCellKey = GlobalKey<Folding.SimpleFoldingCellState>();

  TextStyle symbolStyle = TextStyle(color: Colors.white);
  TextStyle nameStyle = TextStyle(color: Colors.grey[300]);
  TextStyle exchnageStyle = TextStyle(color: Colors.grey[300]);
  TextStyle stanStyle = TextStyle(color: Colors.grey[300]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _foldingCellKey?.currentState?.toggleFold(),
      child: Folding.SimpleFoldingCell.create(
        key: _foldingCellKey,
        cellSize: Size(MediaQuery.of(context).size.width, 100),
        frontWidget: Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[400])
            ),
            child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.23,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Container(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.green[300], width: 3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "APPL",
                                style: symbolStyle,
                              ),
                              Text(
                                "Apple .inc Corp",
                                style: nameStyle,
                              ),
                              Text(
                                "NASDAQ",
                                style: exchnageStyle,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.58,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("invested: £272"),
                        Text("Avg. Cost: £207"),
                        Text("shares: 256")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("£272 gain"),
                        Text("Margin: 256"),
                        Text(""),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          )
        ),
        innerWidget: Container(
          color: Colors.red,
          child:DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              chi
            )
          )
        ),
      ),
    );

    // return InkWell(
    //   child: Container(
    //     margin: EdgeInsets.only(bottom: 10),
    //     height: MediaQuery.of(context).size.height * 0.13,
    //     child: DecoratedBox(
    //       decoration: BoxDecoration(
    //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
    //       child: Row(
    //         children: <Widget>[
    //           Container(
    //             padding: EdgeInsets.all(0),
    //             width: MediaQuery.of(context).size.width * 0.25,
    //             child: DecoratedBox(
    //               decoration: BoxDecoration(
    //                   color: Colors.black,
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(10),
    //                       bottomLeft: Radius.circular(10))),
    //               child: Container(
    //                 child: DecoratedBox(
    //                   decoration: BoxDecoration(
    //                       border: Border(
    //                           right: BorderSide(
    //                               color: Colors.green[300], width: 3))),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: <Widget>[
    //                       Column(
    //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             "APPL",
    //                             style: symbolStyle,
    //                           ),
    //                           Text(
    //                             "Apple .inc Corp",
    //                             style: nameStyle,
    //                           ),
    //                           Text(
    //                             "NASDAQ",
    //                             style: exchnageStyle,
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    // ),
    // SizedBox(
    //   width: 5,
    // ),
    // Container(
    //   width: MediaQuery.of(context).size.width * 0.68,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text("invested: £272"),
    //           Text("Avg. Cost: £207"),
    //           Text("shares: 256")
    //         ],
    //       ),
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Text("£272 gain"),
    //           Text("Margin: 256"),
    //           Text(""),
    //         ],
    //       ),
    //     ],
    //   ),
    // ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
