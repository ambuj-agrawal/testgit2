@isTest
public class IssueTrackerCtrl_Test {
	public static testMethod void IssueTracker() {
    	Issue_Tracker__c ist= new Issue_Tracker__c();
        ist.Subject__c='test';
        ist.Issue_Description__c='test';
        ist.Issue_Opened_On__c= datetime.newInstanceGmt(2016, 5, 21, 5, 45, 52);
        PageReference pageRef = Page.IssueTracker;
         Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(ist.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(ist);
        IssueTrackerCtrl is= new IssueTrackerCtrl(sc);
        is.save();
    
            
        
	}
    
    
}