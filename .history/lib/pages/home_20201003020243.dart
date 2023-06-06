import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:finance/models/portfolio.dart';
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
    void _showSettingsPanel() {
      showModalBottomSheet(
          // backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30)
                  ),
                    child: Align(
                        alignment: Alignment.center,
                        child: ZNavigationBar())));
          });
    }

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userStockData,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0x),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                centerTitle: false,
                actions: [IconButton(icon: Icon(Icons.add), onPressed: null)],
                title: Row(
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
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Net: £56,782,334",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
                                Text("Stocks: 23",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Margin: +563%",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
                                Text("shares: 23131233213",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
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
            body: Portfolios(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: IconButton(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.arrow_drop_up_outlined),
            ),
          ),
        ),
      ),
    );
  }
}
