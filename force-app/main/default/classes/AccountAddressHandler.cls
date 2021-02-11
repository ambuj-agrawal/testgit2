public class AccountAddressHandler{
    @future(callout=true)
    public static void addresss(id id){
       
        String mulId = id;
        string ddd = mulId.substring(0,mulId.length()-3);
         system.debug(ddd);
        List<Messaging.SingleEmailMessage> mails  = new List<Messaging.SingleEmailMessage>();
        ApexPages.PageReference report = new ApexPages.PageReference('/00O0K00000AWFtd?pv0=' +ddd +'&csv=1');

        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        
        attachment.setFileName('Ambuj.csv');
        
        Blob content = Test.isRunningTest() ? Blob.valueOf('UNIT.TEST') : report.getContent();
        
        attachment.setBody(content);
        
        attachment.setContentType('text/csv');
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        
        message.setFileAttachments(new Messaging.EmailFileAttachment[] {attachment});
        
        message.setSubject('Test');
        
        message.setPlainTextBody('ni pta');
        
        //String[] emailRecipients = new String[]();
        
        list<string> emailRecipients= new list<string>();
        
        emailrecipients.add('aagrawal@bodhtree.com');
        
        message.setToAddresses(emailRecipients);
        
        mails.add(message);
        
        //System.debug('Completed message processing for: ' + e.Name);
        
        
        
        //Update Last Ran date and add to update list.
        
        //e.Last_Ran__c = System.now();
        
        //exportUpdateList.add(e);
        
        
        //Send the email messages all at once to avoid limits.
        
        Messaging.sendEmail(mails);
        
        System.debug('Send emails.');
        
        
        
        //Update Export record with Last Ran date.
        
        //update exportUpdateList;
    }
}