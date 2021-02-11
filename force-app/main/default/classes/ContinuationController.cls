public with sharing class ContinuationController {
    // Unique label corresponding to the continuation
    public String requestLabel;
    // Result of callout
    public String result {get;set;}
    // Callout endpoint as a named credential URL 
    // or, as shown here, as the long-running service URL
    private static final String LONG_RUNNING_SERVICE_URL = 
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=km&origins=28.622853,77.296697&destinations=28.5053730,77.0964120';
   
   // Action method
    public Object startRequest() {
      // Create continuation with a timeout
      Continuation con = new Continuation(60);
      // Set callback method
      con.continuationMethod='processResponse';
      
      // Create callout request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint(LONG_RUNNING_SERVICE_URL);
      system.debug(LONG_RUNNING_SERVICE_URL);
      // Add callout request to continuation
      this.requestLabel = con.addHttpRequest(req);
      
      // Return the continuation
      return con;  
      //system.debug(con);
    }
    
    // Callback method 
    public Object processResponse() {   
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(this.requestLabel);
      // Set the result variable that is displayed on the Visualforce page
      this.result = response.getBody();
      //List<object> fieldList = (List<object>)JSON.deserializeUntyped('response.getBody()');
      system.debug(result);
      // Return null to re-render the original Visualforce page
      return null;
    }
}