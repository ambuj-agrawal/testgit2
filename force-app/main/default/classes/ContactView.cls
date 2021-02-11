public class ContactView
    {
    public list<Contact> contact {get;set;}
    public String selectedContactId{get;set;}
    public ContactView(){
        contact= [Select FirstName, LastName, Phone, Email from Contact];
    }
    public pageReference redirectTo(){

    return new pageReference('/'+selectedContactId);
    }
    public pageReference redirectTo2(){

    return new pageReference('/'+selectedContactId +'/e');
    }
    public pageReference redirectTo3(){
    List<Contact> cnt=[select name from Contact where Id=: selectedContactId];
    delete cnt;
    return new pageReference('/003');
    }
}