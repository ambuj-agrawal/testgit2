Public class RelatedListButtonController{
    Public list<WrapperClass> listWrapper{get;set;}
    Public String Id;
    
    public RelatedListButtonController(){
        listWrapper = new list<WrapperClass>();
        Id=apexpages.currentpage().getparameters().get('id');
        list<Contact> listCnt=[Select Name, LastName, FirstName, Email from Contact where AccountId=:Id];
        if(listCnt.size()>0){
            for(Contact cnt:listCnt){
                listWrapper.add(new WrapperClass(cnt));
            }
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
        
    public void newedit(){
        for(WrapperClass wcl: listWrapper)
            wcl.check=true;
    }
        
    public void edit(){
        List<Contact> listCntEdit= new List<Contact>();
        for(WrapperClass wcl: listWrapper){
                if(wcl.checked){
                    listCntEdit.add(wcl.cnt);
                    wcl.checked = false;
                }
                
        }
            upsert listCntEdit;
            listWrapper= new list<WrapperClass>();
        list<Contact> listCnt=[Select Name, LastName, FirstName, Email from Contact];
        if(listCnt.size()>0){
            for(Contact cnt:listCnt){
                listWrapper.add(new WrapperClass(cnt));
            }
        }    
    }
}