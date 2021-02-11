public class ContactSearch {
    public static List<Contact> searchForContacts(String lstname, String mpcode){
        List<Contact> ctc = new List<Contact>();
        ctc = [SELECT FirstName FROM Contact WHERE LastName=:lstname AND MailingPostalCode=:mpcode];
        return ctc;
       }
}