import 'dart:developer';

import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:flutter/material.dart';
import 'package:finance/services/services.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    Services.getYahooQuote();


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
                        hintText: Service,
                    onChanged: (txt) {
                      txt = txt.toLowerCase();
                      setState(() {});
                    },
                  ))),
        ],
      ),
    );
  }
}
