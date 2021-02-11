public class AccountFieldCtrl {
    public Contact cc{get;set;}
    
    public AccountFieldCtrl(){
        cc= new Contact();
    }
    public void AccountPopulated()
     {
      cc.Account=[select name, AccountNumber, Site from Account where id=:cc.AccountId];
     }
}