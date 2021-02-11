public class SandeepTestCtrl {
    public Account acc{get;set;}
    public list<Contact> contactList{get;set;}
    public SandeepTestCtrl(){
        acc = new Account();
        system.debug(apexpages.currentpage().getparameters().get('id'));
        acc = [Select name, Industry from account where Id =: apexpages.currentpage().getparameters().get('id')];
        contactList = [Select firstname, Lastname from contact where AccountId =: apexpages.currentpage().getparameters().get('id')];
    }
    
}