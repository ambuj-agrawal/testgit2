public class AccountAdd {

   list<Account> acc=new list<Account>();
    public AccountAdd(){
    for(integer i=1; i<=50; i++){
        Account acc1=new Account(Name= 'Prospect Account ' +i, Type='Prospect');
        acc.add(acc1);
        Account acc2=new Account(Name= 'Customer - Direct Account ' +i, Type='Customer - Direct');
        acc.add(acc2);
        Account acc3=new Account(Name= 'Customer - Channel Account ' +i, Type='Customer - Channel');
        acc.add(acc3);
        Account acc4=new Account(Name= 'Other Account ' +i, Type='Other');
        acc.add(acc4);
    }
        insert acc;
    }
}