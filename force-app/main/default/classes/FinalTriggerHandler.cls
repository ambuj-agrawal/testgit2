public class FinalTriggerHandler {
    private static Set<Id> getAccountSet(List<Contact> contactList, Map<Id,Contact> oldMap){
        Set<Id> AccId = new Set<Id>();    
        for(Contact c : contactList){                
            AccId.add(c.AccountId);            
            if(oldMap.size()>0){ 
                if(c.AccountId != oldMap.get(c.Id).AccountId){
                    AccId.add(c.AccountId);                     
                    AccId.add(oldMap.get(c.Id).AccountId);                
                }                      
            }                
        }
        return AccId;
    }    
       
    //Id after Insert
    public static void afterInsert(List<Contact> contactList){
        Set<Id> AccId = getAccountSet(contactList, new Map<Id,Contact>()); 
        CalculateAmount(AccId);                                   
    }      
   
   //Id after Update
    public static void afterUpdate(List<Contact> contactList, Map<Id,Contact> oldMap){
        Set<Id> AccId = getAccountSet(contactList, oldMap);      
        CalculateAmount(AccId);
    }     
    
    //Id after Delete
    public static void afterDelete(List<Contact> contactList){
        Set<Id> AccId = getAccountSet(contactList, new Map<Id,Contact>());       
        CalculateAmount(AccId);
    }    
    
    //Id after Undelete
    public static void afterUndelete(List<Contact> contactList){
        Set<Id> AccId = getAccountSet(contactList, new Map<Id,Contact>());
        CalculateAmount(AccId);
    } 
         
                                 
    // Calculate Amount
    public static void CalculateAmount(Set<id> SetId){                
        
        List<Contact> contactList = [select Id,AccountId,Amount__c,Amount_x__c,Amount_Y__c,Status__c from Contact where AccountId IN : SetId];               
        Map<Id,Account> mapToAcc = new Map<Id,Account>();
        
        for(Contact c : contactList){ 
            if(c.Amount_Y__c!=null && c.Status__c=='Negative'){                        
                Account acc = new Account();                
                if(mapToAcc.get(c.AccountId) != null){
                    acc = mapToAcc.get(c.AccountId);
                    if(acc.Amount_Y__c == null)
                        acc.Amount_Y__c = 0;
                        
                    acc.Amount_Y__c +=  c.Amount_Y__c;
                    mapToAcc.put(c.AccountId,acc);
                }else{
                    acc.Amount_Y__c = c.Amount_Y__c;
                    mapToAcc.put(c.AccountId,acc);
                }
            } 
            if(c.Amount_X__c !=null && c.Status__c=='Positive'){
                Account acc = new Account();                
                if(mapToAcc.get(c.AccountId) != null){
                    acc = mapToAcc.get(c.AccountId);
                    if(acc.Amount_X__c == null)
                        acc.Amount_X__c = 0;
                        
                    acc.Amount_X__c +=  c.Amount_X__c ;
                    mapToAcc.put(c.AccountId,acc);
                }else{
                    acc.Amount_X__c = c.Amount_X__c;
                    mapToAcc.put(c.AccountId,acc);
                } 
            }
            if(c.Amount__c !=null){
                Account acc = new Account();                
                if(mapToAcc.get(c.AccountId) != null){
                    acc = mapToAcc.get(c.AccountId);
                    if(acc.TotalAmount__c == null)
                        acc.TotalAmount__c = 0;
                        
                    acc.TotalAmount__c +=  c.Amount__c;
                    mapToAcc.put(c.AccountId,acc);
                }else{
                    acc.TotalAmount__c = c.Amount__c;
                    mapToAcc.put(c.AccountId,acc);
                }                  
            }      
        }
        List<Account> accList=new List<Account>([select id,TotalAmount__c,Amount_X__c,Amount_Y__c from Account where Id IN:SetId]);
        
        for(Account acc : accList){
            if(mapToAcc.get(acc.Id) != null){
                acc.TotalAmount__c = mapToAcc.get(acc.Id).TotalAmount__c;
                acc.Amount_X__c = mapToAcc.get(acc.Id).Amount_X__c;
                acc.Amount_Y__c = mapToAcc.get(acc.Id).Amount_Y__c;
            }else{
                acc.TotalAmount__c = 0;
                acc.Amount_X__c = 0;
                acc.Amount_Y__c = 0;
                
            }
        }
        update accList;
        
    }
}