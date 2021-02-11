public class CurrencyConversionCtrl {
    
    public account acc{get;set;}
    public account acc1{get;set;}
    public string rate{get;set;}
    
    public CurrencyConversionCtrl(){
        acc= new account(); 
        acc1= new account(); 
        rate='';       
    }
    
    public void convert(){
    
        string LONG_RUNNING_SERVICE_URL = 'http://free.currencyconverterapi.com/api/v5/convert?q=';
                                        
                                        
                                          LONG_RUNNING_SERVICE_URL=LONG_RUNNING_SERVICE_URL +acc.currency_test__c +'_'+acc1.currency_test__c +'&compact=y';
                                          HttpRequest req = new HttpRequest();
                                            Http http = new Http();
                                            // set the method
                                            req.setMethod('GET');
                                            
                                            req.setEndpoint(LONG_RUNNING_SERVICE_URL);
                                            // create the response object
                                            HTTPResponse resp = http.send(req);
                                                //system.debug(resp.getBody());
                                                String rows= '';
                                                JSONParser parser = JSON.createParser(resp.getBody());
                                                while (parser.nextToken() != null) {
                                                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                                                        String fieldName = parser.getText();
                                                        parser.nextToken();
                                                        //get the access_token value
                                                        //system.debug(fieldname);
                                                        if(fieldName == 'val') {
                                                            rows= parser.getText();
                                                            //System.debug('>>>access_token'+rows);
                                                            if(rows != null){
                                                                rate=rows;
                                                            }
                                                         }
                                                      }
                                                 }
    
    }
}