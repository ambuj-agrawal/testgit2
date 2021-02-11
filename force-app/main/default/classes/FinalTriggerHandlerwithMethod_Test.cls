@isTest
public class FinalTriggerHandlerwithMethod_Test {
    public static List<Account> createAccountsWithCnts(Integer numAccts, Integer numCntsPerAcct) {
        List<Account> accts = new List<Account>();
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        List<Contact> cnts=new List<Contact>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add Contact
            for (Integer k=0;k<numCntsPerAcct;k++) {
                cnts.add(new Contact (LastName='Test', AccountId=acct.Id, Amount_X__c=555, Status__c='Positive'));
                cnts.add(new contact (LastName='Test', AccountId=acct.Id, Amount_y__c=500, Status__c='Negative'));
                cnts.add(new contact (LastName='Test', AccountId=acct.Id));
                cnts.add(new contact (LastName='Test', AccountId=acct.Id, Amount__c=500));
                cnts.add(new contact (LastName='Test', AccountId=acct.Id, Amount_y__c=500, Amount_X__c=555, Amount__c=500 ));
            }   
        }
        insert cnts;
        return accts;
    }
    
    //for insert Account and Contact
    public static testmethod void testInsert() {
        FinalTriggerHandlerwithMethod_Test.createAccountsWithCnts(1,200);
        Account acc =[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        system.assertEquals(111000, acc.Amount_X__c);
    }
    //Create account with Contact, and then delete some contact
    public static testmethod void testDelete() {
        FinalTriggerHandlerwithMethod_Test.createAccountsWithCnts(3,100);
        Account acc =[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        List<contact> con=[select Name from Contact where AccountId=: acc.Id];
        delete con;
        Account acc1=[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        system.assertEquals(0, acc1.Amount_X__c);
    }
    //Create account with Contact, and then Undelete some contact
    public static testmethod void testUndelete() {
        FinalTriggerHandlerwithMethod_Test.createAccountsWithCnts(3,100);
        Account acc =[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        List<contact> con=[select Name from Contact where AccountId=: acc.Id];
        delete con;
        undelete con;
        Account acc1=[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        system.assertEquals(55500, acc1.Amount_X__c);
    }
    //Create account with Contact, and then Update some contact
    public static testmethod void testUpdate() {
        FinalTriggerHandlerwithMethod_Test.createAccountsWithCnts(2,100);
        Account acc =[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        List<contact> con1=[select Name, Amount_X__c from Contact where AccountId=: acc.Id];
        for(Contact cont:con1){
            cont.Amount_X__c=50;
        }
        update con1;
        Account acc3=[select TotalAmount__c, Amount_X__c, Amount_Y__c from Account where Name='TestAccount0'];
        system.assertEquals(5000, acc3.Amount_X__c);
    }
    
}