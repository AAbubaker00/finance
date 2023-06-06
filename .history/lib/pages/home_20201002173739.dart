import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:finance/models/portfolio.dart';
import 'package:finance/pages/sts.dart';
import 'package:finance/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List portfolios = [""];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userStockData,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
                      child: AppBar(
                        centerTitle: false,
              
              actions: [IconButton(icon: Icon(Icons.add), onPressed: null)],
              title:
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Abdull Abubaker",
                                    style: TextStyle(fontSize: 15)),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Net: £56,782,334",
                                    style: TextStyle(fontSize: 15)),
                                        Text("Stocks: 23",
                                    style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Margin: +563%",
                                    style: TextStyle(fontSize: 15)),
                                        Text("shares: 23131233213",
                                    style: TextStyle(fontSize: 15)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
            ),
          ),
          // body: Dats(),
          body: Stack(
            children: [
              
              Positioned(
                top: 100,
                right: 20,
                left: 20,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.red, width: 5)),
                            child: Center(
                                child: Text(
                              "+46%",
                              style: TextStyle(fontSize: 35),
                            )),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Stock Portfolio"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [Text("Vlaue"), Text("£7272")],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [Text("Gain/Loss"), Text("+12.2%")],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 10, right: 60, left: 60, child: ZNavigationBar())
            ],
          ),
        ),
      ),
    );
  }
}
