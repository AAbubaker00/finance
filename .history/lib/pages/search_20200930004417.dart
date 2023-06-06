import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:finance/models/offline_data/storeddata.dart';
import 'package:finance/models/yahoo/yahoo_quote_result.dart';
import 'package:finance/services/yahoo_api_provider.dart';

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<YahooQuoteResult> _SelectedStockData;
  List<StoredData> storedData = List<StoredData>();
  List<StoredData> displayedData = List<StoredData>();
  List<StoredData> empytdData = List<StoredData>();

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    displayedData =
        displayedData.isNotEmpty ? displayedData : data['stocklist'];
    storedData = data['stocklist'];

    return Scaffold(
        backgroundColor: Colors.grey[250],
        body: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 5,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 0,
                                  bottom: 10,
                                  top: 15,
                                ),
                                hintText: "Search",
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                )),
                            onChanged: (txt) {
                              txt = txt.toLowerCase();
                              setState(() {
                                if (txt.isEmpty) {
                                  // return empytdData;
                                }
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
                  top: 70,
                  child: Container(
                      child: ListView(
                    scrollDirection: Axis.vertical,
                    children: List.generate(displayedData.length, (index) {
                      return InkWell(
                        onTap: () {
                          alert.Alert(
                            context: context,
                            type: alert.AlertType.error,
                            title: "RFLUTTER ALERT",
                            desc:
                                "Flutter is more awesome with RFlutter Alert.",
                            buttons: [
                              alert.DialogButton(
                                child: Text(
                                  "COOL",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                          getStockData(
                              selectedStock: displayedData[index].symbol,
                              exchange: displayedData[index].exchange);
                        },
                        child: Container(
                            padding: EdgeInsets.only(left: 15),
                            margin: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]),
                                )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("${displayedData[index].name}"),
                                        Text(
                                            "${displayedData[index].symbol}, ${displayedData[index].exchange}"),
                                      ],
                                    ),
                                    IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () {},
                                        icon: Icon(Icons.add_circle_outline))
                                  ],
                                ))),
                      );
                    }).toList(),
                  )),
                ),
                Positioned(
                    bottom: 10, right: 60, left: 60, child: ZNavigationBar())
              ],
            ),
          ),
        ));
  }

  void getStockData({String selectedStock, String exchange}) async {
    try {
      await Future.delayed(Duration(seconds: 2), () async {
        _SelectedStockData = await YahooApiService()
            .getYahooQuote(symbol: selectedStock, exchange: exchange);

        setState(() {
          //name = SelectedStockData[0].displayName;
          print(_SelectedStockData[0].shortName);
        });
        // print(SelectedStockData[0].displayName);
      });
    } on Exception catch (e) {
      // TODO
      print("aa");
    }
  }
}
