public class PrintableView_WorkOrder_BulkController {
    @auraEnabled 
    public static map<String,map<String,String>>doInit(list<Id> workOrderIds){
        system.debug('## we made it');
        // WorkOrder thisWorkOrder = [select AssetId, MaintenancePlanId, SuggestedMaintenanceDate from WorkOrder where Id =: workOrderId];
        // String previousWorkOrderId = [select Id from WorkOrder where MaintenancePlanId =: thisWorkOrder.MaintenancePlanId and SuggestedMaintenanceDate <=: thisWorkOrder.SuggestedMaintenanceDate and Id !=: workOrderId Order By SuggestedMaintenanceDate desc limit 1].Id;
       
        list<WorkOrder> theseWorkOrders = [select AssetId, MaintenancePlanId, SuggestedMaintenanceDate, Work_Order_Name__c from WorkOrder where Id =: workOrderIds];
        
        Date latestSuggestedMaintenanceDate = system.today().addDays(-3560);
        set<Id> maintenancePlanIds = new set<Id>();
        for (WorkOrder wo : theseWorkOrders){
            if (wo.SuggestedMaintenanceDate > latestSuggestedMaintenanceDate){
                latestSuggestedMaintenanceDate = wo.SuggestedMaintenanceDate;
            }
            maintenancePlanIds.add(wo.MaintenancePlanId);
        }
        
        list<WorkOrder> previousWorkOrders = [select Id, SuggestedMaintenanceDate, MaintenancePlanId from WorkOrder where MaintenancePlanId in: maintenancePlanIds and SuggestedMaintenanceDate <=: latestSuggestedMaintenanceDate and Id !=: workOrderIds Order By SuggestedMaintenanceDate asc];
        
        map<String,map<String,String>> workOrderIdsToLabelToValueMap = new map<String,map<String,String>>();
        
        map<String,String> labelToValueMap = new map<String,String>();
        for (WorkOrder thisWorkOrder : theseWorkOrders){
            labelToValueMap = new map<String,String>();
            if(thisWorkOrder.Work_Order_Name__c != null){
                labelToValueMap.put('workOrderName',thisWorkOrder.Work_Order_Name__c);
            }
            if (thisWorkOrder.AssetId != null){
                labelToValueMap.put('assetId',thisWorkOrder.AssetId);
            }
            if(thisWorkOrder.MaintenancePlanId != null){
                labelToValueMap.put('maintenancePlanId',thisWorkOrder.MaintenancePlanId);
            }
            if(thisWorkOrder.SuggestedMaintenanceDate != null){
                labelToValueMap.put('thisWorkOrderSuggestedMaintenanceDate',String.valueOf(thisWorkOrder.SuggestedMaintenanceDate));
            }
            for (WorkOrder previousWorkOrder : previousWorkOrders){
                if (previousWorkOrder.MaintenancePlanId == thisWorkOrder.MaintenancePlanId && previousWorkOrder.SuggestedMaintenanceDate < thisWorkOrder.SuggestedMaintenanceDate){
                    labelToValueMap.put('previousWorkOrderId',previousWorkOrder.Id);
                }
            }
            
            workOrderIdsToLabelToValueMap.put(thisWorkOrder.Id,labelToValueMap);
            
        }
        return workOrderIdsToLabelToValueMap;
        
    }
}