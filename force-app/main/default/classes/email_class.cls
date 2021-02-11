public class email_class {
public string subject{get; set;}
 public string email_body{get;set;}

list<string> emails = new list<string>{'aagrawal@bodhtree.com'};




public PageReference send()
{

String body = '<!doctype html><html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"><body><a href="http://www.twitter.com/" target="_blank"><img src="https://cdn4.iconfinder.com/data/icons/miu-gloss-social/60/facebook-512.png" style="display:block;" height="24" width="24" class=""></a></body></html>';
system.debug('------->'+body);

/*Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.setSubject(subject);

//message.setPlainTextBody(body);
message.setHtmlBody(body);
message.setToAddresses(emails );
Messaging.SendEmailResult[] r=  Messaging.SendEmail(new Messaging.SingleEmailMessage[]{message }); 
return null;*/


Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
String[] toAddresses = new String[] {'garimaagrawal01@gmail.com'}; 
mail.setToAddresses(toAddresses);
mail.setSubject('Test Subject');  
mail.setSaveAsActivity(false);  

mail.sethtmlBody(body);  
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
return null;
}

}