public class OpportunityUpload {
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    public List<Room__c> acclist{get;set;}
    public id pageid{get;set;}
    
    public OpportunityUpload(ApexPages.StandardController controller) {
        csvFileLines = new String[]{};
        acclist = New List<Room__c>();
        pageid=apexpages.currentpage().getparameters().get('id');
    }
    
    public void importCSVFile(){
       try{
           acclist.clear();
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            
           for(Integer i=1;i<csvFileLines.size();i++){
               Room__c accObj = new Room__c() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               //accObj.name = csvRecordData[0] ;             
               accObj.Room_No__c  = csvRecordData[0];
               accObj.Type__c = csvRecordData[1];
               accObj.opportunity__c= pageid;
               //accObj.Price__c= decimal.valueof(csvRecordData[2]);   
               //accObj.Industry = csvRecordData[4];                                                                             
               acclist.add(accObj);   
           }
        //insert acclist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
  public void upload(){
      if(acclist.size()>0){
          upsert acclist;
      }
  }

}