public class ProductDetailController {
    //Here we are setting up the variables, these are what are used in the Visualforce page
    public String productName {get;set;}
    public String productDescription {get;set;}
    public String productWeight {get;set;}
    
    public ProductDetailController(){
        //Here were are getting the current User's langauge
        String userLanguage = [Select id, LanguageLocaleKey from User where id =: UserInfo.getUserId()].LanguageLocaleKey;
        
        //Here we are getting the Product record from URL
        Product2 prd = [select id, Name, Description, Product_Weight__c from Product2 where id =: ApexPages.currentPage().getParameters().get('id')];
        
        //Now, we're check ing if current User's langauge is not English
        if (userLanguage != 'en_US'){
            //If so, then get Product Translation record that matches the current User's langauge
            Product_Translation__c prdTrns = [select id, Name, Product_Name_Translated__c, Product_Description_Translated__c, Product_Weight_Translated__c from Product_Translation__c where name =: userLanguage AND Product__c =: prd.id];
            
            //And then we'll set the variables based on the Product_Translation__c record
            productName = prdTrns.Product_Name_Translated__c;
            productDescription = prdTrns.Product_Description_Translated__c;
            productWeight = prdTrns.Product_Weight_Translated__c;
            
        } 
        //But if not, meaning the current User's langauge is English, we'll set the variables based on the Product record
        else {
            productName = prd.Name;
            productDescription = prd.Description;
            productWeight = prd.Product_Weight__c;
        }
    }
}