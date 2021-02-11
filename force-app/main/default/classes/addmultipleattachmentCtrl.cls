public class addmultipleattachmentCtrl {
    Public list<Attachment> acc{get;set;}
    public String theValue{get;set;}
    public boolean bb{get;set;}

    public addmultipleattachmentCtrl(ApexPages.StandardController controller) {
        acc= new list<Attachment>();
        theValue='';
        bb=false;
        Attachment a = new Attachment();
        acc.add(a);
        

    }
     public void addrow() {
        Attachment a = new Attachment();
        //inw.Inward_Payment_Tracker__c = ipt.id;
        //inw.name= ipt.name;
        
        acc.add(a); 
    }
    public void removerow(){
        Integer i = acc.size();
        if(i != 0)
          acc.remove(i-1);
    }
    
    public Pagereference Save(){
        integer i=0;
        for(Attachment dd: acc){
            i +=dd.bodylength;
        
        }
        system.debug(i);
        if(i > 200){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment:'));
        }
        return null;
    }

}