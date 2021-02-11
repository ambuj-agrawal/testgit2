Public class ObjectFieldController{
    public Map <String, Schema.SObjectType> schemaMap;

    public String selectedObject {get; set;}
    public String selectedField {get; set;}
    public Map<String,String> tableDataMap{get;set;}
    public List<SelectOption> objNames{get;set;}

    //Constructor
    
    Public ObjectFieldController()
    {   
        schemaMap = Schema.getGlobalDescribe();
        tableDataMap=  new Map<String,String> ();
        selectedObject = 'account';
        selectedField = 'Id';
        objNames = new List<SelectOption>();
    }

    public void init(){
        tableDataMap.clear();
    }

    // Boolean Method to Return Selected Object
    
    public List<SelectOption> getObjectNames() 
    {
        objNames.clear();   
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        for(String name : entities)
        {
            objNames.add(new SelectOption(name,name));
        }
        return objNames;
     }

     // Boolean Method to Return Selected Field
        
     public List<SelectOption> getObjectFields() 
     {
            objNames.clear();
            Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);
            Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();
            List<SelectOption> fieldNames = new List<SelectOption>();  
            fieldNames.add(new SelectOption('None','None'));          
            for (String fieldName: fieldMap.keySet()) 
            {  
                fieldNames.add(new SelectOption(fieldName,fieldName));                                
            } 
            fieldNames.sort();           
            return fieldNames;
      }  
      
      // Method to get properties of Selected fields and Object
      
       public void PropertiesTable(){
                           
            objNames.clear();
            if(schemaMap.containskey(selectedObject)) {
            map<string,Schema.SObjectField> allFields= schemaMap.get(selectedObject).getdescribe().fields.getmap(); 
            
            //To Get label of Selected Field
                     
            String fieldLabel = allFields.get(selectedField).getDescribe().getLabel();
            
            //To Get Pbject Prefix of Selected Object
            
            Schema.DescribeSObjectResult r =  schemaMap.get(selectedObject).getDescribe();
            String tempPrefix = r.getKeyPrefix();
            
            //To Get Accessible Values of Selected Field
            
            String accessiblevalue=String.valueOf(allFields.get(selectedField).getDescribe().isAccessible());
            
            //To Get Createable Values of Selected Field
            
            String createablevalue=String.valueOf(allFields.get(selectedField).getDescribe().isCreateable());
            
            //To Get Updateable Values of Selected Field
            
            String updateablevalue=String.valueOf(allFields.get(selectedField).getDescribe().isUpdateable());
            
            //To Get Field Type of Selected Field
            
            String fieldtype=String.valueOf(allFields.get(selectedField).getDescribe().getType());            
            
            //To upload Values in Table throgh <Apex:Repeat>
            
            if(fieldLabel !=null && fieldLabel !='' ){
                tableDataMap.put('Label',fieldLabel);
            }else{
                tableDataMap.put('Label','Lable is N/A');
            }
             if(selectedField !=null && selectedField !=''){
                tableDataMap.put('Api Name',selectedField );
            }else{
                tableDataMap.put('Api Name','API Name is N/A' );
            }
            if(accessiblevalue !=null && accessiblevalue !=''){
                tableDataMap.put('Accssile',accessiblevalue);
            }else{
                tableDataMap.put('Accssile',' Accessible Value is N/A');
            }
            if(createablevalue !=null && createablevalue !=''){
                tableDataMap.put('Createable',createablevalue);
            }else{
                tableDataMap.put('Createable','Createable Value is N/A');
            }
            if(updateablevalue !=null && updateablevalue !=''){
                tableDataMap.put('Updateable',updateablevalue);
            }else{
                tableDataMap.put('Updateable','Updateable Value is N/A');
            }   
            if(fieldtype !=null && fieldtype !=''){
                tableDataMap.put('Field Type',fieldtype);
            }else{
                tableDataMap.put('Field Type','Field Type is N/A');
            }   
            if(tempPrefix !=null && tempPrefix !=''){
                tableDataMap.put('Object Prefix',tempPrefix);
            }else{
                tableDataMap.put('Object Prefix','Object Prefix is N/A');
            }               
        }     
}
}