public class ContactAdd {
    list<Contact> cont= new list<contact>();
    public void ContAdd(){
    for (Account acc: [Select Id, Name From Account Where Id NOT IN (Select AccountId From Contact)])
    {
        contact c=new contact(LastName= 'contact ' +acc.Name, AccountId=acc.id);
        cont.add(c);
    }
    insert cont;
}
}