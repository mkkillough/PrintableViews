({
	init : function(component, event, helper) {
        var getMaintenancePlanIdAction = component.get('c.getMaintenancePlanId');
        getMaintenancePlanIdAction.setParams({
            workOrderId: component.get("v.recordId")
        });
        
        getMaintenancePlanIdAction.setCallback(this, 
            function(response) {
            	var state = response.getState();
            	if (component.isValid() && state === "SUCCESS") {
            	    var maintenancePlanId = response.getReturnValue();
	                component.set("v.maintenancePlanId",maintenancePlanId);
                }
            }
        );
        $A.enqueueAction(getMaintenancePlanIdAction);
        
        
         var getPreviousWorkOrderIdAction = component.get('c.getPreviousWorkOrderId');
        getPreviousWorkOrderIdAction.setParams({
            workOrderId: component.get("v.recordId")
        });
        
        getPreviousWorkOrderIdAction.setCallback(this, 
            function(response) {
            	var state = response.getState();
                console.log('##previousWorkOrderId: '+response.getReturnValue());
            	if (component.isValid() && state === "SUCCESS") {
	                component.set("v.previousWorkOrderId",response.getReturnValue());
                }
            }
        );
        $A.enqueueAction(getPreviousWorkOrderIdAction);
        
        
        var getAssetIdAction = component.get('c.getAssetId');
        getAssetIdAction.setParams({
            workOrderId: component.get("v.recordId")
        });
        
        getAssetIdAction.setCallback(this, 
            function(response) {
            	var state = response.getState();
                
            	if (component.isValid() && state === "SUCCESS") {
	                component.set("v.assetId",response.getReturnValue());
                }
            }
        );
        $A.enqueueAction(getAssetIdAction);
        
       
	
	}
})