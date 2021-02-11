public class ShowAllPageClass {
    public List<Contact> con{get;set;}
    public Account acc;
    public ShowAllPageClass(ApexPages.StandardController stdController){
        acc=(Account)stdController.getRecord();
        con=new List<contact>();
        con=[select Id,FirstName,LastName,Phone,Email,Contacted__c from contact where AccountId=:acc.Id and Contact.Contacted__c=:false];   
    }
    
    public void Match(){
        for(Contact c:con){
            c.Contacted__c=true; 
        }
        update con;
        con.clear();
        
    }

}