class OfflineData{
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
  num totalliabilities ;
  num totaldebt;
  
      
  OfflineData({
  this.exchange,
  this.symbol,
  this.name,
  this.lastsale, 
  this.marketcap, 
  this.ipoyear,
  this.sector,
  this.industry, 
  this.revenue, 
  this.lastUpdate, 
  this.discription, 
  this.dividendYield, 
  this.dividenddate, 
  this.dividendExdate, 
  this.ceo, 
  this.grossprofit, 
  this.costofrevenue, 
  this.operatingrevenue, 
  this.netincome, 
  this.researchAnddevelopment, 
  this.operatingExpense, 
  this.currentAssets, 
  this.totalAssets, 
  this.totalliabilities, 
  this.currentcash, 
  this.currentdebt, 
  this.shareHolderEquity, 
  this.cashchange, 
  this.cashFlow, 
  this.revenuepershare, 
  this.pEratio, 
  this.profitmargin, 
  this.pricetosales, 
  this.pricetomargin, 
  this.totaldebt
  });

  OfflineData.fromJson(Map<String, dynamic> dataJson)
  : exchange = dataJson['Exchange'],
    symbol = dataJson['symbol'],
    name = dataJson['Name'],
    lastsale = dataJson['lastsale'],
    marketcap = dataJson['marketcap'],
    ipoyear = dataJson['ipoyear'],
    sector = dataJson['sector'],
    industry = dataJson['industry'],
    revenue = dataJson['revenue'],
    lastUpdate = dataJson['lastUpdate'],
    discription = dataJson['discription'],
    dividendYield = dataJson['dividendYield'],
    dividenddate = dataJson['dividenddate'],
    dividendExdate = dataJson['dividendExdate'],
    ceo = dataJson['ceo'],
    grossprofit = dataJson['grossprofit'],
    costofrevenue = dataJson['costofrevenue'],
    operatingrevenue = dataJson['operatingrevenue'],
    netincome = dataJson['Netincome'],
    researchAnddevelopment = dataJson['researchAnddevelopment'],
    operatingExpense = dataJson['operatingExpense'],
    currentAssets = dataJson['currentAssets'],
    totalAssets = dataJson['totalAssets'],
    totalliabilities = dataJson['totalliabilities'],
    currentcash = dataJson['currentcash'],
    currentdebt = dataJson['currentdebt'],
    shareHolderEquity = dataJson['shareHolderEquity'],
    cashchange = dataJson['cashchange'],
    cashFlow = dataJson['cashFlow'],
    revenuepershare = dataJson['revenuepershare'],
    pEratio = dataJson['pEratio'],
    profitmargin = dataJson['profitmargin'],
    pricetosales = dataJson['pricetosales'],
    pricetomargin = dataJson['pricetomargin'],
    totaldebt = dataJson['totaldebt'];}