import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:finance/services/services.dart';
import 'package:finance/models/stocks.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Stocks stock;
  String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = 'loading users';
    stock = Stocks();
    Services.getQuote().then((stockFromServer) {
      setState(() {
        stock = stockFromServer;
        title = "Working";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      setState(() {});
                    },
                  ))),
          Expanded(
              child: ListView.builder(
            itemCount: stock.StockName == null ? 0 : stock.StockName.length,
            itemBuilder: (BuildContext context, int index) {
              return row(index);
            },
          ))
        ],
      ),
    );
  }

  Widget row(int index) {
    return Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.s,
          )
    ));
  }
}
