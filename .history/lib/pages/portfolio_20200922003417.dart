import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 10,
                  left: 10,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("£asdadasd"),
                            Text("Portfolio Value")
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: <Widget>[
                                Text("£asdadasd"),
                                Text("Portfolio Value")
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("£asdadasd"),
                                Text("Portfolio Value")
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("£asdadasd"),
                                Text("Portfolio Value")
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: <Widget>[
                                Text("£asdadasd"),
                                Text("Portfolio Value")
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("£asdadasd"),
                                Text("Portfolio Value")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
