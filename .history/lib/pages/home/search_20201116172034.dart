import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoaded = false;

  List data = [];
  List displayedData = [];

  List<Map<String, dynamic>> availableExchanges = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadStockList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 5),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.82,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
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
                                    suffixIcon: Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.white,
                                    )),
                                onChanged: (txt) {
                                  txt = txt.toLowerCase();
                                  setState(() {
                                    displayedData = data.where((stock) {
                                      var quoteName =
                                          stock['name'].toLowerCase();
                                      return quoteName.contains(txt);
                                    }).toList();
                                  });
                                },
                              ),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Container(
                    child: ListView.builder(
                        itemCount: availableExchanges.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (availableExchanges[index]['isSelected'] ==
                                    true) {
                                  availableExchanges[index]['isSelected'] =
                                      false;
                                } else {
                                  availableExchanges[index]['isSelected'] =
                                      true;
                                }
                              });
                            },
                            child: Card(
                              color: (availableExchanges[index]['isSelected'] ==
                                      true)
                                  ? Colors.red
                                  : Colors.green,
                              child: Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Center(
                                  child: Text(
                                    availableExchanges[index]['name'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            // ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: displayedData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[900]),
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
                                            Text(
                                                "${displayedData[index]['name']}",  style: TextStyle(color: Colors.white)),
                                            Text(
                                                "${displayedData[index]['symbol']}, ${displayedData[index]['exchange']}",  style: TextStyle(color: Colors.grey[600])),
                                          ],
                                        ),
                                        IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () {},
                                            icon:
                                                Icon(Icons.add_circle_outline, color: Colors.grey[600],))
                                      ],
                                    ))),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _loadFromAssets() async {
    return await rootBundle.loadString("assets/stocks/stocks.json");
  }

  Future loadStockList() async {
    String jsonString = await _loadFromAssets();
    final jsonResponse = jsonDecode(jsonString);

    for (var stock in jsonResponse) {
      if (availableExchanges.isEmpty) {
        availableExchanges.add({
          'name': stock['exchange'],
          'isSelected': false,
        });
      } else {
        var exExist = availableExchanges.firstWhere(
            (ex) => stock['exchange'].toString() == ex['name'],
            orElse: () => null);

        if (exExist == null) {
          availableExchanges.add({
            'name': stock['exchange'],
            'isSelected': false,
          });
        }
      }

      data.add(stock);
    }

    // print(availableExchanges);
    setState(() {
      displayedData = data;
    });
  }
}
