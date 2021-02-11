trigger AdditionUsingHandler on Contact (after insert,after update, after delete, after undelete) {
    Set<ID> setAccountIDs = new Set<ID>();
        if(Trigger.isInsert|| Trigger.isUpdate||Trigger.isUndelete){
            for(Contact c : Trigger.new){
                setAccountIDs.add(c.AccountId);
            }
            
        }
        if(Trigger.isDelete|| Trigger.isUpdate){
            for(Contact c : Trigger.Old){
                setAccountIDs.add(c.AccountId);
            }
        }
           Handler.calsi(setAccountIDs);
           HandlerAmount.calsi(setAccountIDs);
    
}