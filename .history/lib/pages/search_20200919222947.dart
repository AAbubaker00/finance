import 'dart:io';

import 'package:finance/models/offline_data/offlinemode.dart';
import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:finance/sort/load.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/services.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
  List<OfflineData> od = List<OfflineData>();

  void setData(List<Off){

  }
}

class _SearchState extends State<Search> {
  static List<YahooQuoteResult> quote;

  static List<OfflineData> oData;

  String name = "Loading...";

  void idata(List<OfflineData> odJson) {
    oData = odJson;

    // print("oData[0].name");
  }

  @override
  Widget build(BuildContext context) {
    setData();
    LoadData(context);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: new InputDecoration(
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
                        oData = oData.where((stock) {
                          var quoteName = stock.name.toLowerCase();
                          return quoteName.contains(txt);
                        }).toList();
                      });
                    },
                  ))),

          // Text(quote[0].displayName)
        ],
      ),
    );
  }

  void setData() async {
    await Future.delayed(Duration(seconds: 1), () async {
      quote = await Services.getYahooQuote();

      setState(() {
        name = quote[0].displayName;
      });
      // print(quote[0].displayName);
    });
  }

  void finished() async {
    await Future.delayed(Duration(seconds: 2), () async {
      setState(() {
        //oData = LoadData(context).getOfflineDataJson();
      });
    });
  }
}
