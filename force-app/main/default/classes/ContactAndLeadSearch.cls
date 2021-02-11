public class ContactAndLeadSearch
{
    public static List<List<SObject>> searchContactsAndLeads(String str)
    {
        List<List<sObject>> searchContactsAndLeadsList = [FIND :str IN ALL FIELDS RETURNING Contact(FirstName,LastName) ,Lead(FirstName,Lastname)];
        return searchContactsAndLeadsList ;
    }

}