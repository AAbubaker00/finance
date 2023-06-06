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
      : address1 = assetsJson['address1'],
        city = assetsJson['city'],
        zip = assetsJson['zip'],
        country = assetsJson['country'],
        phone = assetsJson['phone'],
        website = assetsJson['website'],
        industry = assetsJson['industry'],
        sector = assetsJson['sector'],
        longBusinessSummary = assetsJson['longBusinessSummary'],
        fullTimeEmployees = assetsJson['fullTimeEmployees'],
        companyOfficers = assetsJson['companyOfficers'],
        auditRisk = assetsJson['auditRisk'],
        boardRisk = assetsJson['boardRisk'],
        compensationRisk = assetsJson['compensationRisk'],
        shareHolderRightsRisk = assetsJson['shareHolderRightsRisk'],
        overallRisk = assetsJson['overallRisk'],
        governanceEpochDate = assetsJson['governanceEpochDate'],
        compensationAsOfEpochDate = assetsJson['compensationAsOfEpochDate'],
        maxAge = assetsJson['maxAge'];
}