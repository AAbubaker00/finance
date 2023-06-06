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
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              TextField(
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
                              ),
                              Icon
                            ],
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
                      print(displayedData.length);
                      return InkWell(
                        onTap: () {
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
                                        onPressed: () {},
                                        icon: Icon(Icons.add_circle_outline))
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
