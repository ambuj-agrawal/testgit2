public class LookupByUrlParamController {

    String accountName;
    String accountNumber;
    String phone;
    String website;
    String email;
    String socialhandle;
    
    public LookupByUrlParamController () { }

    public String redirectToAccount() {
        
        Account account;
        
        Map<String,String> params = ApexPages.currentPage().getParameters();
        if(params.size() > 0) {
            accountName = params.get('account_name');
            accountNumber = params.get('account_number');
            phone = params.get('phone');   
            website =  params.get('website');   
            email =  params.get('email');
            socialhandle =  params.get('SocialHandle');
        }
        
        try {
            if(accountName != null) {
                account = [select ID from Account where name = :accountName limit 1];   
            } 
        } catch (System.queryException e) {//no entry found for lookup item, display empty account page
            return 'https://na7.salesforce.com/001/e';
        }    
          
        try {
            if(accountNumber != null) {
                account = [select ID from Account where AccountNumber = :accountNumber limit 1];   
            }
         } catch (System.queryException e) {//no entry found for lookup item, display empty account page
            return 'https://na7.salesforce.com/001/e';
         }   
            
        try {
             if(phone != null) {
                
                String npa;
                String nnx;
                String extension;
        
                //  Added logic for NA phone numbers

                if (phone.length() == 10) {
                    npa = phone.substring(0,3);
                    nnx = phone.substring(3,6);
                    extension = phone.substring(6,10);
                    phone = '(' + npa + ') ' + nnx + '-' + extension;
                }

                account = [select ID from Account where phone = :phone limit 1]; 
             }
        } catch (System.queryException e) {//no entry found for lookup item, display empty account page
            return 'https://na7.salesforce.com/001/e';
        }        
            
        try {     
             if(website != null) {
                account = [select ID from Account where website = :website limit 1]; 
             }
         } catch (System.queryException e) {//no entry found for lookup item, display empty account page
            return 'https://na7.salesforce.com/001/e';
         }       
            
         try {
              if(email != null) {
                account = [select ID from Account where email__c = :email limit 1]; 
              }
         } catch (System.queryException e) {//no entry found for lookup item, display empty account page
             return 'https://na7.salesforce.com/001/e';
         }   
             
         try {
              if(socialhandle != null) {
                account = [select ID from Account where SocialHandle__c = :socialhandle limit 1]; 
              }
         } catch (System.queryException e) {//no entry found for twitter handle lookup item, display empty account page
             return 'https://na7.salesforce.com/001/e';
         }      
       
        
        String accountUrl;
        if(account != null) {
            accountUrl = '/' + account.Id;
        } else {
            accountUrl = '/';
        }
        
        return accountUrl;
    }   

    public static testMethod void testLookupByUrlParamAccount() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        controller.accountName = 'Avaya';
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, '/001A0000007UkkFIAS');
    }
    
    public static testMethod void testLookupByUrlParamInvalidAccount() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        controller.accountName = '';
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, 'https://na7.salesforce.com/001/e');
    }
    
    public static testMethod void testLookupByUrlParamPhone() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        controller.phone = '1234';
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, '/001A0000007UkkFIAS');
    }
    
     public static testMethod void testLookupByUrlParamWherePhoneNumberIs10Chars() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        controller.phone = '1234567891';
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, 'https://na7.salesforce.com/001/e');//no record found
       
    }
    
    public static testMethod void testLookupByUrlParamInvalidPhoneNumber() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        controller.phone = '';
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, '/001A0000015EKVPIA4');
        
    }
    
    public static testMethod void testLookupByUrlParamAccountNumber() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        controller.accountNumber = '4321';
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, '/001A0000007UkkFIAS');
    }
    
    public static testMethod void testLookupByUrlParam() {
        LookupByUrlParamController controller = new LookupByUrlParamController();
        String redirectUrl = controller.redirectToAccount();
        System.assertEquals(redirectUrl, '/');
    }
    
}