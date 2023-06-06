import 'package:valuid/models/quote/quote.dart';

class GeneralObject {
  List<QuoteObject> assetList;

  num value;
  num turn;
  num shares;
  num weight;
  num invested;
  num totalRevenue;
  num netIncome;
  num totalAssets;
  num totalLiabilities;
  num totalCashFromOperatingActivities;
  num totalCashflowsFromInvestingActivities;
  num totalCashFromFinancingActivities;

  int assetLength;

  String year;
  String endDate;
  String name;
  String symbol;
  String subSector;

  List<GeneralObject> subAssets;

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
      required this.assetLength,
      required this.assetList,
      required this.year,
      required this.weight,
      required this.subAssets,
      required this.subSector,
      required this.invested});
}
