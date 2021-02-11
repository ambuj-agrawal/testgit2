public class Sendsms

{

   public String phNumber{get;set;}

   public String smsBody{get;set;}

   String accountSid;

   string token;

   String fromPhNumber;

   errorResponseWrapper erw;

   public sendsms(){

      phNumber ='+'+Apexpages.currentpage().getparameters().get('phNumber');

       accountSid = 'AC1e4ce7d9725cc6d33d3879aae60a1ec9';

       token = '6cc13c9ec3ae48b971fbb6b80b4f89b4';

       fromPhNumber = '+19382230759';

   }

 public void processSms(){

       HttpRequest req = new HttpRequest();

       req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');

       req.setMethod('POST');

       String VERSION  = '3.2.0';

       req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);

       req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);

       req.setHeader('Accept', 'application/json');

       req.setHeader('Accept-Charset', 'utf-8');

       req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));

       req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);

       Http http = new Http();

       HTTPResponse res = http.send(req);

       System.debug(res.getBody());

       if(res.getStatusCode()==201)

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));

       else{

           erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,erw.message));

       }

   }

   public class errorResponseWrapper{

       String code;

       String message;

       String moreInfo;

       String status;    

   }

}