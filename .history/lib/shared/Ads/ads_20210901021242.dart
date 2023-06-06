import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  AdState({
    this.initalization
    });

  Future<InitializationStatus> initalization;


  String get bannerAdUnitId{
      if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
  }
}
