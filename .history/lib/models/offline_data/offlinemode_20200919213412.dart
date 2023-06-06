class OfflineData{
  String Exchange;
    String Symbol;
    String Name;
    String LastSale;
    String MarketCap;
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
  
      
  OfflineData({
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
  this.netIncome 
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
  this.profitMargin 
  this.priceToSales 
  this.priceToMargin 
  this.totaldebt});

  OfflineData.fromJson(Map<String dynamic> dataJson)
  : Exchange = dataJson['Exchange'],
    Symbol = dataJson['Symbol'],
    Name = dataJson['Name'],
    LastSale = dataJson['LastSale'],
    MarketCap = dataJson['MarketCap'],
    IPOyear = dataJson['IPOyear'],
    Sector = dataJson['Sector'],
    industry = dataJson['industry'],
    Revenue = dataJson['Revenue'],
    LastUpdate = dataJson['LastUpdate'],
    Discription = dataJson['Discription'],
    DividendYield = dataJson['DividendYield'],
    DividendDate = dataJson['DividendDate'],
    DividendExDate = dataJson['DividendExDate'],
    Ceo = dataJson['Ceo'],
    GrossProfit = dataJson['GrossProfit'],
    CostOfRevenue = dataJson['CostOfRevenue'],
    OperatingRevenue = dataJson['OperatingRevenue'],
    NetIncome = dataJson['NetIncome'],
    ResearchAndDevelopment = dataJson['ResearchAndDevelopment'],
    OperatingExpense = dataJson['OperatingExpense'],
    CurrentAssets = dataJson['CurrentAssets'],
    TotalAssets = dataJson['TotalAssets'],
    TotalLiabilities = dataJson['TotalLiabilities'],
    CurrentCash = dataJson['CurrentCash'],
    CurrentDebt = dataJson['CurrentDebt'],
    ShareHolderEquity = dataJson['ShareHolderEquity'],
    CashChange = dataJson['CashChange'],
    CashFlow = dataJson['CashFlow'],
    RevenuePerShare = dataJson['RevenuePerShare'],
    PERatio = dataJson['PERatio'],
    ProfitMargin = dataJson['ProfitMargin'],
    PriceToSales = dataJson['PriceToSales'],
    PriceToMargin = dataJson['PriceToMargin'],
    TotalDebt = dataJson['TotalDebt'],;

}