public class myOpptyController {

    Public list<WrapperClass> listWrapper{get;set;}
    Public List<OpportunityLineItem> listPriceSelected{get;set;}
    Public List<PricebookEntry> listPrices{get;set;}
    Public String setId{get;set;}
    Public Opportunity opp{get;set;}
    public Boolean check{get;set;}
    public Id objPricebook2Id{get;set;}
    public integer total_size; //used to show user the total size of the list
    public integer counter=0;  //keeps track of the offset
    public integer list_size=5; //sets the page size or number of rows
    public Set<String> idForCheckBox{get;set;}
    public set<PriceBookEntry> contain{get;set;}
    public string searchquery{get;set;}
    
    public myOpptyController() {
        
        listWrapper = new list<WrapperClass>();
        check=false;
        idForCheckBox =new Set<String>();
        contain = new set<PriceBookEntry>();
        listPriceSelected= new List<OpportunityLineItem>();
        setId=ApexPages.currentPage().getParameters().get('Id');
        opp=[Select name from opportunity where Id=:setId];
        system.debug(opp);
        for(Opportunity o:[SELECT Pricebook2Id FROM Opportunity WHERE Id =: setId]){    
            objPricebook2Id=o.Pricebook2Id;
        }
        string searchquery='select count() from PricebookEntry WHERE PriceBook2Id =: objPricebook2Id';  
        total_size=database.countQuery(searchquery);
        finalQuery();
    }
    
    public void finalQuery(){
        
        //string searchquery='Select Product2Id,Product2.Name, Product2.Quantity__c, unitprice, name, product2.Family, pricebook2Id, Pricebook2.Name, ProductCode, product2.Description from PricebookEntry WHERE PriceBook2Id =: objPricebook2Id limit :list_size offset :counter';   
        //listPrices=Database.query(searchquery);
        String searchquery = 'SELECT id';
        for(Schema.FieldSetMember fld :SObjectType.PriceBookEntry.FieldSets.set1.getFields()){
            searchquery += ',' +fld.getFieldPath();
        }
        searchquery += ' from PricebookEntry WHERE PriceBook2Id =: objPricebook2Id limit :list_size offset :counter';
           //searchquery='Select fld.getFieldPath() from PricebookEntry WHERE PriceBook2Id =: objPricebook2Id limit :list_size offset :counter';   
       system.debug('searchquery ' + searchquery);
        listPrices=Database.query(searchquery);
        listWrapper = new list<WrapperClass>();
        for(PricebookEntry cnt:listPrices){
            listWrapper.add(new WrapperClass(cnt));
        }
        for(WrapperClass  Obj : listWrapper )
            {
                if(idForCheckBox.contains(obj.cnt.id))
                {
                    obj.checked= true;    
                }
                else
                    obj.checked= false;   
            }
    }
    
    public void processSelected()
        {
            for(WrapperClass Obj : listWrapper) 
            {                   
                if(obj.checked != false)
                {
                    idForCheckBox.add(obj.cnt.id);
                    contain.add(obj.cnt);
                    //numberOfSelectedXCheckBoxes = idForCheckBox.size() ;                
                }
                
                else if(obj.checked == false)
                {
                    idForCheckBox.remove(obj.cnt.id);
                    //numberOfSelectedXCheckBoxes = idForCheckBox.size();
                }
            }
    }
    Public void sel(){
        processSelected();
        for(PricebookEntry wcl: contain){
         
                OpportunitylineItem oo=new OpportunityLineItem(OpportunityId=setId, PriceBookEntry=wcl, UnitPrice=wcl.unitPrice);
                listPriceSelected.add(oo);
       
   
        }
        check=true;
    
    }
    Public PageReference can(){
        return new PageReference('/'+setId);
    }

    Public PageReference Save(){
        for(integer i=0; i<listPriceSelected.size();i++)
            listPriceSelected[i].PriceBookEntryId = listPriceSelected[i].PriceBookEntry.Id;
        upsert listPriceSelected;
        return new PageReference('/'+setId);
        
    }
    
    Public PageReference Cancel(){
        return new PageReference('/'+setId);
    }
    
    
    public Void Beginning() { //user clicked beginning
        processSelected();
        counter = 0;
        finalQuery();
        
    }
    
    public Void Previous() { //user clicked previous button
          processSelected();
          counter -= list_size;
          finalQuery();
    }
    
    public Void Next() { //user clicked next button
          processSelected();
          counter += list_size;
          finalQuery();
    }
    
    public Void End() { //user clicked end
          processSelected();
          counter = total_size - math.mod(total_size, list_size);
          finalQuery();
    }
    
    public Boolean getDisablePrevious() { 
          //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } 
        else {
            return (total_size/list_size);
        }
    } 
    
    public class WrapperClass{
        public Boolean checked{get;set;}
        public PricebookEntry cnt{get;set;}
        public WrapperClass(PricebookEntry cnt){
           this.cnt=cnt;
           checked=false;
        }
    }  
    
}