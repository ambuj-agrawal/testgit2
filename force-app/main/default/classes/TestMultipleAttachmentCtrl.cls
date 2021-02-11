public class TestMultipleAttachmentCtrl {
    Public Account acc{get;set;}
    public string callfunc{get;set;}
    public String myValue{get;set;}
    
    public TestMultipleAttachmentCtrl(){
        acc= new Account();
        myValue='';
        
    }
    public void Save(){
        insert acc;
        myValue= acc.id;
       
        
    }
}