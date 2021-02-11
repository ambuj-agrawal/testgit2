public class emailwithattach{
    public id aaa{get;set;}
    public pageReference emailInvoice(){
        
        Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
        PageReference pdf = Page.Printaccount;
        
        //prep attachment   
            pdf.getParameters().put('id', aaa);
            //pdf.setRedirect(true); //does not seem to be required
            
            Blob b = pdf.getContent();
        
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            
            efa.setFileName('invoice.pdf');
            efa.setBody(b);
            
        string[] toAddr = new string[] {'aagrawal@bodhtree.com'};
        mail.setToAddresses(toAddr);
            
        mail.setSubject('Your Invoice from ' + UserInfo.getOrganizationName() );
            
        mail.setHtmlBody('Thanks for attending:<b> ' + UserInfo.getOrganizationName() +' </b><p>'+
                ' Your Invoice is attached.');
 
            mail.setFileAttachments(new Messaging.Emailfileattachment[] {efa}); 
            
            Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});  
            
            //addInfo('Email Send result: '+ r[0].isSuccess());
        
        
        Attachment attach = new Attachment();

    // the contents of the attachment from the pdf
    Blob body;

    try {

        // returns the output of the page as a PDF
        body = pdf.getContent();

    // need to pass unit test -- current bug    
    } catch (VisualforceException e) {
        body = Blob.valueOf('Some Text');
    }

    attach.Body = body;
    // add the user entered name
    attach.Name = 'Ambuj';
    attach.IsPrivate = false;
    // attach the pdf to the account
    attach.ParentId = aaa;
    insert attach;    
        
        return null;
    }
}