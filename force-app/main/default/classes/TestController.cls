public with sharing class TestController {

public Contact[] opportunities {get;set;}
public Integer oppSize {get;set;}
//xls variables:
public String xmlheader {get;set;}
public String endfile{get;set;}
public TestController() {
xmlheader ='<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?>';
endfile = '</Workbook>';
opportunities = [SELECT Id, Name, Email, Phone FROM Contact LIMIT 10];
oppSize = opportunities.size();
}
}