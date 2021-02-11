public class IssueTrackerCtrl {
    Public Issue_Tracker__c issuetrack{get;set;}
    
    public IssueTrackerCtrl(ApexPages.StandardController controller) {
        this.issuetrack = (Issue_Tracker__c)Controller.getRecord();
    }
    public PageReference Save(){
           insert issuetrack;
        PageReference pf=new PageReference('/apex/IssueTrackerDetailPage?id='+issuetrack.id);
        return pf;
    }    

}