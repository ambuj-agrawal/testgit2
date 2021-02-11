trigger ContactInsert on Account (before insert, after insert, after delete, after update, after undelete) {
    Set<Id> setId= new Set<Id>();
    List<contact> cont=new List<Contact>();
    if(Trigger.isInsert||Trigger.isUpdate||Trigger.isUndelete){
        for(Account a:Trigger.new)
            setId.add(a.Id);  
    }
    if(Trigger.isUpdate||Trigger.isDelete){
        for(Account a:Trigger.old)
            setId.add(a.Id);
    }
    for(Account act:[Select Name from Account where Id=:setId]){
        Contact con=new Contact(LastName=act.Name, AccountId=act.Id);
        cont.add(con);
    }
    upsert cont;

}