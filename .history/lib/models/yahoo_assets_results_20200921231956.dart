import 'package:json_annotation/json_annotation.dart';

class Yahoo_assets_results {
    Yahoo_assets_results();

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

    Yahoo_assets_results({this.address1, this.cit});

    
    Yahoo_assets_results.fromJson()
