trigger FinalTrigger on Contact (after insert, after delete, after undelete, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
                FinalTriggerHandler.afterInsert(Trigger.new);                   
        }    
        if(Trigger.isUpdate){
                FinalTriggerHandler.afterUpdate(trigger.New,Trigger.oldMap);                        
        }
        if(Trigger.isDelete){
                FinalTriggerHandler.afterDelete(Trigger.old);                       
        }    
        if(Trigger.isUndelete){
                FinalTriggerHandler.afterUndelete(Trigger.new);              
        }                                                    
    }

}