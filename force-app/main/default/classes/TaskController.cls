public class TaskController {
    public Double valueLong { get; set; }
    public Double valueLat { get; set; }
    public task tt{get;set;}
    
    Public TaskController(){
        tt= [Select Subject, Priority, Get_Location__c from task where id=: apexpages.currentpage().getparameters().get('id')];
    }
    public PageReference iFoundYou() {
        tt.Priority = 'Low';
        tt.Get_Location__Latitude__s= valueLat;
        tt.Get_Location__Longitude__s= valueLong;  
        update tt;
        PageReference pr = new PageReference('/' +apexpages.currentpage().getparameters().get('id'));
        return pr; 
        
    }
    /*public PageReference Updatetask(){
        tt.Priority = 'Low';
        tt.Get_Location__Latitude__s= valueLat;
        tt.Get_Location__Longitude__s= valueLong;  
        update tt;
        PageReference pr = new PageReference('/' +apexpages.currentpage().getparameters().get('id'));
        return pr;  
    }*/
    
}