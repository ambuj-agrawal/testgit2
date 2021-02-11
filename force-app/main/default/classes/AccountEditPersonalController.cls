public class AccountEditPersonalController{
    ApexPages.StandardController sController;
    public AccountEditPersonalController(ApexPages.StandardController controller) {
        sController = controller;
    }

    public PageReference saveAndNew() {
        sController.save(); 
        PageReference pg = new PageReference('/apex/AccountEditPersonal');
        pg.setRedirect(true);
        return pg;
    }
}