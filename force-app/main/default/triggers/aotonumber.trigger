trigger aotonumber on Contact (before insert, before update) {
     Recordtype recId=[select id, name from recordtype where sobjectType='Contact' and name = 'Test Auto'];
     list<Contact> Acc= [SELECT Id, Auto1__c FROM Contact WHERE Auto1__c !=:null order by Auto1__c desc limit 1];
     decimal maxlead;
            if(acc.size() > 0){
                maxlead = Acc[0].Auto1__c; 
            }
            else     
                maxlead = 0;   

    for(Contact Acci:Trigger.new){
        if(Acci.RecordTypeId == recId.Id){
            Acci.Auto1__c = Integer.valueOf(maxlead)+1;
            maxlead++;
        }
        else if(Acci.RecordTypeId !='01228000000yYJMAA2'){    //region corresponds to 'ROW' 
                
                acci.Auto1__c= null;
            }
    }  
}