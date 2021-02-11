public class Handler {
    public static void calsi(Set<Id> setAccountIDs){
    List<Account> accounts = new List<Account>([Select ID, Name, TotalAmount__c, Amount_X__c, Amount_Y__c, (Select Name, Amount_X__c, Amount_Y__c, Status__c From Contacts) From Account WHERE ID IN :setAccountIDs]);
        for(Account a : accounts){
            Double   accTotalX = 0;
            Double   accTotalY = 0;
                for(Contact c : a.Contacts){
                    if(c.Amount_X__c!=Null && c.Status__c=='Positive'){
                        accTotalX +=c.Amount_X__c;
                }
                else{
                    if(c.Amount_Y__c!=Null && c.Status__c=='Negative'){
                        accTotalY +=c.Amount_Y__c;
                    }
                }
                }
            a.Amount_X__c= accTotalX;
            a.Amount_Y__c= accTotalY;
                  
        } 
        update accounts;
}
}