trigger EmailDuplicate on Lead (before Insert) {

    for(lead l: trigger.new){
        list<lead> l1 =[select name, id from lead where Email =: l.email];
        if(l1.size() > 0){
            l.adderror('Duplicate Lead');
        }
    }

}