public class HandlerAmount {
    public static void calsi(Set<Id> setAccountIDs){
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
}