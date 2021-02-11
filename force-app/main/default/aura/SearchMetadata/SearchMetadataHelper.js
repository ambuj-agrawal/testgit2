({
    GetSearchedData : function(component,event,helper) {
        var action=component.get("c.GetMetaData");
        var selectedType=component.get("v.selectedMetadata");
        action.setParams({
            "type": component.get("v.selectedMetadata") 
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                var result=JSON.parse(response.getReturnValue());
                var returnedString = JSON.stringify(response.getReturnValue());
                
                if(returnedString.includes("Unauthorized endpoint, please check Setup")){
                    //alert('Unauthorized end point');
                    var sMsg ='Unauthorized endpoint, please goto Setup->Security->Remote site settings '; 
                    sMsg+='and add a remote site setting (endpoint = https://your_domain-dev-ed.my.salesforce.com/)';
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        mode: 'sticky',
                        message: sMsg,
                        type : 'warning'
                    });
                    toastEvent.fire();
                }
                else{
                    console.log('result size: ' +result.size);
                    console.log('result: '+ JSON.stringify(result));
                    
                    component.set("v.TotalRecReturned",result.size);
                    var arrayData=new Array();
                    if(selectedType=='ApexClass & ApexTrigger'){
                        component.set("v.isApexType",true);
                        for(var i=0; i<result.records.length;i++){
                            if(result.records[i].ApexClassOrTrigger !=null){
                                var str=result.records[i].ApexClassOrTrigger.attributes.url;
                                var rest = str.substring(0, str.lastIndexOf("/") );
                                var Ids = str.substring(str.lastIndexOf("/") + 1, str.length);
                                var mType = rest.substring(rest.lastIndexOf("/") + 1, rest.length);
                                var obj={"Id":Ids,
                                         "Name":result.records[i].ApexClassOrTrigger.Name.toUpperCase(),
                                         "Type":mType,
                                         "NumLinesCovered":result.records[i].NumLinesCovered,
                                         "NumLinesUncovered":result.records[i].NumLinesUncovered};
                                arrayData.push(obj);
                                
                                component.set("v.Result",arrayData);
                                component.set("v.unFilteredResult",arrayData);
                            }
                        }
                    }
                    
                    
                    if(selectedType=='ValidationRule'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].ValidationName,
                                     "TableEnumOrId":result.records[i].ValidationName}
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                    
                    if(selectedType=='WorkflowRule'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].Name,
                                     "TableEnumOrId":result.records[i].TableEnumOrId}
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                    if(selectedType=='VisualforcePages'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].Name,
                                    }
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                    if(selectedType=='Static Resource'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].Name.toUpperCase(),
                                    }
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                    if(selectedType=='Email Template'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].Name.toUpperCase(),
                                    }
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                    if(selectedType=='Documents'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].Name.toUpperCase(),
                                    }
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                    if(selectedType=='Visualforce Component'){
                        component.set("v.isApexType",false);
                        for(var i=0; i<result.records.length;i++){
                            var obj={"Id":result.records[i].Id,
                                     "Name":result.records[i].Name.toUpperCase(),
                                    }
                            arrayData.push(obj);
                        }
                        component.set("v.Result",arrayData);
                        component.set("v.unFilteredResult",arrayData);
                    }
                }
            }
            
        });
        $A.enqueueAction(action);
    },
    SearchItems:function(component,event,searchKey){
        console.log('Search Key: ' +searchKey);
        var arrayForSearch=component.get("v.Result");
        var NameArray=new Array();
        for(var i=0; i<arrayForSearch.length; i++){
            var obj={"Id":arrayForSearch[i].Id,
                     "Name":arrayForSearch[i].Name.toUpperCase(),
                     "Type":arrayForSearch[i].Type,
                     "NumLinesCovered":arrayForSearch[i].NumLinesCovered,
                     "NumLinesUncovered":arrayForSearch[i].NumLinesUncovered};
            NameArray.push(obj);
        }
        var resultArray=new Array();
        for (var j=0; j<NameArray.length; j++) {
            if(searchKey!=''){
                if (NameArray[j].Name.toString().match (searchKey.toUpperCase())) 
                {
                    console.log('Matching: ');
                    resultArray.push(NameArray[j]);
                    component.set("v.Result",resultArray);
                }
            }
            else{
                
            }
        }
    }
})