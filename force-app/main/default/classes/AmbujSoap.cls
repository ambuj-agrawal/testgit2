Public class AmbujSoap{
    
    public void met(){
        
        String username      = 'Singerindia\\Lokesh';
        String password      = 'Welcome@123';  
        
        HttpClient httpObj   = new HttpClient(username,password,True);      
        HttpRequest req      = new HttpRequest(); 
        
        Map<String,String> headerMap = new Map<String,String>();
        headerMap.put('SOAPAction','ReadMultiple');
        headerMap.put('Content-Type','text/xml;charset=UTF-8');
        headerMap.put('Accept-Encoding','gzip,deflate');
        
        //String requestString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cus="urn:microsoft-dynamics-schemas/page/customer"><soapenv:Header/><soapenv:Body><cus:Create><cus:Customer></cus:Customer></cus:Create></soapenv:Body></soapenv:Envelope>';
        String requestString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cus="urn:microsoft-dynamics-schemas/page/customer"><soapenv:Header/><soapenv:Body><cus:ReadMultiple><cus:filter><cus:Field></cus:Field><cus:Criteria></cus:Criteria></cus:filter><cus:setSize>3</cus:setSize></cus:ReadMultiple></soapenv:Body></soapenv:Envelope>';
        System.debug('##BODY: '+requestString);
        req.setEndpoint('http://125.16.162.238:7047/DynamicsNAV90/WS/Singer%20India%20Limited/Page/Customer');
        req.setMethod('POST');
        req.setTimeout(120000);
        req.setBody(requestString);
        Httpresponse res = new Httpresponse();
        res = httpObj.send(req,headerMap);
        System.debug('Response**:' + res);
        System.debug('Response**:' + res.getBody());
        
        XMLParser pars=new XMLParser(res.getBody());
    }
}