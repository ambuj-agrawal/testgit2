public with sharing class MassEmailAccountCtrl {
    public list<Account> lstAccount{get;set;}
    public string emailto{get;set;}
    public string emailcc{get;set;}
    public string subject{get;set;}
    public string body{get;set;}
    public String selectedTemplateId { public get; public set; }
    public list<EmailTemplate> ee{get;set;}
    public list<string> sendto{get;set;}
    public list<string> sendcc{get;set;}
    
    public MassEmailAccountCtrl(ApexPages.StandardSetController controller) {
        
        lstAccount=[select name, email__c from Account where Id IN :Controller.getSelected() and email__c != null];
        
        emailto='';
        emailcc='';
        subject='';
        body='';
        ee= new list<EmailTemplate>();
        sendto= new list<string>();
        sendcc= new list<string>();
        if(lstAccount.size()>0){
            for(Account a: lstAccount){
                emailto += a.email__c + ';';    
            }
        }
    }
    
    public void send(){
        try{
            if(emailto != null)
                sendto=emailto.split(';');
            
            if(emailcc != null && emailcc != '')
                sendcc=emailcc.split(';');
            
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId( UserInfo.getUserId() );
            mail.setSaveAsActivity(false);
            mail.setToAddresses(sendto);
            if(emailcc != null && emailcc != '')
                mail.setccAddresses(sendcc);
            mail.setSubject(subject);
            mail.setHtmlBody(body);
            allmsg.add(mail);
            //Messaging.sendEmail(allmsg,true);  
            
            
            //body1 = pdf.getContent();
            system.debug(body);
            system.debug(ee[0].HTMLValue);
            pageReference pdf = Page.SaveRichTextPdf;
            pdf.getParameters().put('htmlvalue',body);
            pdf.setRedirect(true);
            
            blob body1 = pdf.getContentaspdf();
            string filename = 'my File Name.pdf';
            
            attachment theFile = new attachment();
            
            theFile.isPrivate = false;
            theFile.body = body1;
            theFile.ParentId = '0010K000029QnS6';
            theFile.Name = filename;
            
            insert theFile;
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.Confirm, 'Mail Sent Successfully'));
        }    
        catch (Exception ex) {
            ApexPages.addMessages(ex);
        }
    }
    
    public List<SelectOption> getMyPersonalTemplateOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('none','--None--'));
        for (EmailTemplate t : [
            select Id,Name 
            from EmailTemplate
            // Each User has a 'My Personal Templates' folder
            // of EmailTemplates, whose Id is the User's Id
            
        ]) {
            options.add(new SelectOption(t.Id,t.Name));
        }
        return options;
    }
    
    public void gettemplatebody(){
        if(selectedTemplateId != 'none'){
            ee=[select Id,Name,body,HTMLValue from EmailTemplate where id =: selectedTemplateId];  
            body= ee[0].HTMLValue;      
        } 
        else{
            body='';
        }   
    }
    
    
}