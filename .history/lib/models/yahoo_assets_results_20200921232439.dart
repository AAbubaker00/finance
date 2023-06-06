import 'package:json_annotation/json_annotation.dart';

class Yahoo_Assets_Results {
  String address1;
  String city;
  String zip;
  String country;
  String phone;
  String website;
  String industry;
  String sector;
  String longBusinessSummary;
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

  Yahoo_Assets_Results({
    this.address1,
    this.city,
    this.zip,
    this.country,
    this.phone,
    this.website,
    this.industry,
    this.sector,
    this.longBusinessSummary,
    this.fullTimeEmployees,
    this.companyOfficers,
    this.auditRisk,
    this.boardRisk,
    this.compensationRisk,
    this.shareHolderRightsRisk,
    this.overallRisk,
    this.governanceEpochDate,
    this.compensationAsOfEpochDate,
    this.maxAge,
  });


  Yahoo_Assets_Results.fromJson(Map<String, dynamic> assetsJson)
  : address1 = json['address1'],
    city = json['city'],
    zip = json['zip'],
    country = json['country'],
    phone = json['phone'],
    website = json['website'],
    industry = json['industry'],
    sector = json['sector'],
    longBusinessSummary = json['longBusinessSummary'],
    fullTimeEmployees = json['fullTimeEmployees'],
    companyOfficers = json['companyOfficers'] as
    auditRisk = json['auditRisk'],
    boardRisk = json['boardRisk'],
    compensationRisk = json['compensationRisk'],
    shareHolderRightsRisk = json['shareHolderRightsRisk'],
    overallRisk = json['overallRisk'],
    governanceEpochDate = json['governanceEpochDate'],
    compensationAsOfEpochDate = json['compensationAsOfEpochDate'],
    maxAge = json['maxAge'],;
}
