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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  child: _allocations(),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  _allocations() {
    return Container(
      height: 500,
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            right: 10,
            left: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
            ),
          ),
          Positioned(
            top: 60,
            right: 10,
            left: 10,
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("£23423423"),
                  SizedBox
                  Text("£21312"),
                  Text("£21312")
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}

// Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[Text("£asdadasd"), Text("Portfolio Value")],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[Text("£asdadasd"), Text("Total Gain"), Text("Daily Gain")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("52 Week Gain"), Text("Daily Gain")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Daily Gain"), Text("Daily Gain")],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Acquired Stock")],
//               ),
//               Column(
//                 children: <Widget>[Text("£asdadasd"), Text("Acquired Shares")],
//               ),
//             ],
//           )
