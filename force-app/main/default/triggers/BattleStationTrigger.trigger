trigger BattleStationTrigger on Battle_Station__c (after insert) {
    for(Battle_Station__c b : trigger.new){
        system.debug(b);
    }
    for (ApexPages.Message message:ApexPages.getMessages()) {
        system.debug(message);
    }
}