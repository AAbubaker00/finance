import 'package:finance/models/yahoo/yahoo_result.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  Stock({String name, String exchange, String symbol}) {}

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  List<YahooQuoteResult> _sQuoteData = List<YahooQuoteResult>();

  String name = "AAPL", exchange, symbol;

  final Color _c = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("$name"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                Container(),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   color: _c,
            //   child: ExpansionTile(
            //     title: Text("Company Information"),
            //     children: <Widget>[],
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: _c,
              child: ExpansionTile(
                title: Text("Ratios"),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trailing PE: "),
                      Text("0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Book Value: "),
                      Text("0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("EPS Forward"),
                      Text("0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Foward PE"),
                      Text("0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price To Book Value"),
                      Text("0")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trailing PE: "),
                      Text("Trailing PE: ")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trailing PE: "),
                      Text("Trailing PE: ")
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: _c,
              child: ExpansionTile(
                title: Text("Dividends"),
                children: <Widget>[
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    ));
  }
}
