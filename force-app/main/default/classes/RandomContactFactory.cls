public class RandomContactFactory{
   public static List<Contact> generateRandomContacts(integer n,string lastname){
       integer n1= n;
       list<contact> c=[select  FirstName from contact limit : n1];
       return c;
   }
   
}