import 'dart:ui';

import 'package:finance/models/offline_data/storeddata.dart';
import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/services.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static List<YahooQuoteResult> quote;
  List<StoredData> storedData = List<StoredData>();
  List<StoredData> displayedData = List<StoredData>();

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    displayedData =
        displayedData.isNotEmpty ? displayedData : data['storeddata'];
    storedData = data['storeddata'];

    return Scaffold(
        backgroundColor: Colors.grey[250],
        body: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Search"),
                            onChanged: (txt) {
                              txt = txt.toLowerCase();
                              setState(() {
                                displayedData = storedData.where((stock) {
                                  var quoteName = stock.name.toLowerCase();
                                  return quoteName.contains(txt);
                                }).toList();
                              });
                            },
                          ))),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: 90,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      child: GridView.extent(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        maxCrossAxisExtent: 210,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(8),
                        children: List.generate(displayedData.length, (index) {
                          print(displayedData.length);
                          return InkWell(
                            child: Container(
                              color: Colors.grey[400],
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: Main,
                                        children: <Widget>[
                                          Icon(Icons.apps),
                                          Text("${displayedData[index].name}"),
                                          Text(
                                              "${displayedData[index].symbol}, ${displayedData[index].exchange}"),
                                        ],
                                      ),
                                    ))),
                          );
                        }).toList(),
                      )
                      // child: ListView.builder(
                      //   itemBuilder: (context, index) {
                      //     return Card(child: Text(displayedData[index].name));
                      //   },
                      //   itemCount: displayedData.length,
                      //   scrollDirection: Axis.vertical,
                      // ),
                      ),
                )
                // Text(quote[0].displayName)
              ],
            ),
          ),
        ));
  }

  void setData() async {
    await Future.delayed(Duration(seconds: 1), () async {
      quote = await Services.getYahooQuote();

      setState(() {
        //name = quote[0].displayName;
      });
      // print(quote[0].displayName);
    });
  }
}
