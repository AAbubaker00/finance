import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dats extends StatefulWidget {
  @override
  _DatsState createState() => _DatsState();
}

class _DatsState extends State<Dats> {
  List<Map<String, dynamic>> usdata;

  @override
  Widget build(BuildContext context) {
    final stks = Provider.of<QuerySnapshot>(context);

    // print(stks.docs)

    for (var doc in stks.docs) {
      usdata.add(doc.to);
    }
    return Container(child: Text("adad"));
  }
}
