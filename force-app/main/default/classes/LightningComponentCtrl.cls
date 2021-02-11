public class LightningComponentCtrl {

    @AuraEnabled
    public static boolean returnStatus(String recId){
        Account acc = [Select AccountSource, Id from Account where Id =: recId];
        if(acc.AccountSource == 'Web'){
            return true;
        }
        else{
            return false;
        }
    }
}