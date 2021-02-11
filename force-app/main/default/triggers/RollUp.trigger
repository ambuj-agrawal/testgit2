trigger RollUp on Contact (after insert,after update, after delete, after undelete) {
    Set<ID> setAccountIDs = new Set<ID>();
    
    if(Trigger.isInsert|| Trigger.isUpdate||Trigger.isUndelete){
    for(Contact c : Trigger.new){
    setAccountIDs.add(c.AccountId);
    }
    }
    if(Trigger.isDelete|| Trigger.isUpdate){
        for(Contact c : Trigger.Old){
    setAccountIDs.add(c.AccountId);
    }
    }

    List<Account> accounts = [Select ID, Name, TotalAmount__c, (Select Name, Amount__c From Contacts) From Account WHERE ID IN :setAccountIDs];
    for(Account a : accounts){
    Double   accTotal = 0;
    for(Contact c : a.Contacts){
        if(c.Amount__c!=Null){
    accTotal +=c.Amount__c;
        }}
    a.TotalAmount__c=accTotal;
    }
    update accounts;
    }