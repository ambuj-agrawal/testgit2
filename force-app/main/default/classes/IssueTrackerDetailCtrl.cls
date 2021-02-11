public class IssueTrackerDetailCtrl {
    Public Issue_Tracker__c issuetrack{get;set;}
    public string fileName {get;set;}
    public Blob fileBody{get;set;}
    public list<Attachment> attch{get;set;} 
    Public String casecoment{get;set;}
    public list<Issue_Comments__c> comlist{get;set;}
    public boolean rend{get;set;}
    Public Issue_Comments__c issuecomments{get;set;}
    
    public IssueTrackerDetailCtrl(ApexPages.StandardController controller) {
        casecoment='';
        issuetrack=[select id, ownerid,owner.name, name, Issue_Status__c, Subject__c, Severity_Level__c, Issues_With__c, Issue_Description__c, Instance_Type__c, Reported_By__c, Issue_Opened_On__c, Remarks__c, Issue_Impact__c,(select id, name from Attachments) from Issue_Tracker__c where id=: apexpages.currentpage().getparameters().get('id')];
        attch=[select id, ParentId, Name, LastModifiedDate, CreatedById, createddate from attachment where parentid=: apexpages.currentpage().getparameters().get('id') order by createddate DESC];
        comlist=[select Issue_Comments__c, Id, Issue_Tracker__c, CreatedById,owner.name, createddate from Issue_Comments__c where Issue_Tracker__c=: apexpages.currentpage().getparameters().get('id') and public__c = true order by createddate DESC];
        rend=true;
        issuecomments= new Issue_Comments__c();
    }
    public PageReference UploadFile()
    {
        PageReference pr;
        if(fileBody != null && fileName != null)
        {
          Attachment myAttachment  = new Attachment();
          myAttachment.Body = fileBody;
          myAttachment.Name = fileName;
          myAttachment.ParentId = apexpages.currentpage().getparameters().get('id');
          insert myAttachment;
          
          
           
        }
        
        //attch=[select id, ParentId, Name, LastModifiedDate, CreatedById from attachment where parentid=: apexpages.currentpage().getparameters().get('id')];
        pr = new PageReference('/apex/IssueTrackerDetailPage?id=' + apexpages.currentpage().getparameters().get('id'));
           pr.setRedirect(true);
           return pr;
    }
    
    Public void Closeissue(){
        issuetrack.Issue_Status__c='Customer Closed';
        update issuetrack;
    }
    public PageReference Cancel(){
        PageReference pr = new PageReference('/apex/CustomIssueTrackerHomePage');
        return pr;
    }
    public void newcase(){
        rend = false;    
    }
    Public void cancelcase(){
        rend = true;
    }
    public PageReference save(){
        PageReference pr;
        if(casecoment !=null){
            Issue_Comments__c ic = new Issue_Comments__c();
            ic.Issue_Comments__c= issuecomments.Issue_Comments__c;
            ic.Issue_Tracker__c= apexpages.currentpage().getparameters().get('id');
            insert ic;
        }
        rend=true;
        pr = new PageReference('/apex/IssueTrackerDetailPage?id=' + apexpages.currentpage().getparameters().get('id'));
           pr.setRedirect(true);
           return pr;
    }

}