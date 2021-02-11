public with sharing class SearchContactcontroller {  
   public list <Contact> con {get;set;}
   public contact cont{get;set;}
   Public Boolean showTable{get;set;} 
   Public Boolean showEdit{get;set;} 
   public string fname {get;set;}
   public string lname {get;set;}
   public string phn {get;set;}
   public string mail {get;set;}
   public account acc{get;set;}
   public boolean flag{get;set;}
   public String quest{get;set;}
   public String selectedContact{get;set;}
   public Map<String,Boolean> contactshowMap{get;set;}
   
   
   public SearchContactcontroller(ApexPages.StandardController controller) {  
   con= new list <Contact>();
   contactshowMap= new Map<String,Boolean>();
   flag=false;
   showTable=false;
   selectedContact='';
   cont=new Contact();
   acc=new Account();
   }  
   public void fetchMemberDetails(){
   acc.clear();
   acc=[select Name from Account where Id =:cont.AccountId];
   system.debug(acc.name);
   }
   
   public void search(){ 
     showTable=true;
     
     quest ='Select FirstName, LastName, Email, Phone, Account.Name From Contact'; 
        if(fname!=null && fname!=''){
               quest += ' where FirstName like \'%'+fname+'%\'';
               flag=true;               
          }
        if(lname!=null && lname!=''){
                if(flag){
                   quest +='and';
                }
                else{
                    quest +=' where';
                    flag=true;
                }
                 quest += ' LastName like \'%'+lname+'%\'';
          }
        if(mail!=null && mail!=''){
                if(flag){
                   quest +='and';
                }
                else{
                    quest +=' where';
                    flag=true;
                }
                quest += ' Email like \'%'+mail+'%\'';
          }  
        if(phn!=null && phn!=''){
                if(flag){
                   quest +='and';
                }
                else{
                    quest +='  where';
                    flag=true;
                }
                quest += ' Phone like \'%'+phn+'%\'';                
          }
        if(acc.Name!=null && Acc.Name!=''){
                if(flag){
                   quest +='and';
                }
                else{
                    quest +='  where';
                    flag=true;
                }
                quest += ' Account.Name like \'%'+acc.name+'%\''; 
                              
          }
             con=Database.query(quest);    
             
             //system.debug(con); 
                    
       }
            
             public void showEdit(){
             }
     //con=[select FirstName,LastName,Email,Phone, Account.Name from contact where FirstName like :'%'+fname+'%' AND lastName like :'%'+lname+'%' AND Email like :'%'+mail+'%' AND Phone like :'%'+phn+'%' AND Account.Name like: '%'+acc.name+'%'];
     //con=[select FirstName,LastName,Email,Phone, Account.Name from contact where Account.Name like: '%'+acc.name+'%'];  
     //system.debug(acc.name);
     
   }