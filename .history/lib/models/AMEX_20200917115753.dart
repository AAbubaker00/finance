import 'package:json_annotation/json_annotation.dart';
import "47.36M.dart";
part 'AMEX.g.dart';

@JsonSerializable()
class AMEX {
    AMEX();

    String Exchange;
    String Symbol;
    String Name;
    String LastSale;
    47.36M MarketCap;
    String IPOyear;
    String Sector;
    String industry;
    String Revenue;
    String LastUpdate;
    String Discription;
    String DividendYield;
    String DividendDate;
    String DividendExDate;
    String Ceo;
    String GrossProfit;
    String CostOfRevenue;
    String OperatingRevenue;
    String NetIncome;
    String ResearchAndDevelopment;
    String OperatingExpense;
    String CurrentAssets;
    String TotalAssets;
    String TotalLiabilities;
    String CurrentCash;
    String CurrentDebt;
    String ShareHolderEquity;
    String CashChange;
    String CashFlow;
    String RevenuePerShare;
    String PERatio;
    String ProfitMargin;
    String PriceToSales;
    String PriceToMargin;
    String TotalDebt;
    
    factory AMEX.fromJson(Map<String,dynamic> json) => _$AMEXFromJson(json);
    Map<String, dynamic> toJson() => _$AMEXToJson(this);
}
