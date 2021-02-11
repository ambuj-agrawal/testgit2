trigger FinalRollUp on Contact (after delete, after insert, after update) {
    Set<id> setId = new Set<id>();
    List<Account> acc = new List<Account>();

    for (Contact item : Trigger.new)
        setId.add(item.AccountId);

    if (Trigger.isUpdate || Trigger.isDelete) {
        for (Contact item : Trigger.old)
            setId.add(item.AccountId);
    }

    Map<id,Account> AccountMap = new Map<id,Account>([select id, TotalAmount__c from Account where id IN :setId]);
    List<Account> acc1=[select Id, Name, TotalAmount__c,(select id, Amount__c from Contacts) from Account where Id IN :setId];
    for (Account acct : acc1) {
        AccountMap.get(acct.Id).TotalAmount__c = acct.Contacts.size();
        acc.add(AccountMap.get(acct.Id));
    }

    update acc;

}