public class checkBoxEdit{

    public List<Contact> contList {get;set;}
    public List<wrapperClass> wrapList{get;set;}

    public wrapperClass wrap{get;set;}   
     
    public checkBoxEdit(){
        wrapList = new List<wrapperClass>();
        contList = new List<contact>();
        contList = [Select Id,Name,Email,LastName From Contact];
        for(contact c : contList){
             wrapList.add(new wrapperClass(c));      
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