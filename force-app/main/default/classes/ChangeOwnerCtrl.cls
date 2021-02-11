public class ChangeOwnerCtrl{
    Public ApexPages.StandardSetController Controller;
    Public list<Account> acc{get;set;}
    public lead aa{get;set;}
    public ChangeOwnerCtrl(ApexPages.StandardSetController controller) {
        controller.setPageSize(10);
        this.Controller = Controller;
        aa= new lead();
        acc=[select Name from Account where Id IN :Controller.getSelected()];
        system.debug(acc);
    }
    
    public void ss(){
        try{
            for(Account aaa: acc){
                aaa.ownerid=aa.ownerid;
            
            }
            update acc;
        }
        catch(Exception ex){
            ApexPages.addMessages(ex);
        }
    }

}