@isTest
public class FinalTriggerHandler_Test{
    public static TestMethod void Test1(){
        List<contact> contList=new List<contact>();
        Account acc=new Account(Name='Test');
        insert acc;
        Contact cont=new Contact(LastName='Test', AccountId=acc.Id, Amount_X__c=555, Status__c='Positive');
        Contact cont2=new Contact(LastName='Test', AccountId=acc.Id, Amount_Y__c=555, Status__c='Negative');
        Contact cont3=new Contact(LastName='Test', AccountId=acc.Id, Amount_Y__c=555, Amount_X__c=555);
        Contact cont4=new Contact(LastName='Test', AccountId=acc.Id, Amount__c=899);
        Contact cont5=new Contact(LastName='Test', AccountId=acc.Id);     
          
        contList.add(cont);
        contList.add(cont2);
        contList.add(cont3);
        contList.add(cont4);
        contList.add(cont5);
        insert contList;
        Account acc1=[select Name, Amount_X__c, Amount_Y__c, TotalAmount__c from Account where id=:acc.id];
        system.debug(cont2.Amount_Y__c);
        system.assertEquals(555, acc1.Amount_X__c);
        system.assertEquals(899, acc1.TotalAmount__c);
        system.debug(acc1.Amount_X__c);
        system.debug(acc1.TotalAmount__c);
        system.assertEquals(555, acc1.Amount_X__c);
        system.assertEquals(899, acc1.TotalAmount__c);
        cont2.Amount_Y__c=666;
        update cont2;
        system.debug(cont2.Amount_Y__c);
        system.debug(acc1.Amount_Y__c);
        Account acc2=[select Name, Amount_X__c, Amount_Y__c, TotalAmount__c from Account where id=:acc.id];
        system.assertEquals(666, acc2.Amount_Y__c);
        delete cont2;
        Account acc3=[select Name, Amount_X__c, Amount_Y__c, TotalAmount__c from Account where id=:acc.id];
        system.assertEquals(null, acc3.Amount_Y__c);
        undelete cont2;
        Account acc4=[select Name, Amount_X__c, Amount_Y__c, TotalAmount__c from Account where id=:acc.id];
        system.assertEquals(666, acc4.Amount_Y__c);
        Contact cont6=new Contact(LastName='Test', AccountId=acc.Id, Amount_Y__c=5, Status__c='Negative'); 
        insert cont6;
        Account acc5=[select Name, Amount_X__c, Amount_Y__c, TotalAmount__c from Account where id=:acc.id];
        system.assertEquals(671, acc5.Amount_Y__c);
    }


}