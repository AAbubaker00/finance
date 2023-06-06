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

  TextStyle casualText = TextStyle(color: Colors.white38, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(

                          child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: Align(
                          alignment: Alignment.center, child: ZNavigationBar()))),
            );
          });
    }

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userStockData,
      child: Container(
        color: Color(0xff191919),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xff191919),
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
                                TextStyle(fontSize: 20, color: Colors.white70)),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Net: £56,782,334",
                                    style: casualText),
                                Text("Stocks: 23",
                                    style:casualText),
                              ],
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Margin:",
                                        style: casualText),
                                        Text(" +563%", style: TextStyle(color: Colors.green[900], fontSize: 15),)
                                  ],
                                ),
                                Text("shares: 23131233213",
                                    style: casualText),
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
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.arrow_drop_up_outlined, color: Colors.pink,size: 30,),
            ),
          ),
        ),
      ),
    );
  }

  Stream<Map<dynamic, dynamic>> get portfolio(List<){
    return 
  }
}
