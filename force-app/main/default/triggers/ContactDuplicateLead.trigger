trigger ContactDuplicateLead on Contact (before insert) {
	map<Id,Lead> existingleadMap = new  map<Id,lead>([Select Id, email From Lead]); 

     for(Contact a : Trigger.new){
        if(a.email == existingleadMap.get(a.Id).email){
          a.adderror('You cannot create a dulplicate lead');
        }
     }
}