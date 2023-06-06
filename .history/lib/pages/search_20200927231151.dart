import 'package:finance/custome_Widgets/_navigationbar.dart';
import 'package:finance/models/offline_data/storeddata.dart';
import 'package:finance/models/yahoo/yahoo_quote_result.dart';
import 'package:finance/network/yahoo_api_provider.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<YahooQuoteResult> _SelectedStockData;
  List<StoredData> storedData = List<StoredData>();
  List<StoredData> displayedData = List<StoredData>();

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
                  top: 60,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(8),
                        children: List.generate(displayedData.length, (index) {
                          print(displayedData.length);
                          return InkWell(
                            onTap: () {
                              getStockData(
                                  selectedStock: displayedData[index].symbol,
                                  exchange: displayedData[index].exchange);
                            },
                            child: Container(
                                color: Colors.grey[400],
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.apps),
                                        Text("${displayedData[index].name}"),
                                        Text(
                                            "${displayedData[index].symbol}, ${displayedData[index].exchange}"),
                                      ],
                                    ))),
                          );
                        }).toList(),
                      )),
                ),
                Positioned(
                    bottom: 10, right: 120, left: 120, child: ZNavigationBar())
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
