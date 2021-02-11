@isTest
public class AccountContactWrapperCtrl_Test{
    
    public static void createTestData(){
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < 10; i++){
            accountList.add(new Account(Name='Test'+i));
        }
        insert accountList;
        
        List<Contact> contactList = new List<Contact>();
        for(Account acc : accountList){
            contactList.add(new Contact(LastName='Test',AccountId=acc.id));
        }
        insert contactList;
    }
    
    public static testMethod void unitTest(){
        AccountContactWrapperCtrl_Test.createTestData();
        AccountContactWrapperCtrl accConWrapObj = new AccountContactWrapperCtrl();
        //AccountContactWrapperCtrl.AccountWrapper accWrapObj = new AccountContactWrapperCtrl.AccountWrapper();
    }
}