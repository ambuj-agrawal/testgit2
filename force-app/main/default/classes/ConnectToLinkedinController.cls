public class ConnectToLinkedinController {
    public static final String authUrl = 'https://www.linkedin.com/oauth/v2/authorization';
    public static final String accessTokenUrl = 'https://www.linkedin.com/oauth/v2/accessToken';
    public static final String profileDataUrl = 'https://api.linkedin.com/v1/people/~';
    public LinkedinWrapper linkedWrap {get; set;}
    public Boolean isShowBtn{get; set;}
    public String message{get; set;}
    
    public ConnectToLinkedinController(){
        isShowBtn = false;
        if(String.isBlank(ApexPages.currentPage().getParameters().get('code'))){
            message = 'Click to Start Process.';
        }
        else{
            message = 'Click to Complete Authorization Process And then Click on Get Details.';
        }
    }
    //This Method to get Custom Setting
    public  LinkedinSettings__c getSettings(){
        return LinkedinSettings__c.getall().values().get(0);
    }
 
    //This Method to get Authorized Token
    public pageReference doAuthorization(){
        System.debug('>>>doAuthorization');
        PageReference linkedinAuth = new PageReference(authUrl+'?client_id='+String.valueOf(getSettings().ClientId__c)+'&scope=r_basicprofile&state=987654321&redirect_uri=https://ambuj-dev-ed--c.ap6.visual.force.com/apex/LinkedinIntegration&response_type=code');
        linkedinAuth.setRedirect(true);
        isShowBtn = true;
        return linkedinAuth;
    }
    
    //This Method to get Access Token
    public void getAccessToken(){
        System.debug('>>>>>Get Access Token');
        String endpoint = accessTokenUrl +'?';
        endpoint += 'grant_type=authorization_code';
        endpoint += '&code='+ApexPages.currentPage().getParameters().get('code');
        endpoint += '&redirect_uri=https://ambuj-dev-ed--c.ap6.visual.force.com/apex/LinkedinIntegration';
        endpoint += '&client_id='+String.valueOf(getSettings().ClientId__c);
        endpoint += '&client_secret='+String.valueOf(getSettings().ClientSecret__c);
            
        HttpRequest createReq = new HttpRequest();
        createReq.setEndpoint(endpoint);
        createReq.setMethod('GET');
        createReq.setHeader('Content-Type', 'application/json');
        
        Http http = new Http(); 
        HttpResponse createRes = http.send(createReq);
        
        System.debug('---------->'+createRes.getBody());
        
        String access_token = '';
        JSONParser parser = JSON.createParser(createRes.getBody());
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                //get the access_token value
                if(fieldName == 'access_token') {
                    access_token= parser.getText();
                    System.debug('>>>access_token'+access_token);
                }
            }
        }
        
        LinkedinSettings__c ls = getSettings();
        ls.AccessToken__c = access_token;
        update  new List<LinkedinSettings__c>{ls}; 
        message = 'Authorization Process Completed, Click on Get Details.';    
    }
    
    //This Method to get Profile Details
    public void getDetails(){
        String endpoint = profileDataUrl +'?';
        endpoint += 'oauth2_access_token=' + getSettings().AccessToken__c;
        endpoint +='&format=json';
        
        HttpRequest createReq = new HttpRequest();
        createReq.setEndpoint(endpoint);
        createReq.setMethod('GET');
        //createReq.setHeader('Content-Type', 'application/json');
        Http http = new Http(); 
        HttpResponse createRes = http.send(createReq);
        linkedWrap = (LinkedinWrapper) System.JSON.deserialize(createRes.getBody(), LinkedinWrapper.class);
        System.debug('---Final Details------->'+linkedWrap.firstName);
        
    }
    public class LinkedinWrapper{ 
        public String firstName{get; set;}  //yogesh
        public String headline{get; set;}   //3x Sr. Salesforce Certified Developer at paytm.
        public String id{get; set;} //rEYuj4K6jI
        public String lastName{get; set;}   //sharma
        public cls_siteStandardProfileRequest siteStandardProfileRequest;
     }
     public class cls_siteStandardProfileRequest {
            public String url;  //https://www.linkedin.com/profile/view?id=AAoAABTKFbwBdzAPj8nvQoSxfr9df-GPtx3J2Go&authType=name&authToken=vpYR&trk=api*a5092905*s5409425*
     }

}