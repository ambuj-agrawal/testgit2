Public class AccountContactController{
      public List<Account> acc{get;set;}
      public map<string,Boolean> mapset{get;set;}
      public string selectedContact{get;set;}
      
public AccountContactController(){
      acc= new List<Account>();
      mapset=new map<string,Boolean>();
      SelectedContact='';
      acc=[Select Name, (Select Name, Email from Contacts) from Account];
      for(Account accou: acc){
      mapset.put(accou.id,false);
      }        
}

Public void ChangeStatus(){
      for(string str: mapset.keyset()){
      if(str==selectedContact){
      mapset.put(str,true);
       }
       }
}
}