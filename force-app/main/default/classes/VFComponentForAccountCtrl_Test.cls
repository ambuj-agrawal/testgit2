@isTest

public class VFComponentForAccountCtrl_Test {
    static testMethod void testVFComponentNote(){
        Account a = new Account();
        a.name='test';
        
       
        insert a;
        Note no= new Note();
        no.Title='Test';
        no.Body='Test';
        no.ParentId=a.id;
        insert no;
        PageReference pageRef = Page.VFComponentForAccount;
         Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(a.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(a);
        VFComponentForAccountCtrl jpf= new VFComponentForAccountCtrl(sc);
        jpf.submit();

        
    }
    static testMethod void testVFComponentNote1(){
        Account a = new Account();
        a.name='test';
        insert a;
        Note no= new Note();
        no.Title='Test';
        no.Body='Test';
        no.ParentId=a.id;
       
        PageReference pageRef = Page.VFComponentForAccount;
         Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('Id', String.valueOf(a.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(a);
        VFComponentForAccountCtrl jpf= new VFComponentForAccountCtrl(sc);
        jpf.noa= no;
        jpf.submit();
       
        
    }
}