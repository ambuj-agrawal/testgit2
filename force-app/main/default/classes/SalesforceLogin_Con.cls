public class SalesforceLogin_Con {
    
    public String username{get;set;}
    public String password{get;set;}
    public String domain{get;set;}

    public Pagereference doLogin(){
        Pagereference loginReference;
        try{
            
            String loginRes = sendLoginRequest(username,password,domain);
            if(!String.isBlank(loginRes) && !loginRes.containsIgnoreCase('INVALID_LOGIN')){
                Dom.Document loginDoc = new Dom.Document();
                loginDoc.load(loginRes);
                Dom.XmlNode resultElmt = loginDoc.getRootElement()
                  .getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/')
                  .getChildElement('loginResponse','urn:partner.soap.sforce.com')
                  .getChildElement('result','urn:partner.soap.sforce.com');
                /*Extract the session Id and Server url*/
                String serverurl = resultElmt.getChildElement('serverUrl','urn:partner.soap.sforce.com').getText().split('/services')[0];
                String sessionId = resultElmt.getChildElement('sessionId','urn:partner.soap.sforce.com').getText();
                /*Use frontdoor.jsp to login to salesforce*/
                loginReference =  new Pagereference(serverurl+'/secur/frontdoor.jsp?sid='+sessionId);
            }
            else{
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please check your Username and Password.'));
            }
       }
       catch(Exception ex){
            Apexpages.addMessages(ex);
       }
        
        return loginReference;
    }
    
    /*Method to send login request using using SOAP*/
    private static String sendLoginRequest(String un,String pw,String domain){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + domain + '.salesforce.com/services/Soap/u/30.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', '""');
        request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + un + '</username><password>' + pw + '</password></login></Body></Envelope>');
        Http h = new Http();
        HttpResponse res = h.send(request);
        return res.getBody();
    } 
}