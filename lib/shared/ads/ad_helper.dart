import 'dart:io';

class AdHelper {
  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3200743683296355/5401187336';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3200743683296355/9912060836';
    }
    //  else if (Platform.isIOS) {
    //   return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    // }
    else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get appLoadAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3200743683296355/5401187336';
    } else {
      return '';
    }
  }

  static String get fullPageAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3200743683296355/5919505191';
    } else {}
      return '';

  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return '<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return '<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }



  
}


