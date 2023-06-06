import 'package:valuid/models/quote/quote.dart';

class GeneralObject {
  List<QuoteObject> assetList;

  num? value;
  num? turn;
  num? shares;
  num? weight;
  num? invested;
  num? totalRevenue;
  num? netIncome;
  num? totalAssets;
  num? totalLiabilities;
  num? totalCashFromOperatingActivities;
  num? totalCashflowsFromInvestingActivities;
  num? totalCashFromFinancingActivities;
  num? assetLength;

  String? year;
  String? endDate;
  String? name;
  String? symbol;
  String? subSector;

  List<GeneralObject>? subAssets;

  GeneralObject(
      {required this.name,
      this.endDate,
      this.totalCashFromFinancingActivities,
      this.totalCashflowsFromInvestingActivities,
      this.totalCashFromOperatingActivities,
      this.totalAssets,
      this.totalLiabilities,
      this.totalRevenue,
      this.netIncome,
      this.value,
      this.turn,
      this.shares,
      this.symbol,
      this.assetLength,
      this.assetList,
      this.year,
      this.weight,
      this.subAssets,
      this.subSector,
      this.invested});
}
