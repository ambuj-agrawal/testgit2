trigger FinalRollUp2 on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> setId = new Set<Id>();
    List<Contact> cntList = new List<Contact>();
    Map<Id, List<Contact>> setIdListMap = new Map<Id, List<Contact>>();
    List<Account> AccountList = new List<Account>();
    Map<Id, Double> AccountTotal = new Map<Id, Double>();
    if(Trigger.isInsert|| Trigger.isUpdate||Trigger.isUndelete){
        for(Contact cnt : trigger.New) {
            setId.add(cnt.AccountId);
        }
    }
    if(Trigger.isDelete|| Trigger.isUpdate){
        for(Contact cnt:trigger.Old){
            setId.add(cnt.AccountId);
        }
    }
    
    cntList = [SELECT Id, Amount__c, AccountId FROM Contact WHERE AccountId IN : setId];
    AccountList = [SELECT Id, TotalAmount__c FROM Account WHERE Id IN : setId];
    
    if(AccountList.size() > 0) {
        if(cntList.size() > 0) {
            for(Contact cnt : cntList) {
                if(!setIdListMap.containsKey(cnt.AccountId)) {
                    setIdListMap.put(cnt.AccountId, new List<Contact>());
                }
                setIdListMap.get(cnt.AccountId).add(cnt);
            }    
            
            for(Id tempId : setIdListMap.keySet()) {
                List<Contact> tempcntList = new List<Contact>();
                tempcntList = setIdListMap.get(tempId);
                Double tempTotalAmount = 0;
                for(Contact cnt : tempcntList) {
                    tempTotalAmount += cnt.Amount__c;
                }
                AccountTotal.put(tempId, tempTotalAmount);
            }           
        }
        for(Account bigMachine : AccountList) {
            bigMachine.TotalAmount__c = AccountTotal.get(bigMachine.Id);
        }
        update AccountList;
    }
}