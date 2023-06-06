class Offlinedata{
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
  num netincome ;
  num operatingExpense ;
  num operatingrevenue ;
  num pEratio ;
  num priceTomargin ;
  num priceToSales ;
  num profitmargin ;
  num researchAnddevelopment ;
  num revenue ;
  num revenueperShare ;
  num shareHolderEquity ;
  num totalAssets ;
  num totalLiabilities ;
  num totaldebt;
  
      
  Offlinedata({
  this.exchange
  this.symbol
  this.name
  this.lastSale 
  this.marketcap 
  this.ipoyear 
  this.sector 
  this.industry 
  this.revenue 
  this.lastUpdate 
  this.discription 
  this.dividendYield 
  this.dividenddate 
  this.dividendExdate 
  this.ceo 
  this.grossprofit 
  this.costofrevenue 
  this.operatingrevenue 
  this.netincome 
  this.researchAnddevelopment 
  this.operatingExpense 
  this.currentAssets 
  this.totalAssets 
  this.totalLiabilities 
  this.currentcash 
  this.currentdebt 
  this.shareHolderEquity 
  this.cashchange 
  this.cashFlow 
  this.revenueperShare 
  this.pEratio 
  this.profitmargin 
  this.priceToSales 
  this.priceTomargin 
  this.totaldebt});

  Offlinedata.fromJson(map<String dynamic> dataJson)
  : exchange = dataJson['Exchange'],
    symbol = dataJson['Symbol'],
    name = dataJson['Name'],
    lastSale = dataJson['LastSale'],
    marketCap = dataJson['marketCap'],
    iPOyear = dataJson['iPOyear'],
    Sector = dataJson['Sector'],
    industry = dataJson['industry'],
    Revenue = dataJson['Revenue'],
    LastUpdate = dataJson['LastUpdate'],
    discription = dataJson['discription'],
    dividendYield = dataJson['dividendYield'],
    dividenddate = dataJson['dividenddate'],
    dividendExdate = dataJson['dividendExdate'],
    Ceo = dataJson['Ceo'],
    GrossProfit = dataJson['GrossProfit'],
    CostOfRevenue = dataJson['CostOfRevenue'],
    OperatingRevenue = dataJson['OperatingRevenue'],
    Netincome = dataJson['Netincome'],
    ResearchAnddevelopment = dataJson['ResearchAnddevelopment'],
    OperatingExpense = dataJson['OperatingExpense'],
    CurrentAssets = dataJson['CurrentAssets'],
    TotalAssets = dataJson['TotalAssets'],
    TotalLiabilities = dataJson['TotalLiabilities'],
    CurrentCash = dataJson['CurrentCash'],
    Currentdebt = dataJson['Currentdebt'],
    ShareHolderEquity = dataJson['ShareHolderEquity'],
    CashChange = dataJson['CashChange'],
    CashFlow = dataJson['CashFlow'],
    RevenuePerShare = dataJson['RevenuePerShare'],
    PERatio = dataJson['PERatio'],
    Profitmargin = dataJson['Profitmargin'],
    PriceToSales = dataJson['PriceToSales'],
    PriceTomargin = dataJson['PriceTomargin'],
    Totaldebt = dataJson['Totaldebt'],;

}