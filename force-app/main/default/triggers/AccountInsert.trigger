trigger AccountInsert on Contact (after insert,after update, after delete, after undelete) {
Set<Id> setId= new Set<Id>();
    List<contact> cont=new List<Contact>();
    if(Trigger.isInsert||Trigger.isUpdate||Trigger.isUndelete){
        for(Contact a:Trigger.new)
            setId.add(a.AccountId);  
    }
    if(Trigger.isUpdate||Trigger.isDelete){
        for(Contact a:Trigger.old)
            setId.add(a.AccountId);
    }
    List<Account> act=[Select Name, Phone, (Select LastName, phone, FirstName from Contacts) from Account where Id IN:setId];
    for(Account acc:act){
        for (Contact c: acc.Contacts){
                acc.Phone= c.Phone;
        }
    }
    update act;
}