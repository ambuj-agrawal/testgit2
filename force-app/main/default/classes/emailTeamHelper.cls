/*
Purpose:To get the all Team Member email from issue tracker 
*/
global class emailTeamHelper {
global Id recId{set;get;}
WebService static void sendEmail(Id recId){
System.debug('------ recId ---->'+recId);
List<Issue_Tracker__c> istu=new List<Issue_Tracker__c>();
List<string> sendTo=new List<string>();
List<Team_Member__c> team=new List<Team_Member__c>();
string stname;
string journeyname;
date clsdate;
//istu=[select id,(select name,email__c from Team_Members__r) from Issue_Tracker__c where id =:recId and Email__c !=''];
istu=[select id,Team_Members__r.name,Team_Members__r.email__c,Target_Date__c from Issue_Tracker__c where id =:recId];
system.debug('=====istu======='+istu.size());
for(Issue_Tracker__c it:istu){
sendTo.add(it.Team_Members__r.Email__c);
clsdate=it.Target_Date__c;
}
List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String currentUserEmail = UserInfo.getUserEmail();
String[] ccAddresses = new String[] {currentUserEmail};
system.debug('==cc=='+ccAddresses);
mail.setSaveAsActivity(false);
mail.setToAddresses(sendTo);
mail.setccAddresses(ccAddresses);
mail.setSubject('Re:Ticket assigned alert in Edterra');
      //String body = 'Dear '+ stname+' ,<br/>';
      String body = 'Dear, '+'<br/>';
      body += 'Following ticket has been assigned to you by Edterra dev team please close it on or before '+clsdate+'<br/><br/><br/>';
      body += 'https://edterra-sb--Dev.cs6.my.salesforce.com/'+recId+'<br/><br/><br/>';
      mail.setHtmlBody(body);
allmsg.add(mail);
Messaging.sendEmail(allmsg,true);
}
}