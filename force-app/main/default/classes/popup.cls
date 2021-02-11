public class popup
{    
    public boolean displayPopup {get; set;}  
    public Account acc{get;set;}  
   
   
   public popup(){
   		acc= new Account();
   }
   
    public void closePopup()
    {   
    	insert acc;    
        displayPopup = false;   
    }    
    public void showPopup()
    {       
        displayPopup = true;   
    }   
  }