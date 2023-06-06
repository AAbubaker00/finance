import 'package:valuid/models/account/account.dart';
import 'package:valuid/models/portfolio/portfolio.dart';
import 'package:valuid/pages/community/postCard.dart';
import 'package:valuid/services/forex/forex_conversion.dart';
import 'package:valuid/shared/dataObject/data_object.dart';
import 'package:valuid/shared/printFunctions/custom_Print_Functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valuid/services/Network/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

class DatabaseService {
  final _auth = FirebaseAuth.instance;
  final String uid;
  User user;

  DatabaseService({this.uid}) {
    user = _auth.currentUser;
  }

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference conversionRates = FirebaseFirestore.instance.collection('rates');
  final CollectionReference feedCollection = FirebaseFirestore.instance.collection('feed');

  //                                                                        //

  //! Updating User data to cloud
  Future updateUserData({@required dynamic data}) async {
    try {
      if (data.runtimeType == DataObject) {
        return await userCollection.doc(user.uid).set({
          'portfolios': PortfolioObject().listPortfolioToMap(data.portfolios),
          'account': AccountObject().accountObjectToMap(data.account),
        });
      } else {
        return await userCollection.doc(user.uid).set(data);
      }
    } catch (e) {
      PrintFunctions().printError(e.toString());
    }
  }

  getConnection() async {
    return await Network().getConnectionStatus();
  }

  //!get Rates
  Future<Map> getRates() async {
    try {
      Map storedRates = await conversionRates
          .doc('rates')
          .snapshots()
          .first
          .then((value) => {'lastUpdate': value['lastUpdate'], 'rates': value['values']});

      String lastUpdate = storedRates['lastUpdate'];
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      Duration durationSinceLasteUpdate = DateTime.parse(currentDate).difference(DateTime.parse(lastUpdate));

      if (durationSinceLasteUpdate.inDays <= 7) {
        return storedRates['rates'];
      } else {
        Map rates = await ForexConversion().getLatestFxRates();

        await conversionRates
            .doc('rates')
            .set({'lastUpdate': DateFormat('yyyy-MM-dd').format(DateTime.now()), 'values': rates});

        return rates;
      }
    } catch (e) {
      PrintFunctions().printError(e);

      return {};
    }
  }

  //! get data
  Stream<DocumentSnapshot<Object?>>? get userPortfolioData {
    try {
      return userCollection.doc(uid).snapshots();
    } catch (e) {
      PrintFunctions().printError(e);
      return null;
    }
  }

  //                                                                        //
  Future<void>? deleteuser() {
    try {
      return userCollection.doc(uid).delete();
    } catch (e) {
      PrintFunctions().printError(e);

      return null;
    }
  }

  //                                                                        //

  Stream<QuerySnapshot> get feed {
    try {
      // feedCollection.where((DocumentSnapshot snapshot) => snapshot.id)
      return feedCollection.snapshots();
    } catch (e) {
      PrintFunctions().printError('feed: error: $e');

      return null;
    }
  }

  updateFeed({PostObject post, String feedUid, bool isCommentUpdate = false, Map originalComment}) {
    try {
      if (isCommentUpdate) {
        if (originalComment['reports'].length >= 20) {
          post.comments.remove(originalComment);
        }
      } else {
        if (post.reports.length >= 20) {
          feedCollection.doc(feedUid).delete();

          feedUid = '';
        }
      }

      if (feedUid != '') {
        feedCollection.doc(feedUid).set(PostObject().postObjectToMap(post));
      }
    } catch (e) {
      PrintFunctions().printError(e);
    }
  }
}
