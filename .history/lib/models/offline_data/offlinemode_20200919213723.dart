class Offlinedata{
  string ceo ;
  string discription ;
  string dividendExdate ;
  string dividenddate ;
  string exchange;
  string industry ;
  string lastsale ;
  string lastUpdate ;
  string name;
  string sector ;
  string symbol;
  
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
  num priceTosales ;
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
  this.priceTosales 
  this.priceTomargin 
  this.totaldebt});

  Offlinedata.fromJson(map<string dynamic> dataJson)
  : exchange = dataJson['Exchange'],
    symbol = dataJson['symbol'],
    name = dataJson['Name'],
    lastsale = dataJson['Lastsale'],
    marketCap = dataJson['marketCap'],
    iPOyear = dataJson['iPOyear'],
    sector = dataJson['sector'],
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
    shareHolderEquity = dataJson['shareHolderEquity'],
    CashChange = dataJson['CashChange'],
    CashFlow = dataJson['CashFlow'],
    RevenuePershare = dataJson['RevenuePershare'],
    PERatio = dataJson['PERatio'],
    Profitmargin = dataJson['Profitmargin'],
    PriceTosales = dataJson['PriceTosales'],
    PriceTomargin = dataJson['PriceTomargin'],
    Totaldebt = dataJson['Totaldebt'],;

}