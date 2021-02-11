public with sharing class ConvertLead{

    private boolean buttonconvertmanual;
    
    
    public Lead opportunityRecord {get; private set;}
    
    public boolean getButtonConvertManual(){
        return buttonconvertmanual;
    }
   
    public ConvertLead(ApexPages.StandardController stdController) {
        this.opportunityRecord = (Lead)stdController.getRecord();
        enableDisableCustomButtons();
    }
    
    private void enableDisableCustomButtons(){
        // IF Stage = Prospecting THEN 
        // disable Prospecting button and enable Closed Won and Closed Lost buttons
        if(opportunityRecord.Status == 'Closed - Not Converted'){
            buttonconvertmanual= true;
           
        }
        // IF Stage = Closed Won or Closed Lost THEN 
        // enable Prospecting button and disable Closed Won and Closed Lost buttons
        else{
            buttonconvertmanual= false;
            
        }
   }

}