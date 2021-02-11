public class SearchContatcInLineEditCtrl {
    public Contact cont{get;set;}
    string accname{get;set;}
    public list<contact> searchlist{get;set;}
    public Boolean allChecked { get; set; }
    public List<wrapperClass> wrapList{get;set;}
    public string selectcontact{get;set;}
    public Integer Counter{get;set;}
    public Boolean checkmain{get;set;}
    public Map<Integer,List<wrapperClass>> mapAccount{get;set;}

    public SearchContatcInLineEditCtrl(ApexPages.StandardController controller) {
        this.cont=(contact)controller.getRecord();
        allChecked = false;
        checkmain=false;
        wrapList = new List<wrapperClass>();
        mapAccount = New Map<Integer,List<wrapperClass>>();
        searchlist=new list<contact>();
    }
    
    public void search(){
        mapAccount = New Map<Integer,List<wrapperClass>>();
        wrapList = new List<wrapperClass>();
        accname = cont.accountid;
        Counter = 0;
        integer index = 0;
        Integer i = 1;
        string searchquery='select lastname, firstname, id, phone, account.name, accountid, email from contact  where  accountid=:accname OR  Firstname like \'%'+cont.firstname+'%\' OR  lastname like \'%'+cont.lastname+'%\' OR  email like \'%'+cont.email+'%\' OR  phone like \'%'+cont.phone+'%\' OR Account.Name like \'%'+accname+'%\'';  
        searchlist=database.Query(searchquery);
        system.debug(cont.firstname);
        for(contact c : searchlist){
            wrapList.add(new wrapperClass(c)); 
            mapAccount.put(index,wrapList);
            if(i==10){
                wrapList = new List<wrapperClass>();
                i=1;
                index++;
            }
            i++;
        }
        system.debug('1 map'+mapAccount.get(0));
        system.debug('2 map'+mapAccount.get(1));
        
    }
    
    public void checkMainSelect(){
        for(wrapperClass wa : mapAccount.get(Counter)){
            if(!wa.isEdit ){              
                checkmain=false;
                break;    
            }             
            checkmain=true;      
        }
      
    }
    
    public void checkall(){
         for(Integer i=0;i<mapAccount.get(Counter).size();i++){
             mapAccount.get(Counter)[i].isEdit=checkmain;
         }
    }
    
    public Void save() {
        List<Contact> selectedContact = new List<Contact>();
            for(integer ind : mapAccount.keySet()){
                for (wrapperClass wrapcontobj : mapAccount.get(ind)) {
                    if (wrapcontobj.isEdit==true) {
                        selectedContact.add(wrapcontobj.cont );
                    }           
                }           
            }
                          
        update selectedContact;
        search();
       
    }  
     
    public Pagereference View(){
        return new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/NewView?id=' + selectcontact);      
    }
    
    public void Del(){
        List<contact> cnt1=new List<contact>([select LastName from contact where id =:selectcontact]);
        try{
            delete cnt1;
        }
        Catch(Exception e){
            ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.FATAL,'This record is associated with Cases');
            ApexPages.addMessage(myMsg1);  
        }
        search();
    //return null;
    }  
    
    public Void Beginning() { //user clicked beginning
        Counter = 0;
    }
    
    public Void Previous() { //user clicked previous button
          if(Counter > 0)
            Counter--;
    }
    
    public Void Next() { //user clicked next button
          if(Counter < mapAccount.size()-1)
            Counter++;
    }
    
    public Void End() { //user clicked end
          Counter = mapAccount.size()-1;
    }
    
    public class wrapperClass{
        public Boolean isEdit{get;set;}
        public Contact cont {get;set;}
        public wrapperClass(Contact con){
            this.cont = con;         
        }
    }
}