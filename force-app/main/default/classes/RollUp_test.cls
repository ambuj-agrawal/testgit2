@isTest

public class RollUp_test {
    public static testMethod void unitTest(){
        List<contact> cnt=new List<Contact>();
        Account a1=new Account(Name='Test');
        insert a1;
            for(integer i=0; i<50; i++){
                Contact c1=new Contact(LastName=a1.Name, AccountId=a1.Id, Amount__c=200);
                cnt.add(c1);
            }    
        insert cnt;
        AggregateResult[] cnt1=[Select sum(Amount__c) sum from contact where accountId=:a1.Id];
        Decimal amount=(Decimal)cnt1[0].get('sum');
        system.assertEquals(10000, amount);
        
        List<Contact> cnt2=[select Amount__c from contact where id IN :cnt];
           for(contact con:cnt2){
            	con.Amount__c=300;
           } 	
        update cnt2;
        
        AggregateResult[] cnt3=[select sum(Amount__c) sum from contact where accountid=:a1.Id];
       	amount=(Decimal)cnt3[0].get('sum');
        System.assertEquals(15000,amount);
    }
}