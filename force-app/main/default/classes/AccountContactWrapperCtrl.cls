public class AccountContactWrapperCtrl {
public List<AccountWrapper> accountList{get;set;}
   public AccountContactWrapperCtrl(){  
    accountList = new List<AccountWrapper>();
    for(Account accObj : [SELECT Name, (SELECT Name, Email FROM Contacts) FROM Account]){    
    accountList.add(new AccountWrapper(accObj));
    }
}
    public class AccountWrapper{   
        public Account accountObj{get;set;} 
        public Boolean isSelected{get;set;}   
    public AccountWrapper(Account accountObj){  
    this.accountObj=accountObj;      
    //accountObj = new Account();
    isSelected = false;
    }  
   /*public AccountWrapper(Account tempAccount){         
        accountObj = tempAccount;
        isSelected = false;  
    }*/
 }
}