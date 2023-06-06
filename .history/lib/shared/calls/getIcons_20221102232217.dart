import 'package:Valuid/services/eod/eod.dart';

import 'package:Valuid/services/clearbit/clearbit.dart';
import 'package:Valuid/shared/printFunctions/custom_Print_Functions.dart';

class GetIcons {

  getIcons(List assets) async {
    try {
      for (var asset in assets) {
        // if (asset['logo'] == null) {
        asset['logo'] = await EodHistoricalData().getLogo(asset['symbol'], asset['exchange']);
        // }
      }

      // if (isIconsLoaded == false) {
      for (var asset in assets) {
        if (asset['logo'] == null) {
          if (asset['marketData']['assets'] == null || asset['marketData']['assets']['website'] == null) {
            asset['logo'] = null;
          } else {
            print('-------------------------------------');

            String src = asset['marketData']['assets']['website'];

            src = src.replaceAll(RegExp('https://www.'), '');
            asset['logoSrc'] = src;
            asset['logo'] = (await Clearbit().getLogo(src));

            // ui.Image image = await _getImage();

            // Future.sync((completer.future) {})

            //.addListener((ImageInfo info, bool _) => completer.complete(info.image));

            if (asset['logo'] == null) {
              asset['logo'] = null;
            } else {
              asset['logo'] = asset['logo']['logo'];
              // asset['imageWidth'] = image.width;
            }
          }
        }

        // asset['logo'] = await Clearbit().getLogo(name)
      }

      // if (this.mounted) {
      //   set

      return assets;
      // }
    } catch (e) {
      print('errr');
      PrintFunctions().printStartEndLine(e);
    }
  }

  getEodIcon(Map asset, {String symbol, String exchange}) async {
    try {
      // if (asset['logo'] == null) {
      //   if (asset['assets'] == null || asset['assets']['website'] == null) {
      //     asset['logo'] = null;
      //   } else {
      //     String src = asset['assets']['website'];

      //     src = src.replaceAll(RegExp('http://www.'), '');
      //     asset['logo'] = (await Clearbit().getLogo(src));

      //     if (asset['logo'] == null) {
      //       asset['logo'] = null;
      //     } else {
      //       asset['logo'] = asset['logo']['logo'];
      //     }
      //   }

      //   // asset['logo'] = await Clearbit().getLogo(name)
      // }
      // for (var asset in filterAssets) {
      //   // if (asset['logo'] == null) {
      asset['logo'] = await EodHistoricalData().getLogo(symbol, exchange);
      //   // }
      // }

      // if (this.mounted) {
      //   set

      // print(asset['logo']);

      return asset;
      // }
    } catch (e) {
      PrintFunctions().printStartEndLine(e);

      return asset;
    }
  }

  getClearBitIcon(Map asset, {String symbol, String exchange}) async {
    try {
      if (asset['logo'] == null) {
        if (asset['assets'] == null || asset['assets']['website'] == null) {
          asset['logo'] = null;
        } else {
          String src = asset['assets']['website'];

          print(asset['assets']['website']);

          src = src.replaceAll(RegExp('http://www.'), '');
          asset['logo'] = (await Clearbit().getLogo(src));

          if (asset['logo'] == null) {
            asset['logo'] = null;
          } else {
            asset['logo'] = asset['logo']['logo'];
          }
        }

        // asset['logo'] = await Clearbit().getLogo(name)
      }

      // if (this.mounted) {
      //   set

      // print(asset['logo']);

      return asset;
      // }
    } catch (e) {
      PrintFunctions().printStartEndLine(e);

      return asset;
    }
  }
}
