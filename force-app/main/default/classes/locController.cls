public class locController {
    public Double valueLong { get; set; }
    public Double valueLat { get; set; }
    Public CheckIn__c check{get;set;}
    Public List<CheckIn__c> checkList{get;set;}

    Public locController(){
        check = new CheckIn__c();
        checkList = new List<CheckIn__c>();
    
    }
    public PageReference iFoundYou() {
    
        return null;
    }
    public PageReference Save(){
        CheckIn__c cc = new CheckIn__c();
        cc.name = check.name;
        cc.Get_Location__Latitude__s= valueLat;
        cc.Get_Location__Longitude__s= valueLong;
        cc.Location__c = apexpages.currentpage().getparameters().get('id');
        checkList.add(cc);
        insert checkList;
        PageReference pr = new PageReference('https://ambuj-dev-ed.my.salesforce.com/' +cc.Id);
        return pr;
    }


}