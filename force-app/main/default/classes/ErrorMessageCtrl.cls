public class ErrorMessageCtrl {
    public ErrorMessageCtrl(ApexPages.StandardController controller){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'First Error Message added from apex'));
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Second Error Message added from apex'));
        
    }
}