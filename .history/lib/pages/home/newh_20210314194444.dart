import 'package:flutter/material.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  
  _fileCheck(QuerySnapshot querySnapshot, BuildContext context) async {
    var states = await OfflineDataset().readStates();
    var ofData = await OfflineDataset().readPortfolios();

    if (states == '') {
      OfflineDataset().writeStates(json.encode(prStates));
    } else {
      var statesJson = json.decode(states);
      prStates = statesJson;
    }

    if (ofData == '') {
      if (querySnapshot == null) {
        return MainLoading();
      } else {
        Initialize(querySnapshot: querySnapshot, context: context, isDataChanged: false, states: prStates);
      }
    } else {
      var odJson = json.decode(ofData);
      // odJson.forEach((key, value) => print(key));

      // Navigator.pushReplacementNamed(context, '/home', arguments: {
      //   'initalData': odJson['initalData'],
      //   'portfolios': odJson['portfolios'],
      //   'userDetails': odJson['userDetails'],
      //   'offlineData': true,
      //   'states': prStates,
      //   'rates': odJson['rates']
      // });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}