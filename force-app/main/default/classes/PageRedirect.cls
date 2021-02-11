public class PageRedirect {
    Public  Account acct{get;set;}
    public PageRedirect(ApexPages.StandardController controller) {
        this.acct=(Account)controller.getRecord();
        
    }
    
    public PageReference checkAndRedirect(){ 
        PageReference ref = new PageReference('/001/e?retURL=%2F001%3Ffcf%3D00B2800000A5Zbe&_CONFIRMATIONTOKEN=VmpFPSxNakF4Tnkwd05TMHhORlF4Tnpvd01qb3dOUzQzTURKYSxWMXlGMzJXQi1fc1ZERjZ4aG5pNFJYLE1HTTVaREV3&common.udd.actions.ActionsUtilORIG_URI=%2F001%2Fe&=5000&acc8=5000&acc15=50000&acc2=Autofill');   
        ref.getParameters().put('nooverride','1');
    
        ref.setredirect(true);
    return ref;
    
    }

}