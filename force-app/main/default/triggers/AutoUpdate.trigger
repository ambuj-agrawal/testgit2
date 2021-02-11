trigger AutoUpdate on Account (before insert) {
    if(trigger.isbefore && trigger.isInsert){
        Date dateToday = Date.today();
        String sMonth = String.valueof(dateToday.month());
        String sDay = String.valueof(dateToday.day());
        if(sMonth.length()==1){
          sMonth = '0' + sMonth;
        }
        if(sDay.length()==1){
          sDay = '0' + sDay;
        }
        String sToday = sDay +'/'+ sMonth +'/'+ String.valueof(dateToday.year());
        integer i= 1;
        string ss= sToday+ '%';
        list<Account> acc=[select name, AutoUpdate__c from account where AutoUpdate__c like : ss];
        system.debug(acc);
        if(acc.size()== 0){
            i=1;
        }
        else{
            i= acc.size() +1;
        }
        for(Account a:trigger.new){
            a.AutoUpdate__c = sToday + '-' +i;
        }
    }
}