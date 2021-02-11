public with sharing class TableExampleController {
    Public list<WrapperClass> ProductList {get; set;}
    Public set<PriceBookEntry> pbe{get;set;}
    Public String setId{get;set;}
    Public Opportunity opp{get;set;}
    public Boolean check{get;set;}
    public Id objPricebook2Id{get;set;}
    Public List<OpportunityLineItem> listPriceSelected{get;set;}
    
    public Integer ProductSelectedCount {get; set;}
    
    // selection and filter 
    public list<String> AlphaList {get; set;}
    public String AlphaFilter {get; set;}
    private String QueryPriceBook;
    
    // display sort and number
    public String RecPerPage {get; set;}
    public list<SelectOption> RecPerPageOption {get; set;}  
    public String SortFieldSave;
    
    /***
    * TableExampleController - Constructor initialization
    ***/
    public TableExampleController(){
        ProductList = new list<WrapperClass>();
        pbe= new set<PriceBookEntry>();
        check=false;
        listPriceSelected= new List<OpportunityLineItem>();
        setId=ApexPages.currentPage().getParameters().get('Id');
        opp=[Select name from opportunity where Id=:setId];
        
        //records for page initialization
        RecPerPageOption = new list<SelectOption>();
        RecPerPageOption.add(new SelectOption('10','10'));
        RecPerPageOption.add(new SelectOption('25','25'));
        RecPerPageOption.add(new SelectOption('50','50'));
        RecPerPageOption.add(new SelectOption('100','100'));
        RecPerPageOption.add(new SelectOption('200','200'));
        RecPerPage = '10'; //default records per page
        
        // initialization alpha list
        AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
            SortFieldSave = SortField;
        
        // alpha filter, use page parameter or set default to all
        if (apexpages.currentpage().getparameters().get('alpha') == null) {
            AlphaFilter = 'All';
        } else {
            AlphaFilter = apexpages.currentpage().getparameters().get('alpha');
        }
        for(Opportunity o:[SELECT Pricebook2Id FROM Opportunity WHERE Id =: setId]){    
            objPricebook2Id=o.Pricebook2Id;
        }
        // list generation
        BuildQuery();  
    }
    
    /***
    * StdSetControllerAccount - paging through the Account list
    ***/ 
    public ApexPages.StandardSetController StdSetControllerAccount {
        get {
            if(StdSetControllerAccount == null) {
                StdSetControllerAccount = new ApexPages.StandardSetController(Database.getQueryLocator(QueryPriceBook));
                // sets the number of records in each page set
                StdSetControllerAccount.setPageSize(Integer.valueOf(RecPerPage));
            }
            return StdSetControllerAccount;
        }
        set;
    }
    
    /***
    * getCurrentProductList - return an Account list for the table
    ***/  
    public list<WrapperClass> getCurrentProductList() {
        UpdateOppSelectedSet();
        
        ProductList = new list<WrapperClass>();
        for (PriceBookEntry a : (list<PriceBookEntry>)StdSetControllerAccount.getRecords()) {
            ProductList.add(new WrapperClass(a, pbe.contains(a)));
        }
        return ProductList;
    }
    
    /***
    * UpdateOppSelectedSet - add/remove accounts from the selected account id list
    ***/
    public void UpdateOppSelectedSet(){
        for(WrapperClass a : ProductList ){
            if(a.aCheckBox == true) {
                pbe.add(a.aAccount);
                
            } else {
                if(pbe.contains(a.aAccount)) {
                    pbe.remove(a.aAccount);
                }
            }
        }  
        ProductSelectedCount = pbe.size();
    }


    /***
    * BuildQuery - build query command for list selection change
    ***/
    public void BuildQuery() {
        StdSetControllerAccount = null;
        String QueryWhere = '';
        
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
        QueryPriceBook = 'Select Product2Id,Product2.Name, Product2.Quantity__c, unitprice, name, product2.Family, pricebook2Id, Pricebook2.Name, ProductCode, product2.Description from PricebookEntry WHERE PriceBook2Id =: objPricebook2Id'; 
        
        if (AlphaFilter == 'Other') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' < \'A\' OR ' + 
                                    String.escapeSingleQuotes(SortField) + ' > \'Z\') AND (NOT ' + 
                                    String.escapeSingleQuotes(SortField) + ' LIKE \'Z%\') ');
        } else if (AlphaFilter != 'All') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' LIKE \'' + String.escapeSingleQuotes(AlphaFilter) + '%\')' );
        }
 
        QueryPriceBook += QueryWhere;
        QueryPriceBook += ' ORDER BY ' + String.escapeSingleQuotes(SortField) + ' ' + String.escapeSingleQuotes(SortDirection) + ' LIMIT 10000';
        
        system.debug('QueryPriceBook:' + QueryPriceBook);
    }
    
    /***
    * BuildWhere - build soql string for where criteria 
    ***/
    public String BuildWhere(String QW, String Cond) {
        if (QW == '') {
            return ' AND ' + Cond;
        } else {
            return QW + ' AND ' + Cond;
        }
    }
    
    /***
    * SortDirection - return sort direction. Default ascending(asc)
    ***/
    public String SortDirection {
        get { if (SortDirection == null) {  SortDirection = 'asc'; } return SortDirection;  }
        set;
    }
    
    /***
    * SortField - return sort by field. Default to Name
    ***/
    public String SortField {
        get { if (SortField == null) {SortField = 'Name'; } return SortField;  }
        set; 
    }
    
    /***
    * SortToggle - toggles the sorting of query from asc<-->desc
    ***/
    public void SortToggle() {
        SortDirection = SortDirection.equals('asc') ? 'desc NULLS LAST' : 'asc';
        // reset alpha filter and sort sequence when sorted field is changed
        if (SortFieldSave != SortField) {
            SortDirection = 'asc';
            AlphaFilter = 'All';
            SortFieldSave = SortField;
        }
        // run the query again
        BuildQuery();
    }
    Public PageReference can(){
        return new PageReference('/'+setId);
    }
    
    Public void sel(){
        system.debug('sel---->' +pbe.size());
        for (PriceBookEntry AccountId : pbe) {
                 OpportunitylineItem oo=new OpportunityLineItem(OpportunityId=setId, PriceBookEntry=AccountId,UnitPrice=AccountId.unitPrice);
                 listPriceSelected.add(oo);
        }
        check=true;
    }
    Public PageReference Save(){
        for(integer i=0; i<listPriceSelected.size();i++)
            listPriceSelected[i].PriceBookEntryId = listPriceSelected[i].PriceBookEntry.Id;
        upsert listPriceSelected;
        return new PageReference('/'+setId);
        
    }
    Public void Cancel(){
        pbe= new set<PriceBookEntry>();
        pbe.clear();
        system.debug('cancel---->' +pbe.size());
        check=false;
    }
    
    public class WrapperClass {
        public Boolean aCheckBox {get;set;}
        public PricebookEntry aAccount {get;set;}
        
        // sub-class initialization
        public WrapperClass(PricebookEntry a, Boolean chk){
            aAccount = a;
            aCheckBox = chk;
        }
    }
}