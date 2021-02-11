({
    doInit : function(component, event, helper) {
        var type=['','ApexClass & ApexTrigger','ValidationRule','WorkflowRule','VisualforcePages','Static Resource','Email Template','Documents','Visualforce Component'];
        component.set("v.metadataType",type);
        component.set("v.selectedMetadata",'ApexClass & ApexTrigger');
       // helper.GetSearchedData(component,event,helper);
    },
    OnSelectChange:function(component,event,helper){
        var selected=event.getSource().get("v.value");
        console.log('selectted: ' +selected);
        component.set("v.searchPlaceHolder",'Search '+selected);
        component.set("v.selectedMetadata",selected);
        if(selected=='--None--'){
            component.set("v.Result",null);
        }else{
            helper.GetSearchedData(component,event,helper);
        }
        
    },
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
    },
    hideSpinner : function(component,event,helper){  
        component.set("v.Spinner", false);
    },
    navigate:function(component,event,helper){
        var idx = event.target.id;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/"+idx,
            "target": "_blank"
        });
        urlEvent.fire();
    },
    SearchMethod:function(component,event,helper){
        var searchKeyWord=event.getSource().get("v.value");
        if(searchKeyWord!='' && searchKeyWord.length > 2){
            helper.SearchItems(component,event,searchKeyWord);
        }else{
            component.set("v.Result",component.get("v.unFilteredResult"));
        }
    }
})