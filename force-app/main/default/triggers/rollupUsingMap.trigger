trigger rollupUsingMap on Contact (after insert,after update,after delete,after undelete) {    
    Set<ID> AccId=new Set<ID>();
    List<Account> AccList=new List<Account>();
     
    if(Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate){
        for(Contact con:Trigger.new){
            AccId.add(con.AccountId);
            system.debug('cont2---->'+con);
        }
    }
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Contact con:Trigger.old){
            AccId.add(con.AccountId);
            system.debug('cont3---->'+con);
        }
    }
            
        Map<ID,AggregateResult> conMap=new Map<ID,AggregateResult>([select AccountId Id,sum(Amount__c)amt from contact where AccountId IN:AccId group by AccountId]);            
        for(AggregateResult ar: conMap.values()){
        Account accObj = new Account();
       // accObj.Id = ar.Id;
        accObj.Id=conMap.get(ar.Id).Id;
        System.debug('Id--->'+accObj.Id);
        accObj.TotalAmount__c= (Decimal)ar.get('amt');
        AccList.add(accObj); 
        
        system.debug('cont4---->'+ar);        
        }
        update AccList;
}