public class TestingAccountCtrl {
    public Account account{get;set;}
    public boolean b{get;set;}

    public TestingAccountCtrl(){
        account= new Account();
        b=false;
    }
    
    public void Save(){
        list<Account> s=[select name,fax from account where name =: account.name limit 1];
        if (s.size() > 0){
            account.fax=s[0].fax;
            b=true;
        }
    }
}