@RestResource(urlMapping='/api/Account/*')
global with sharing class MyFirstRestAPIClass
{
    @HttpGet
    global static Account doGet() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String AccEmail = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account where email__c =: AccEmail ];
        return result;
    }

    @HttpDelete
    global static void doDelete() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String AccEmail = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE email__c =: AccEmail ];
        delete result;
    }

    @HttpPost
    global static void doPost(String name,String phone,String AccountNumber, String sEmail ) 
    {
        RestResponse responseWithHeaders = RestContext.response;
        Response response = new Response();
        Account acc = new Account();
        acc.name= name;
        acc.phone=phone;
        acc.AccountNumber =AccountNumber ;
        acc.email__c = sEmail;
        insert acc;
        response.id = acc.id;
        response.code = '101';
        response.message = 'Account created';
        responseWithHeaders.statusCode = 202;
        responseWithHeaders.responseBody = Blob.valueOf(JSON.serialize(response));
        return;
    }
    
    global class Response {     
        global string id;
        global string code;
        global string message;
    }

}