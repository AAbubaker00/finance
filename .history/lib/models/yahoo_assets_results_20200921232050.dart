import 'package:json_annotation/json_annotation.dart';

class Yahoo_assets_results {



    Yahoo_assets_results({
      
    this.address1;
    this.city;
    this.zip;
    this.country;
    this.phone;
    this.website;
    this.industry;
    this.sector;
    this.longBusinessSummary;
    num fullTimeEmployees;
    List companyOfficers;
    num auditRisk;
    num boardRisk;
    num compensationRisk;
    num shareHolderRightsRisk;
    num overallRisk;
    num governanceEpochDate;
    num compensationAsOfEpochDate;
    num maxAge;

    });

    
    Yahoo_assets_results.fromJson()
