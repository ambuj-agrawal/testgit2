({
    doInit : function(component, event, helper) {
        var action = component.get('c.returnStatus');
        action.setParams(
            recId = component.get('v.recordId')  
        );
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS'){
                component.set('v.isShow', response.getReturnValue);
            }
            else{
                
            }
        });
    }
})