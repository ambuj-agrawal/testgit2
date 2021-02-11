Public class DeletingCheckedController{
    Public list<WrapperClass> listWrapper{get;set;}
    Public String Cont{get;set;}
    
    public DeletingCheckedController(){
        listWrapper = new list<WrapperClass>();
        list<Contact> listCnt=[Select Name, LastName, FirstName, Email from Contact limit 1000];
        if(listCnt.size()>0){
            /*for(Contact cnt:listCnt){
            listWrapper.add(new WrapperClass(cnt));
            }*/
        integer i=0;
        While(i< listCnt.Size()){
            listWrapper.add(new WrapperClass(listCnt.get(i)));
            i++;
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