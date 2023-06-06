import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dats extends StatefulWidget {
  @override
  _DatsState createState() => _DatsState();
}

class _DatsState extends State<Dats> {
  List<Map<String, dynamic>> usdata = List<Map<String, dynamic>>();

  @override
  Widget build(BuildContext context) {
    final stks = Provider.of<QuerySnapshot>(context);

    // print(stks.docs)

    for (var doc in stks.docs) {
      

      doc.data()[0]['portfolios'];
    }

    print(usdata[0]['portfolios']);
    return Container(child: Text("adad"));
  }
}
