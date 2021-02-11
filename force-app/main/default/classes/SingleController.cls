public class SingleController {
    public String name {
        get;
        set{
            name = value;
            System.Debug(LoggingLevel.INFO,'Inside setter Name: ' + value);
        }
    }
    
    public PageReference goToSecondPage(){
        PageReference pageReference = new PageReference('/apex/SecondPage');
        pageReference.setRedirect(false);
        return pageReference;
    }
}