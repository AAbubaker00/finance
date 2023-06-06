import 'package:finance/custome_Widgets/_stock.dart';
import 'package:finance/sections/charts.dart';
import 'package:flutter/material.dart';
import 'package:finance/custome_Widgets/_cusome_expansion_tile.dart' as custome;
import 'package:flip_card/flip_card.dart' as Flip;
import 'dart:ui' as wi;
import 'dart:math' as math;


import 'dart:html';
import 'package:modern_charts/modern_charts.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List stocks = [
    "apple",
    "apple",
    "apple",
    "apple",
  ];

  GlobalKey<Flip.FlipCardState> flipCardKey = GlobalKey<Flip.FlipCardState>();
  double _fromTop;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    double aspectRatio =
        (window.physicalSize.height / window.physicalSize.width);

    if (aspectRatio >= 1.7) {
      _fromTop = 240;
    } else if (aspectRatio <= 1.6) {
      _fromTop = 630;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            
            //Black Container Section
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                toolbarHeight: 40,
                backgroundColor: Colors.black,
                title: Text("asdasd"),
              ),
            ),

            // Summary Section

            Positioned(
              top: 35,
              left: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).copyWith().size.height * 0.2,
                width: MediaQuery.of(context).copyWith().size.width * 0.9,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("Summary  ")],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: [Text("5626"), Text("Total Shares")],
                          ),
                          Column(
                            children: [Text("5626"), Text("Total Invested")],
                          ),
                          Column(
                            children: [Text("5626"), Text("Total Stocks")],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text("£51,626,262"),
                              Text("Total Investment Capital")
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            //User Stocks Section

            Positioned(
              bottom: 270,
              top: _fromTop,
              right: 10,
              left: 10,
              child: InkWell(
                child: Container(
                    child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: stocks.map((s) {
                      return MiniStockWindow("symbol", "exchange");
                    }).toList(),
                  ),
                )),
              ),
            ),

            //Graphs Section
            Positioned(
              top: _fromTop+320,
              bottom: 10,
              right: 10,
              left: 10, 
              child: Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Flip.FlipCard(
                  front:Charts,
                  back: Text("loool"),
                ),
              ))
            )
          ],
        ),
      ),
    );
  }

  
Element createContainer() {
  var e = DivElement()
    ..style.height = '400px'
//    ..style.width = '800px'
    ..style.maxWidth = '100%'
    ..style.marginBottom = '50px';
  document.body.append(e);
  return e;
}

void createRadarChart() {
  var table = DataTable([
    ['Categories', 'Series 1'],
    ['Monday', 8],
    ['Tuesday', 17],
    ['Wednesday', 7],
    ['Thursday', 16],
    ['Friday', 12],
    ['Saturday', 5],
    ['Sunday', 14]
  ]);

  var changeDataButton = ButtonElement()..text = 'Change data';
  document.body.append(changeDataButton);

  var insertRemoveColumnButton = ButtonElement()
    ..text = 'Insert/remove data column';
  document.body.append(insertRemoveColumnButton);

  var insertRemoveRowButton = ButtonElement()..text = 'Insert/remove data row';
  document.body.append(insertRemoveRowButton);

  var container = createContainer();

  var options = {
    'animation': {
      'onEnd': () {
        changeDataButton.disabled = false;
        insertRemoveColumnButton.disabled = false;
        insertRemoveRowButton.disabled = false;
      }
    },
    'series': {
      'labels': {'enabled': true}
    },
    'title': {'text': 'Radar Chart Demo'},
    'tooltip': {'valueFormatter': (value) => '$value units'}
  };

  var chart = RadarChart(container);
  chart.draw(table, options);

  void disableAllButtons() {
    changeDataButton.disabled = true;
    insertRemoveColumnButton.disabled = true;
    insertRemoveRowButton.disabled = true;
  }

  changeDataButton.onClick.listen((_) {
    disableAllButtons();
    for (var row in table.rows) {
      for (var i = 1; i < table.columns.length; i++) {
        row[i] = rand(5, 20);
      }
    }
    chart.update();
  });

  var insertColumn = true;
  insertRemoveColumnButton.onClick.listen((_) {
    disableAllButtons();
    if (insertColumn) {
      table.columns.insert(2, DataColumn('New series', num));
      for (var row in table.rows) {
        row[2] = rand(5, 20);
      }
    } else {
      table.columns.removeAt(2);
    }
    insertColumn = !insertColumn;
    chart.update();
  });

  var insertRow = true;
  insertRemoveRowButton.onClick.listen((_) {
    disableAllButtons();
    if (insertRow) {
      var values = <Object>['New'];
      for (var i = 1; i < table.columns.length; i++) {
        values.add(rand(5, 20));
      }
      table.rows.insert(2, values);
    } else {
      table.rows.removeAt(2);
    }
    insertRow = !insertRow;
    chart.update();
  });
}

}
