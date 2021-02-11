public class SearchContatcInLineCtrl {
    public Contact cont{get;set;}
    string accname{get;set;}
    public list<contact> searchlist{get;set;}
    public Boolean allChecked { get; set; }
    public List<wrapperClass> wrapList{get;set;}
    public string selectcontact{get;set;}
    public integer counter=0;  //keeps track of the offset
    public integer list_size=5; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list

    public SearchContatcInLineCtrl(ApexPages.StandardController controller) {
        this.cont=(contact)controller.getRecord();
        wrapList = new List<wrapperClass>();
        allChecked = false;
    }
    
    public void finalQuery(){
        accname = cont.accountid;
        string searchquery='select lastname, firstname, id, phone, account.name, accountid, email from contact  where  accountid=:accname OR  Firstname like \'%'+cont.firstname+'%\' OR  lastname like \'%'+cont.lastname+'%\' OR  email like \'%'+cont.email+'%\' OR  phone like \'%'+cont.phone+'%\' OR Account.Name like \'%'+accname+'%\' limit :list_size offset :counter';   
        searchlist=Database.query(searchquery);
        
        wrapList = new List<wrapperClass>(); 
        for(contact c : searchlist){
            wrapList.add(new wrapperClass(c));      
        }
    }
    
    public void search(){
        accname = cont.accountid;
        finalQuery();
        string searchquery='select count() from contact  where  accountid=:accname OR  Firstname like \'%'+cont.firstname+'%\' OR  lastname like \'%'+cont.lastname+'%\' OR  email like \'%'+cont.email+'%\' OR  phone like \'%'+cont.phone+'%\'';  
        total_size=database.countQuery(searchquery);  
    }
    
    public void CheckAll(){
        for(wrapperClass contact : wrapList){
            if(allChecked== true){
                contact.isEdit= true;
            }
            else{
                contact.isEdit= false;
            }
        }
    }
    
    public Void save() {
        List<Contact> selectedContact = new List<Contact>();
            for (wrapperClass wrapcontobj : wrapList) {
                if (wrapcontobj.isEdit) {
                    if(wrapcontobj.cont.LastName==''){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'You must enter a value in Last Name'));
                    }
                else{
                    selectedContact.add(wrapcontobj.cont );
                }           
                }           
            }
                          
        update selectedContact;
        wrapList = new List<wrapperClass>();
        List<contact> contList = new List<contact>();
        contList=[select lastname, firstname, id, phone, account.name, accountid, email from contact  where  accountid=:accname OR  Firstname like :'%'+cont.firstname+'%' OR  lastname like :'%'+cont.lastname+'%' OR  email like :'%'+cont.email+'%' OR  phone like :'%'+cont.phone+'%' oR Account.Name like :'%'+accname+'%' limit :list_size offset :counter];
            for(contact c : contList){
                wrapList.add(new wrapperClass(c));        
            }          
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
    counter = 0;
    finalQuery();
    }
    
    public Void Previous() { //user clicked previous button
          counter -= list_size;
          finalQuery();
    }
    
    public Void Next() { //user clicked next button
          counter += list_size;
          finalQuery();
    }
    
    public Void End() { //user clicked end
          counter = total_size - math.mod(total_size, list_size);
          finalQuery();
    }
    
    public Boolean getDisablePrevious() { 
          //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } 
        else {
            return (total_size/list_size);
        }
    }
    
    public class wrapperClass{
        public Boolean isEdit{get;set;}
        public Contact cont {get;set;}
        public wrapperClass(Contact con){
            this.cont = con;         
        }
    }
}