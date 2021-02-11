({
    afterScriptsLoaded : function(component, event, helper) 
    {
        helper.doInit(component,event,helper);
    },

    clear1 : function(component, event, helper)   {
        $('#linechart').highcharts().destroy();
        //component.find("chart").getElement().highcharts().destroy();
    } 
    
})