public class visitController {

    public Sales_Visit__c visit{get;set;}

 

    public visitController() {

        visit = new Sales_Visit__c();

    }

    public PageReference save() {

        insert visit;

        visit = new Sales_Visit__c();

        return null;

    }

}