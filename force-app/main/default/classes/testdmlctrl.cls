public class testdmlctrl {
    public Account acc{get;set;}

public testdmlctrl(){
    acc = new account();
    creteaccount();
}
public void creteaccount(){
   
    acc.name='test';
    insert acc;
}
}