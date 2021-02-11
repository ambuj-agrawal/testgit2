public class AmountRollUp {
    public static void AmountRoll(List<Contact> con){
        Map<Id, Account> AccountMap = new Map<Id, Account>();
        for (Contact cc : con){
            if(cc.Accountid==null)
                break;
            else{
                Account acc = new Account(Id = cc.Accountid);
                acc.TotalAmount__c = 0;
                acc.Amount_X__c=0;
                acc.Amount_Y__c=0;
                AccountMap.put(cc.Accountid, acc);
            }
        }
        for (Contact cc : [select Accountid, Amount__c, Amount_X__c, Amount_Y__c, Status__c 
                               from Contact where Accountid in :AccountMap.keySet()]){
            Account acc = AccountMap.get(cc.Accountid);
            if (cc.Amount_X__c != null && cc.Status__c=='Positive'){
                acc.Amount_X__c += cc.Amount_X__c;
            }
            if (cc.Amount_Y__c != null && cc.Status__c=='Negative'){
                acc.Amount_Y__c += cc.Amount_Y__c;
            }
            if (cc.Amount__c != null){
                acc.TotalAmount__c += cc.Amount__c;
            }
            
        }
       update AccountMap.values();
    }
}