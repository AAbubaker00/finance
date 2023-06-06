class OfflineData{
  String ceo ;
  String discription ;
  String dividendExdate ;
  String dividenddate ;
  String exchange;
  String industry ;
  String lastSale ;
  String lastUpdate ;
  String name;
  String sector ;
  String symbol;
  
  num cashFlow ;
  num cashchange ;
  num costofrevenue ;
  num currentAssets ;
  num currentcash ;
  num currentdebt ;
  num dividendYield ;
  num grossprofit ;
  num ipoyear ;
  num marketcap ;
  num netIncome ;
  num operatingExpense ;
  num operatingrevenue ;
  num pEratio ;
  num priceToMargin ;
  num priceToSales ;
  num profitMargin ;
  num researchAnddevelopment ;
  num revenue ;
  num revenueperShare ;
  num shareHolderEquity ;
  num totalAssets ;
  num totalLiabilities ;
  num totaldebt;
  
      
  OfflineData({
  this.exchange,
  this.symbol,
  this.name,
  this.lastSale ,
  this.marketcap ,
  this.ipoyear ,
  this.sector ,
  this.industry ,
  this.revenue ,
  this.lastUpdate ,
  this.discription ,
  this.dividendYield ,
  this.dividenddate ,
  this.dividendExdate ,
  this.ceo ,
  this.grossprofit ,
  this.costofrevenue ,
  this.operatingrevenue ,
  this.netIncome ,
  this.researchAnddevelopment ,
  this.operatingExpense ,
  this.currentAssets ,
  this.totalAssets ,
  this.totalLiabilities ,
  this.currentcash ,
  this.currentdebt ,
  this.shareHolderEquity ,
  this.cashchange ,
  this.cashFlow ,
  this.revenueperShare ,
  this.pEratio ,
  this.profitMargin ,
  this.priceToSales ,
  this.priceToMargin ,
  this.totaldebt});

  OfflineData.fromJson(Map<String, dynamic> dataJson):
  ..Exchange = json['Exchange'] as String
    ..Symbol = json['Symbol'] as String
    ..Name = json['Name'] as String
    ..LastSale = json['LastSale'] as String
    ..MarketCap = json['MarketCap'] as String
    ..IPOyear = json['IPOyear'] as String
    ..Sector = json['Sector'] as String
    ..industry = json['industry'] as String
    ..Revenue = json['Revenue'] as String
    ..LastUpdate = json['LastUpdate'] as String
    ..Discription = json['Discription'] as String
    ..DividendYield = json['DividendYield'] as String
    ..DividendDate = json['DividendDate'] as String
    ..DividendExDate = json['DividendExDate'] as String
    ..Ceo = json['Ceo'] as String
    ..GrossProfit = json['GrossProfit'] as String
    ..CostOfRevenue = json['CostOfRevenue'] as String
    ..OperatingRevenue = json['OperatingRevenue'] as String
    ..NetIncome = json['NetIncome'] as String
    ..ResearchAndDevelopment = json['ResearchAndDevelopment'] as String
    ..OperatingExpense = json['OperatingExpense'] as String
    ..CurrentAssets = json['CurrentAssets'] as String
    ..TotalAssets = json['TotalAssets'] as String
    ..TotalLiabilities = json['TotalLiabilities'] as String
    ..CurrentCash = json['CurrentCash'] as String
    ..CurrentDebt = json['CurrentDebt'] as String
    ..ShareHolderEquity = json['ShareHolderEquity'] as String
    ..CashChange = json['CashChange'] as String
    ..CashFlow = json['CashFlow'] as String
    ..RevenuePerShare = json['RevenuePerShare'] as String
    ..PERatio = json['PERatio'] as String
    ..ProfitMargin = json['ProfitMargin'] as String
    ..PriceToSales = json['PriceToSales'] as String
    ..PriceToMargin = json['PriceToMargin'] as String
    ..TotalDebt = json['TotalDebt'] as String;

}