Public class AccountInLineCheckedController{
    Public list<WrapperClass> listWrapper{get;set;}
    Public String Cont{get;set;}
    Public Account Act{get;set;}
    
    public AccountInLineCheckedController(ApexPages.StandardController controller){
        listWrapper = new list<WrapperClass>();
        String Str=apexpages.currentpage().getparameters().get('id');
        list<Contact> listCnt=[Select Name, LastName, FirstName, Email from Contact where AccountId=:Str];
        if(listCnt.size()>0){
            for(Contact cnt:listCnt){
                listWrapper.add(new WrapperClass(cnt));
            }
            
        /*integer i=0;
        While(i< listCnt.Size()){
            listWrapper.add(new WrapperClass(listCnt.get(i)));
            i++;
        }*/
        } 
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No Contact Found'));
        }   
    }
    
    public class WrapperClass{
        public Boolean checked{get;set;}
        public Boolean check{get;set;}
        public Contact cnt{get;set;}
        public List<contact> lcc{get;set;}
        public WrapperClass(Contact cnt){
           this.cnt=cnt;
        }
    }  
    public void del(){
        List<Contact> listCntDel= new List<Contact>();
        List<WrapperClass> listWrpDel = new List<WrapperClass>();
        for(WrapperClass wcl: listWrapper){
            if(wcl.checked){
                listCntDel.add(wcl.cnt);
            }
            else{
               listWrpDel.add(wcl);
            }   
        }
        if(listCntDel.size()>0){
            delete listCntDel;
            listWrapper= listWrpDel;
        }
    }
        
    public void Save(){
        List<Contact> listCntEdit= new List<Contact>();
        for(WrapperClass wcl: listWrapper){
                if(wcl.checked){
                    listCntEdit.add(wcl.cnt);
                    wcl.checked = false;
                }
                
        }
            update listCntEdit;
               
    }
}