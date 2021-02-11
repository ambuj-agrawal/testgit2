trigger OrderEventTrigger on Order_Event__e (after insert) {
	List<Task> cases = new List<Task>();
    

       
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Case to dispatch new team.
            Task cs = new Task();
            cs.Priority = 'Medium';
            cs.Status = 'New';
            cs.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            cs.OwnerId= Userinfo.getUserId();
            cases.add(cs);
        }
   }
    
    // Insert all cases corresponding to events received.
    insert cases;
}