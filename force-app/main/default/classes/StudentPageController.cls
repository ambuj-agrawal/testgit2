public class StudentPageController {
    public Student__c stdObj{get;set;}    
    
public StudentPageController(){
    stdObj = new Student__c();
    String stdId = apexpages.currentpage().getparameters().get('id');
    if(stdId != null && stdId.trim() != ''){
    stdObj = [SELECT Class__c, Email__c, DOB__c,Salutation__c,First_Name__c, Last_Name__c, Have_Vehicle__c, Married__c, Gender__c 
                FROM Student__c WHERE id =: stdId];
  }
}
public PageReference CreateStudent(){
    upsert stdObj;
    return new PageReference('/'+stdObj.id);
    }
}