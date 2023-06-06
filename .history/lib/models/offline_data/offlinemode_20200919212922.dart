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

  OfflineData.fromJson(Map<String, dynamic> )

}