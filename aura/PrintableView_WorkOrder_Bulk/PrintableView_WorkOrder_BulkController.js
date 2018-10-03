({
	init : function(component, event, helper) {
	    var ids = component.get("v.selected");
	    console.log('##ids: '+ids);
	    //ids.push(component.get("v.recordId"));
	    var getStuffAction = component.get('c.doInit');
        getStuffAction.setParams({
            // workOrderId: component.get("v.recordId")
            workOrderIds: ids
        });
        
        getStuffAction.setCallback(this, 
            function(response) {
            	var state = response.getState();
                
            	if (component.isValid() && state === "SUCCESS") {
	                //Create an empty array to store the map keys 
                    var arrayMapKeys = [];
                    //Store the response of apex controller (return map)     
                    var result = response.getReturnValue();
                     
                    for (var key in result) {
                        arrayMapKeys.push(key);
                        console.log('##key:'+key);
                    }
                    //Set the list of keys.     
                    component.set('v.keyList', arrayMapKeys);
                    component.set('v.returnedMap', response.getReturnValue());
                }
            }
        );
        $A.enqueueAction(getStuffAction);
	
	}
})