trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
	List<Task> cases = new List<Task>();
    
    for (Opportunity event : Trigger.New) {
        if (event.stagename == 'Closed Won') {
            // Create Case to dispatch new team.
            Task cs = new Task();
            cs.Priority = 'Medium';
            cs.Status = 'New';
            cs.Subject = 'Follow Up Test Task';
            cs.OwnerId= Userinfo.getUserId();
            cs.whatid=event.id;
            cases.add(cs);
        }
   }
    
    // Insert all cases corresponding to events received.
    insert cases;
}