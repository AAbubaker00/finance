import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  AdState({
    required this.initalization
    });

  final Future<InitializationStatus> initalization;
}
