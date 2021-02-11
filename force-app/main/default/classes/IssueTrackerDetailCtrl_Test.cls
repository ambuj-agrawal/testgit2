@isTest
public class IssueTrackerDetailCtrl_Test {
    public static testMethod void IssueTracker(){
        Issue_Tracker__c ist= new Issue_Tracker__c();
        ist.Subject__c='test';
        ist.Issue_Description__c='test';
        ist.Issue_Opened_On__c= datetime.newInstanceGmt(2016, 5, 21, 5, 45, 52);
        insert ist;
        Attachment myAttachment  = new Attachment();
        myAttachment.ParentId=ist.id;
        myAttachment.Name = 'Test';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        myAttachment.body=bodyBlob;
        insert myAttachment;
        PageReference pageRef = Page.IssueTracker;
         Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(ist.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(ist);
        IssueTrackerDetailCtrl is= new IssueTrackerDetailCtrl(sc);
        is.Cancel();
        is.newcase();
        is.cancelcase();
        is.Closeissue();
        
        is.save();
        is.fileName='test';
        is.fileBody=bodyBlob;
        is.UploadFile();
        
    }
}