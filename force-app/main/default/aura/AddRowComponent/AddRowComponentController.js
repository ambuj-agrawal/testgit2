({
    addRow: function(component, event, helper) {
        helper.addAccountRecord(component, event);
    },
     
    removeRow: function(component, event, helper) {
        //Get the account list
        var accountList = component.get("v.accountList");
        //Get the target object
        var selectedItem = event.currentTarget;
        //Get the selected item index
        var index = selectedItem.dataset.record;
        accountList.splice(index, 1);
        component.set("v.accountList", accountList);
    },
     
    save: function(component, event, helper) {
        if (helper.validateAccountList(component, event)) {
            helper.saveAccountList(component, event);
        }
    },
    
    saveForm: function(component, event, helper) {
	     var len = component.get("v.accountList").length;
        console.log(component.find("editForm"));
         /*component.find("editForm").forEach( form =>{
        form.submit();

    })*/
        var editForms = component.find('editForm');
        var forms = [].concat(editForms || []);
        /* Now here the forms will always be an array, and won't break your code anymore. */
        
        forms.forEach(form => form.submit()); 
        
         }
})