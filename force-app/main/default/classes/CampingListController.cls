public with sharing class CampingListController{
    @AuraEnabled
    public static List<Camping_Item__c> getItems(){
        String[] fieldsToCheck = new String[]{
            'Id', 'Name', 'Packed__c', 'Price__c', 'Quantity__c', 'CreatedDate'
        };
        Map<String, Schema.SObjectField> fieldDescribeTokens = Schema.SObjectType.Camping_Item__c.fields.getMap();
        for(String field : fieldsToCheck){
            if(!fieldDescribeTokens.get(field).getDescribe().isAccessible()){
                throw new System.NoAccessException();
                return null;
            }
        }
        List<Camping_Item__c> vCampingItems = [
            SELECT Id, Name, Packed__c, Price__c, Quantity__c, CreatedDate
            FROM Camping_Item__c
        ];
        return vCampingItems;
    }

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c pCampingItem){
        upsert pCampingItem;
        return pCampingItem;
    }

}