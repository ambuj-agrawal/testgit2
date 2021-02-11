({
    // Load items from Salesforce
    doInit: function(component, event, helper) {
        
        // Create the action
        var action = component.get("c.getItems");
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    
    handleAddItem: function(component, event, helper) {
        //   var newItem = event.getParam("item");
        //helper.addItem(component, newItem);
        //
        var item = event.getParam("item");

        helper.createItem(component, item);
        var action = component.get("c.saveItem");
        action.setParams({"item": newItem});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                // all good, nothing to do.
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
            }
        });
        $A.enqueueAction(action);
    },
    
    clickCreateItem : function(component, event, helper) {
        var validItem = component.find('campingform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        var validExpense = component.find('itemform').reduce(function (validSoFar, inputCmp) {
						inputCmp.showHelpMessageIfInvalid();
						return validSoFar && inputCmp.get('v.validity').valid;
					}, true);
        if(validItem && validExpense){
            var newI = component.get("v.newItem");
            var theItems = component.get("v.items");
            var Item = JSON.parse(JSON.stringify(newI));
            theItems.push(Item);
            component.set("v.items", theItems);
            component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                                       'Price__c': 0,'Packed__c': false });
        }
    }
    
    
})