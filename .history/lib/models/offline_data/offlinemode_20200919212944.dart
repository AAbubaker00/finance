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
  ..Exchange = dataJson['Exchange'] as String
    ..Symbol = dataJson['Symbol'] as String
    ..Name = dataJson['Name'] as String
    ..LastSale = dataJson['LastSale'] as String
    ..MarketCap = dataJson['MarketCap'] as String
    ..IPOyear = dataJson['IPOyear'] as String
    ..Sector = dataJson['Sector'] as String
    ..industry = dataJson['industry'] as String
    ..Revenue = dataJson['Revenue'] as String
    ..LastUpdate = dataJson['LastUpdate'] as String
    ..Discription = dataJson['Discription'] as String
    ..DividendYield = dataJson['DividendYield'] as String
    ..DividendDate = dataJson['DividendDate'] as String
    ..DividendExDate = dataJson['DividendExDate'] as String
    ..Ceo = dataJson['Ceo'] as String
    ..GrossProfit = dataJson['GrossProfit'] as String
    ..CostOfRevenue = dataJson['CostOfRevenue'] as String
    ..OperatingRevenue = dataJson['OperatingRevenue'] as String
    ..NetIncome = dataJson['NetIncome'] as String
    ..ResearchAndDevelopment = dataJson['ResearchAndDevelopment'] as String
    ..OperatingExpense = dataJson['OperatingExpense'] as String
    ..CurrentAssets = dataJson['CurrentAssets'] as String
    ..TotalAssets = dataJson['TotalAssets'] as String
    ..TotalLiabilities = dataJson['TotalLiabilities'] as String
    ..CurrentCash = dataJson['CurrentCash'] as String
    ..CurrentDebt = dataJson['CurrentDebt'] as String
    ..ShareHolderEquity = dataJson['ShareHolderEquity'] as String
    ..CashChange = dataJson['CashChange'] as String
    ..CashFlow = dataJson['CashFlow'] as String
    ..RevenuePerShare = dataJson['RevenuePerShare'] as String
    ..PERatio = dataJson['PERatio'] as String
    ..ProfitMargin = dataJson['ProfitMargin'] as String
    ..PriceToSales = dataJson['PriceToSales'] as String
    ..PriceToMargin = dataJson['PriceToMargin'] as String
    ..TotalDebt = dataJson['TotalDebt'] as String;

}