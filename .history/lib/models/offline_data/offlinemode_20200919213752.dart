class Offlinedata{
  String ceo ;
  String discription ;
  String dividendExdate ;
  String dividenddate ;
  String exchange;
  String industry ;
  String lastsale ;
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
  num pricetomargin ;
  num pricetosales ;
  num profitmargin ;
  num researchAnddevelopment ;
  num revenue ;
  num revenuepershare ;
  num shareHolderEquity ;
  num totalAssets ;
  num totalLiabilities ;
  num totaldebt;
  
      
  Offlinedata({
  this.exchange
  this.symbol
  this.name
  this.lastsale 
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
  this.revenuepershare 
  this.pEratio 
  this.profitmargin 
  this.pricetosales 
  this.pricetomargin 
  this.totaldebt});

  Offlinedata.fromJson(map<String dynamic> dataJson)
  : exchange = dataJson['Exchange'],
    symbol = dataJson['symbol'],
    name = dataJson['Name'],
    lastsale = dataJson['Lastsale'],
    marketcap = dataJson['marketcap'],
    iPOyear = dataJson['iPOyear'],
    sector = dataJson['sector'],
    industry = dataJson['industry'],
    Revenue = dataJson['Revenue'],
    LastUpdate = dataJson['LastUpdate'],
    discription = dataJson['discription'],
    dividendYield = dataJson['dividendYield'],
    dividenddate = dataJson['dividenddate'],
    dividendExdate = dataJson['dividendExdate'],
    ceo = dataJson['ceo'],
    GrossProfit = dataJson['GrossProfit'],
    costOfRevenue = dataJson['costOfRevenue'],
    OperatingRevenue = dataJson['OperatingRevenue'],
    Netincome = dataJson['Netincome'],
    ResearchAnddevelopment = dataJson['ResearchAnddevelopment'],
    OperatingExpense = dataJson['OperatingExpense'],
    currentAssets = dataJson['currentAssets'],
    totalAssets = dataJson['totalAssets'],
    totalLiabilities = dataJson['totalLiabilities'],
    currentcash = dataJson['currentcash'],
    currentdebt = dataJson['currentdebt'],
    shareHolderEquity = dataJson['shareHolderEquity'],
    cashchange = dataJson['cashchange'],
    cashFlow = dataJson['cashFlow'],
    RevenuePershare = dataJson['RevenuePershare'],
    PERatio = dataJson['PERatio'],
    Profitmargin = dataJson['Profitmargin'],
    Pricetosales = dataJson['Pricetosales'],
    Pricetomargin = dataJson['Pricetomargin'],
    totaldebt = dataJson['totaldebt'],;

}