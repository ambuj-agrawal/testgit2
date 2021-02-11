public class thankYou {
       
    public thankYou(ApexPages.StandardController con) {

    }
    
public PageReference Save()
    {
    PageReference Page = new PageReference('/apex/check2');
    Page.setRedirect(true);
    return Page;
    }

}