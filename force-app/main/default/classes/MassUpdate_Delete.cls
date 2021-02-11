public class MassUpdate_Delete
{
    Map<String,Schema.SObjectType>gd=Schema.getGlobalDescribe();
    public List<SelectOption> listOfObject {get; set;}
    public String objectName {get;set;}
    Schema.SObjectType sobj=gd.get(objectName);
    Map<String, Schema.SObjectField> fieldsMap;
    public selectOption[] fieldList {get;set;}
    public String Selectedfield {get;set;}
    public String SelectedOperator {get;set;}
    public selectOption[] listOperators{get;set;}
    public String valueForSearch{get;set;}
    public List<sObject> lst{get;set;}
    public String fieldtoUpdate{get;set;}
    public String valuetoUpdate{get;set;}
    public String FilterValue{get;set;}
    public Integer rowCount{get;set;}
    public List<addRowWrapper> wrapperList{get;set;}
    private Map<String,String> mapDynamicFilter{get;set;}
    public Integer rowToDelete{get;set;}
    public boolean filter {get;set;}
    
    public MassUpdate_Delete()
    {
        rowToDelete = 1;
        filter= true;
        mapDynamicFilter = new Map<String,String>();
        rowCount = 0;
        FilterValue = '';
        wrapperList = new List<addRowWrapper>(); 
        valuetoUpdate = '';
        fieldtoUpdate = '';
        lst = new List<sObject>();
        valueForSearch = '';
        SelectedOperator = '';
        Selectedfield = '';
        listOperators = new List<selectoption>();  
        fieldList = new List<selectoption>();
        listOfObject = new List<SelectOption>();
        List<Schema.SObjectType> gd1 = gd.Values();
        listOfObject.add(new SelectOption('','--None--'));
        fieldList.add(new selectoption('','--None--'));
        listOperators.add(new selectoption('','--None--'));
        for(Schema.SObjectType f : gd1)
        {
            if( (f.getDescribe().isCreateable()) && (f.getDescribe().isAccessible()) && (f.getDescribe().isUpdateable()))
            {
                listOfObject.add(new SelectOption(f.getDescribe().getLocalName(),f.getDescribe().getLabel()));
                listOfObject.sort();
            }
        }
    }
    
    public void members()
    {      
        fieldList.clear();
        sobj = gd.get(objectName);
        System.debug('sobj   '+sobj); 
        sObject newSobject = gd.get(objectName).newSObject() ;
        System.debug('newSobject ::::::  '+newSobject);
        if(sobj != null )
        {
            rowCount = 0;  
            wrapperList.clear();         
            Schema.DescribeSObjectResult all = sobj.getDescribe();
            fieldsMap = new Map<String, Schema.SObjectField>();
            fieldsMap = all.fields.getMap();
            fieldList.add(new selectoption('','--None--'));                                   
            for(Schema.SObjectField fieldName:fieldsMap.Values())
            {
                if( (fieldname.getDescribe().isAccessible()) && (fieldname.getDescribe().isCreateable()) && (fieldname.getDescribe().isUpdateable()))
                {
                    fieldList.add(new selectoption(fieldname.getDescribe().getName(),fieldName.getDescribe().getLabel()));
                }     
            }
            listOperators.clear();
            listOperators.add(new selectoption('','--None--'));
            listOperators.add(new selectoption('=','='));
            listOperators.add(new selectoption('<','<'));
            listOperators.add(new selectoption('<=','<='));
            listOperators.add(new selectoption('>','>'));
            listOperators.add(new selectoption('>=','>='));
            listOperators.add(new selectoption('!=','!='));
            rowCount++;
            for(rowCount=1; rowCount<=5;rowCount++){
                wrapperList.add(new addRowWrapper(fieldList,listOperators,valueForSearch,Selectedfield,SelectedOperator,fieldtoUpdate,valuetoUpdate,rowCount));
            }
             rowCount--;
        }                                        
    }
    public void searchResult() 
    {
        
        lst = new List<sObject>();
        if(objectName == null || objectName == '')
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,+' Please Select atleast One Object '));
        }
        
        if(objectName != null && objectName != '' && (FilterValue == null || FilterValue == '') && wrapperList.size() >= 1)
        {
            for(addRowWrapper obj : wrapperList)
            {
                /*--------- */if((obj.valueForSearchWrap != null && obj.valueForSearchWrap   != '') || (obj.SelectedOperatorWrap != null && obj.SelectedOperatorWrap != '') || (obj.SelectedfieldWrap != null && obj.SelectedfieldWrap != ''))
                {
                    System.debug(' 137 ');
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'Add Filter Logic First' ));
                }/*--------- */
                if((obj.valueForSearchWrap == null || obj.valueForSearchWrap   == '') && (obj.SelectedOperatorWrap == null || obj.SelectedOperatorWrap == '') && (obj.SelectedfieldWrap == null || obj.SelectedfieldWrap == '')) 
                {
                    System.debug(' 142 ');
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Add Filter Logic First' ));
                }
            }
        
            /*--------- */try
            {
                String str = 'select id, name from ' + objectName + ' where ';
                String strTemp = '';
                integer i = 0 ;
                for(addRowWrapper obj : wrapperList)
                {
                    if(i == wrapperList.size())break;
                    if((obj.valueForSearchWrap != null && obj.valueForSearchWrap   != '') && (obj.SelectedOperatorWrap != null && obj.SelectedOperatorWrap != '') && (obj.SelectedfieldWrap != null && obj.SelectedfieldWrap != ''))
                    {
                        strTemp = '';
                        strTemp += + obj.SelectedfieldWrap + ' ' + obj.SelectedOperatorWrap + '\''+ obj.valueForSearchWrap+'\' ' ;
                        if(i == wrapperList.size()){break;}
                        else
                        {
                            strTemp += 'AND'+' ';
                        }
                    }
                    str += strTemp;
                    i++;
                }
                str = str.removeEndIgnoreCase('AND ');
                lst = database.query(str);
                System.debug('lst on 155   ' + str);
                System.debug('lst   '+lst);
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, lst.size() + ' Records Found. ' ));
            }
            catch(Exception e)
            {
                System.debug('161 ---');
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,e.getMessage()));
            }/*--------- */
        }
        
        if((objectName != null && objectName != '') && (FilterValue != null && FilterValue != '') && (wrapperList.size() > 1))
        {
            try
            {
                String strQuery = 'select id, name from '+objectName +' where ';
                String tempFilter = FilterValue;
                String str = '';
                for(addRowWrapper obj : wrapperList) 
                {
                    if((objectName != null && objectName != ''))
                    {
                        String s = obj.SelectedfieldWrap + ' '+ obj.SelectedOperatorWrap +'\''+ obj.valueForSearchWrap+'\'';
                        mapDynamicFilter.put(String.ValueOF(obj.rowCountWrap)+'^',s);
                    }
                              
                } 
                if(mapDynamicFilter != null && mapDynamicFilter.size() > 0)
                {
                    String[] arr = FilterValue.split(' ');
                    String tyagi = '';
                    for(String s : arr)
                    {
                        String ps = s; 
                        if(ps.contains(')')){
                            ps = ps.remove(')');
                            if(ps.isNumeric())
                            {
                                s = ps+'^)';
                            }  
                        }else if(ps.contains('(')){
                            ps = ps.remove('(');
                            if(ps.isNumeric())
                            {
                                s = '('+ps+'^';
                            }  
                        }else{
                            if(s.isNumeric())
                            {
                                s = String.valueOf(s)+'^';
                            }  
                        }
                        tyagi += s +' ';
                    }
                    
                    tempFilter = tyagi;
                    for(Integer i = 1; i <= wrapperList.size() ; i++)
                    {   
                        
                        tempFilter = tempFilter.replace(String.valueOF(i+'^'), mapDynamicFilter.get(String.valueOf(i+'^')));
                    }
                    strQuery += tempFilter;
                    system.debug('test----'+strQuery);
                    lst = database.query(strQuery);
                    System.debug('lst   '+lst);
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, lst.size() +' Records Found'));  
                } 
                  
            }
            catch(Exception e)
            {
                System.debug('251 ---');
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,e.getMessage()));
            }
        }   
    }
    
    public void addRow()
    {
        /*--code to start numbers from Zero after all rows deleted*/
        if(wrapperList.size() == 0)
        {
            rowCount = 0;   
        }
        /*-------------------------------------*/
        
        rowCount++;
        wrapperList.add(new addRowWrapper(fieldList,listOperators,valueForSearch,Selectedfield,SelectedOperator,fieldtoUpdate,valuetoUpdate,rowCount));
    }
    public void deleteRows()
    {
        System.debug('rowToDelete     '+rowToDelete);
        rowToDelete= rowCount;
        rowCount--;
        wrapperList.remove(rowToDelete-1);
        rowToDelete--;
    }
    
    public void addfilter(){
        filter= false;
    }
    public void hidefilter(){
        filter= true;
    }
    public class addRowWrapper
    {
        public String SelectedfieldWrap{get;set;}
        public Integer rowCountWrap{get;set;}
        public String SelectedOperatorWrap{get;set;}
        public List<selectOption> fieldListWrap{get;set;}
        public List<selectOption> listOperatorsWrap{get;set;}
        public String valueForSearchWrap{get;set;}
        public String fieldtoUpdateWrap{get;set;}
        public String valuetoUpdateWrap{get;set;}
        public addRowWrapper(List<selectOption> fieldListWrap,List<selectOption> listOperatorsWrap,String valueForSearchWrap,String SelectedfieldWrap,String SelectedOperatorWrap,String fieldtoUpdateWrap,String valuetoUpdateWrap,Integer rowCountWrap)
        {
            this.rowCountWrap = rowCountWrap;
            this.SelectedfieldWrap = SelectedfieldWrap;
            this.SelectedOperatorWrap = SelectedOperatorWrap;
            this.fieldListWrap = fieldListWrap;
            this.listOperatorsWrap = listOperatorsWrap;
            this.valueForSearchWrap = valueForSearchWrap;
            this.fieldtoUpdateWrap = fieldtoUpdateWrap;
            this.valuetoUpdateWrap = valuetoUpdateWrap;
        }
        
    }

}