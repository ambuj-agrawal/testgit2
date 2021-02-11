public class MapMarkerCtrl {
    Public List<CheckIn__c> che{get;set;}
    public MapMarkerCtrl(ApexPages.StandardController controller) {
        che = [select Get_Location__c from CheckIn__c where Location__c =: apexpages.currentpage().getparameters().get('id')];
    }

}