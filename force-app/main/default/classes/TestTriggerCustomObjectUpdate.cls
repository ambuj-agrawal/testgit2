@isTest
//This is a test case for a situation where a lead will be converted.  The developer must explicitly call the convert lead
//method to simulate the user action.

private class TestTriggerCustomObjectUpdate {
        static testMethod void TestReferralUpdate() {
        // Insert the Lead
        List<Lead> leads = new List<Lead>();
        Lead leadt = new Lead (FirstName ='fname', LastName ='test', Company ='myCompany');
        insert leadt;
        // Insert the custom object Record 
        CustomObject__c customobject = new CustomObject__c (Lead__c = leadt.Id);
        insert customobject;		
		
		//Convert the Lead
		Database.LeadConvert lc = new database.LeadConvert();
		lc.setLeadId(leadt.Id);
		LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
		lc.setConvertedStatus(convertStatus.MasterLabel);
		Database.LeadConvertResult lcr = Database.convertLead(lc);    
		
		//Requery for the referral record to see if it is updated
		CustomObject__c ref_upd = [select Account__c, Contact__c, Opportunity__c from CustomObject__c where Lead__c = :leadt.Id];
        
		//Check that the test passed
        System.assertEquals(ref_upd.Account__c,[Select ConvertedAccountId From Lead Where Id = :customobject.Lead__c].ConvertedAccountId);
        System.assertEquals(ref_upd.Contact__c,[Select ConvertedContactId From Lead Where Id = :customobject.Lead__c].ConvertedContactId);
        System.assertEquals(ref_upd.Opportunity__c,[Select ConvertedOpportunityId From Lead Where Id = :customobject.Lead__c].ConvertedOpportunityId);       
	
		//Test if no opty is created
		string NoOpty = 'Y';		
		if (NoOpty =='Y'){
			Lead leadto = new Lead (FirstName ='fnameo', LastName ='testo', Company ='myCompanyo');
	        insert leadto;
	        // Insert the custom object record 
	        CustomObject__c customobjecto = new CustomObject__c (Lead__c = leadto.Id);
	        insert customobjecto;
			
			Database.LeadConvert lco = new database.LeadConvert();
			lco.setLeadId(leadto.Id);
			lco.isDoNotCreateOpportunity();
			lco.setDoNotCreateOpportunity(true);
			LeadStatus convertStatuso = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
			lco.setConvertedStatus(convertStatuso.MasterLabel);
			Database.LeadConvertResult lcro = Database.convertLead(lco); 
		
			CustomObject__c ref_updo = [select Account__c, Contact__c, Opportunity__c from CustomObject__c where Lead__c = :leadto.Id];
			
			//Check that the test passed
	        System.assertEquals(ref_updo.Account__c,[Select ConvertedAccountId From Lead Where Id = :customobjecto.Lead__c].ConvertedAccountId);
	        System.assertEquals(ref_updo.Contact__c,[Select ConvertedContactId From Lead Where Id = :customobjecto.Lead__c].ConvertedContactId);
	        System.assert(ref_updo.Opportunity__c == null);
		}	
    }

	static testMethod void testBulkUpdate() {
        List<Lead> leads = new List<Lead>();       
        for (Integer i=0;i<5;i++) {
            Lead l = new Lead (FirstName ='bulk', LastName ='Test', Company ='myCompanyo');
		    insert l;
		    // Insert the Custom Record 
		   	CustomObject__c r = new CustomObject__c (Lead__c = l.Id);
		   	insert r;
		   	
	        //Convert the Lead
			Database.LeadConvert lcb = new database.LeadConvert();
			lcb.setLeadId(l.Id);
			LeadStatus convertStatusb = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
			lcb.setConvertedStatus(convertStatusb.MasterLabel);
			Database.LeadConvertResult lcrb = Database.convertLead(lcb);
			
			CustomObject__c bulkup = [select Account__c, Contact__c, Opportunity__c from CustomObject__c where Lead__c =:l.Id];
			
			//Check that the test has passed
        	System.assertEquals(bulkup.Account__c,[Select ConvertedAccountId From Lead Where Id = :r.Lead__c].ConvertedAccountId);
        	System.assertEquals(bulkup.Contact__c,[Select ConvertedContactId From Lead Where Id = :r.Lead__c].ConvertedContactId);
        	System.assertEquals(bulkup.Opportunity__c,[Select ConvertedOpportunityId From Lead Where Id = :r.Lead__c].ConvertedOpportunityId);
        	}	
    	}
}