Public class EditUpdateCheckedController{
    Public list<WrapperClass> listWrapper{get;set;}
    
    public EditUpdateCheckedController(){
     listWrapper= new list<WrapperClass>();
     list<Contact> listCnt=[Select Name, Email from Contact];
     if(listCnt.size()>0){
         for(Contact cnt:listCnt){
         listWrapper.add(new WrapperClass(cnt));
         }
     }    
    }
        public class WrapperClass{
            public Boolean checked{get;set;}
            public Contact cnt{get;set;}
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

}