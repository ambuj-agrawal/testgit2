trigger FinalRollUp3 on Contact (After insert, After Delete, After Undelete, after update) {
    if(trigger.isAfter){
        if(trigger.isInsert||trigger.IsUndelete||trigger.isUpdate){
            AmountRollUp.AmountRoll(Trigger.new);   
        }
        
        if(trigger.isDelete||trigger.isUpdate){
            AmountRollUp.AmountRoll(Trigger.old); 
        }
    }
}