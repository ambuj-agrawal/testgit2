public class VFComponentForAccountCtrl {
    public List<Note> ncc{get;set;}
    public string newnote{get;set;}
    public note noa{get;set;}
    public id useid{get;set;}
    
  

    public VFComponentForAccountCtrl(ApexPages.StandardController controller) {
        ncc= new list<Note>();
        noa= new Note();
        newnote='';
        useid= UserInfo.getUserId();
        system.debug('11111111' +useid);
        if(ApexPages.currentPage().getParameters().get('id')!= null){
            
            ncc= [select title, body, createddate, owner.name, ownerid from note where parentid =: ApexPages.currentPage().getParameters().get('id') order by createddate];
            for(note d: ncc)
            system.debug('2222222' + d.ownerid);
        }
    }
    public void submit(){
        system.debug('=============' +newnote);
        if(noa.body != null || noa.body != ''){
            Note noo= new note();
            DateTime dt = DateTime.now();
                system.debug('===month====='+dt.month());
                String dateTimeStr = dt.format('MMMM dd, YYYY  @ hh:mm:ss');
                System.debug('>>>>' + dateTimeStr);
            noo.title= dateTimeStr;
            noo.body= noa.body;
            noo.parentid= ApexPages.currentPage().getParameters().get('id');
            
            ncc.add(noo);
            upsert ncc;
            noa.body='';
        }
    }

}