trigger UserUpdate on User (before update) {
    for(user uu: trigger.new){
        uu.test__c= uu.LastLoginDate;
        uu.testtext__c='Text';
        
    }
}