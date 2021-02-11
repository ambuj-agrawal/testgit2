trigger UpdateCustomeObject_Trigger on Lead (before update) {
//This trigger will associate a Custom Object record with the contact and opportunity associated to the 
//lead after it has been converted.
//The Custom Object is associated to an opportunity only if an opportunity record exist on the Lead.
    for (Integer i = 0; i < Trigger.new.size(); i++){
        if (Trigger.new[i].IsConverted == true && Trigger.old[i].isConverted == false){
            Set<Id> leadIds = new Set<Id>();
            for (Lead lead : Trigger.new) 
                leadIds.add(lead.Id);
            
            Map<Id, CustomObject__c> entries = new Map<Id, CustomObject__c>([select Contact__c, Opportunity__c, Account__c, Lead__c from CustomObject__c where lead__c in :leadIds]);        
            if(!Trigger.new.isEmpty()) {
                for (Lead lead : Trigger.new)  {
                    for (CustomObject__c CustomObject : entries.values()) {
                        if (CustomObject.Lead__c == lead.Id) {
                            CustomObject.contact__c = lead.ConvertedContactId;
                            CustomObject.opportunity__c = lead.ConvertedOpportunityId;
                            CustomObject.account__c = lead.ConvertedAccountId;
                            update CustomObject;
                            break;
                        }
                    }
                }
            }
        }
    }

}