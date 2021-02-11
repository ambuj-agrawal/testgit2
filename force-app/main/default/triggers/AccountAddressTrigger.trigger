trigger AccountAddressTrigger on Account (after insert, after update) {
    
    for(Account a: trigger.new){
        AccountAddressHandler.addresss(a.id);    
    }
    
    
}