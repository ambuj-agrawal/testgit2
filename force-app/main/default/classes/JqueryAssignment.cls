public class JqueryAssignment {
    public String FirstnameNewValue { get; set; }  
    public String PhoneNewValue { get; set; }  
    public String accountToEdit { get; set; } 
    public transient Map<Id, Contact> accountMap { get; set; }
    public Attachment attachment{get;set;}  
    public Id recId{    get;set;    }
    public string fileName {    get;set;    }
    public Blob fileBody {    get;set;    }
    
    public JqueryAssignment(){
        accountMap= new Map<Id, Contact>();
        attachment=new Attachment();
        allContacts();
       
    }
    
    public void allContacts() {   
      List<Contact> allContacts = [SELECT Id, firstName, Account.Name , LastName, Phone FROM Contact limit 10000];  
      accountMap = new Map<Id, Contact>(allContacts);       
    }
    
    public void SaveAttach(){
        system.debug('-----'+attachment.body);
    }
    
    
     public void saveChanges(){  
      Apexpages.Message msg = new Apexpages.Message(Apexpages.Severity.Confirm, 'Account changes saved successfully');  
      system.debug(attachment.body);
      Apexpages.Message error_msg = new Apexpages.Message(Apexpages.Severity.Confirm, 'An error occured while saving account changes. Please contact your admin.');  
      if(this.accountMap == null){  
           this.allContacts();  
      }  
      if(this.FirstnameNewValue != null || this.FirstnameNewValue==''){  
           this.accountMap.get(accountToEdit).firstName = this.FirstnameNewValue;  
      }  
      if(this.PhoneNewValue != null){  
           this.accountMap.get(accountToEdit).Phone= this.PhoneNewValue;  
      } 
      try{  
           update this.accountMap.get(accountToEdit);  
           Apexpages.addMessage(msg);  
      } catch(Exception e) {  
           Apexpages.addMessage(error_msg);  
      } 
 }

}